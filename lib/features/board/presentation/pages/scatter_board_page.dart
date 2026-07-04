import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/viewport_provider.dart';
import '../../../../core/providers/tiles_provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../widgets/chroma_tile_widget.dart';
import '../widgets/hit_test_stack.dart';
import '../widgets/radial_menu_widget.dart';
import '../widgets/familiar_widget.dart';
import '../widgets/satellite_flight_renderer_widget.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/models/chroma_tile.dart';
import '../widgets/dot_grid_painter.dart';
import '../widgets/focused_writing_board.dart';

class ScatterBoardPage extends ConsumerStatefulWidget {
  const ScatterBoardPage({super.key});

  @override
  ConsumerState<ScatterBoardPage> createState() => _ScatterBoardPageState();
}

class _ScatterBoardPageState extends ConsumerState<ScatterBoardPage>
    with TickerProviderStateMixin {
  double _startZoom = 1.0;
  bool _isMenuOpen = false;
  String _activeColor = 'rainbow'; // Rainbow default
  double _activeThickness = 3.0;
  bool _isOrbitMode = false;
  late final AnimationController _cameraController;
  late final AnimationController _flightAnimController;
  VoidCallback? _cameraListener;
  SatelliteFlightState _flightState = SatelliteFlightState.idle;

  // ── Lifecycle ──────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _cameraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _flightAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _flightAnimController.dispose();
    super.dispose();
  }

  // ── Satellite Flight Logic ─────────────────────────────────────────────

  void _triggerSatelliteFlight(
    String type,
    Offset target,
    String colorHex,
    Future<void> Function() onImpact,
  ) {
    setState(() {
      _flightState = SatelliteFlightState(
        phase: 'outgoing',
        type: type,
        targetPos: target,
        colorHex: colorHex,
      );
    });

    _flightAnimController.forward(from: 0.0).then((_) async {
      await onImpact();
      if (!mounted) return;
      setState(() {
        _flightState = SatelliteFlightState(
          phase: 'returning',
          type: type,
          targetPos: target,
          colorHex: colorHex,
        );
      });
      _flightAnimController.reverse(from: 1.0).then((_) {
        if (!mounted) return;
        setState(() {
          _flightState = SatelliteFlightState(
            phase: 'none',
            type: 'none',
            targetPos: Offset.zero,
            colorHex: colorHex,
          );
        });
      });
    });
  }

  // ── Camera Animation Logic ────────────────────────────────────────────

  void _animateCamera(double targetX, double targetY, double targetZoom) {
    final currentViewport = ref.read(viewportStateProvider);
    final startX = currentViewport.x;
    final startY = currentViewport.y;
    final startZoom = currentViewport.zoom;

    final curved = CurvedAnimation(
      parent: _cameraController,
      curve: Curves.easeOutCubic,
    );

    if (_cameraListener != null) {
      _cameraController.removeListener(_cameraListener!);
    }

    _cameraListener = () {
      ref.read(viewportStateProvider.notifier).updateViewport(
            x: startX + (targetX - startX) * curved.value,
            y: startY + (targetY - startY) * curved.value,
            zoom: startZoom + (targetZoom - startZoom) * curved.value,
          );
    };
    _cameraController.addListener(_cameraListener!);
    _cameraController.forward(from: 0);
  }

  // ── Gesture Callbacks ─────────────────────────────────────────────────

  void _onScaleStart(ScaleStartDetails details) {
    _startZoom = ref.read(viewportStateProvider).zoom;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final currentViewport = ref.read(viewportStateProvider);

    if (details.scale == 1.0) {
      // Panning only
      ref.read(viewportStateProvider.notifier).updateViewport(
            x: currentViewport.x + details.focalPointDelta.dx,
            y: currentViewport.y + details.focalPointDelta.dy,
          );
    } else {
      // Zooming and Panning
      ref.read(viewportStateProvider.notifier).updateViewport(
            x: currentViewport.x + details.focalPointDelta.dx,
            y: currentViewport.y + details.focalPointDelta.dy,
            zoom: (_startZoom * details.scale).clamp(0.15, 2.0),
          );
    }
  }

  // ── Radial Menu Callbacks ─────────────────────────────────────────────

  void _onColorChange(String c) => setState(() => _activeColor = c);
  void _onThicknessChange(double t) => setState(() => _activeThickness = t);
  void _onToggleMenu() => setState(() => _isMenuOpen = !_isMenuOpen);

  void _onClearCanvas() {
    ref.read(tilesStateProvider.notifier).clear();
  }

  void _onZoomChange(double z) {
    ref.read(viewportStateProvider.notifier).updateViewport(zoom: z);
  }

  void _onToggleOrbitMode() {
    setState(() {
      _isOrbitMode = !_isOrbitMode;
      if (_isOrbitMode) {
        final screenSize = MediaQuery.of(context).size;
        _animateCamera(
          screenSize.width / 2,
          screenSize.height / 2,
          0.2,
        );
      } else {
        _animateCamera(0, 0, 1.0);
      }
    });
  }

  void _onResetCamera(Offset familiarPos) {
    _triggerSatelliteFlight(
      'recenter',
      familiarPos,
      _activeColor,
      () async {
        _animateCamera(0, 0, 1.0);
        if (_isOrbitMode) {
          setState(() => _isOrbitMode = false);
        }
      },
    );
  }

  void _onAddTile(String clusterId, String colorHex) {
    final screenSize = MediaQuery.of(context).size;
    final spawnTarget = Offset(
      screenSize.width / 2,
      screenSize.height / 2,
    );

    String spawnColor = colorHex;
    if (colorHex == 'rainbow') {
      final random = math.Random();
      spawnColor =
          '#${(random.nextDouble() * 0xFFFFFF).toInt().toRadixString(16).padLeft(6, '0')}';
    }

    _triggerSatelliteFlight(
      'spawn',
      spawnTarget,
      spawnColor,
      () async {
        final viewport = ref.read(viewportStateProvider);
        final newTile = ChromaTile(
          id: 'tile-${DateTime.now().millisecondsSinceEpoch}',
          x: (screenSize.width / 2 - viewport.x) / viewport.zoom - 140,
          y: (screenSize.height / 2 - viewport.y) / viewport.zoom - 110,
          width: 280,
          height: 220,
          colorName: 'custom',
          colorHex: spawnColor,
          title: 'New Note',
          content: '',
          strokes: [],
          isArchived: false,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        ref.read(tilesStateProvider.notifier).addTile(newTile);
      },
    );
  }

  void _onToggleDarkMode(BuildContext switcherContext) {
    final screenSize = MediaQuery.of(context).size;
    final random = math.Random();
    final themeTarget = Offset(
      random.nextDouble() * screenSize.width,
      random.nextDouble() * screenSize.height,
    );

    _triggerSatelliteFlight(
      'theme',
      themeTarget,
      _activeColor,
      () async {
        final currentTheme = ref.read(themeModeProvider);
        final nextThemeMode = currentTheme == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;

        final renderBox =
            switcherContext.findRenderObject() as RenderBox?;
        final globalPos =
            renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final localTarget = themeTarget - globalPos;
        final completer = Completer<void>();

        // Trigger seamless package transition
        ThemeSwitcher.of(switcherContext).updateThemeMode(
          animateTransition: true,
          themeMode: nextThemeMode,
          offset: localTarget,
          onAnimationFinish: () {
            completer.complete();
          },
          isReversed: nextThemeMode == ThemeMode.light,
        );

        // Sync Riverpod state
        ref.read(themeModeProvider.notifier).state = nextThemeMode;

        // Wait exactly for the transition to finish
        await completer.future;
      },
    );
  }

  // ── Tile Drag Callback ────────────────────────────────────────────────

  void _onTileDrag(String id, double dx, double dy) {
    final zoom = ref.read(viewportStateProvider).zoom;
    ref.read(tilesStateProvider.notifier).updateTilePosition(
          id,
          dx / zoom,
          dy / zoom,
        );
  }

  // ── Focus Mode (Double Tap) ───────────────────────────────────────────

  void _onTileDoubleTap(String id) {
    final tiles = ref.read(tilesStateProvider);
    final tile = tiles.firstWhere((t) => t.id == id);

    // Close menu when entering focus mode
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: FocusedWritingBoard(
                tile: tile,
                activeColor: _activeColor,
                activeThickness: _activeThickness,
                onColorChange: _onColorChange,
                onThicknessChange: _onThicknessChange,
                onSave: ({required title, required content, required strokes}) {
                  ref.read(tilesStateProvider.notifier).updateTile(
                    id,
                    title: title,
                    content: content,
                    strokes: strokes,
                  );
                  Navigator.of(context).pop();
                },
                onCancel: () => Navigator.of(context).pop(),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              child: Container(
                color: Colors.transparent, // Capture all gestures
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    // ── Infinite Reference Dot Grid ──
                    Consumer(
                      builder: (context, ref, _) {
                        final viewport = ref.watch(viewportStateProvider);
                        return CustomPaint(
                          painter: DotGridPainter(
                            isDarkMode: isDarkMode,
                            viewportX: viewport.x,
                            viewportY: viewport.y,
                            zoom: viewport.zoom,
                          ),
                          child: const SizedBox.expand(),
                        );
                      },
                    ),

                    // ── Tile Canvas ──
                    Consumer(
                      builder: (context, ref, _) {
                        final viewport = ref.watch(viewportStateProvider);
                        final tiles = ref.watch(tilesStateProvider);
                        return Positioned.fill(
                          child: Transform.translate(
                            offset: Offset(viewport.x, viewport.y),
                            child: Transform.scale(
                              scale: viewport.zoom,
                              alignment: Alignment.topLeft,
                              child: HitTestStack(
                                clipBehavior: Clip.none,
                                children: [
                                  for (final tile in tiles)
                                    ChromaTileWidget(
                                      key: ValueKey(tile.id),
                                      tile: tile,
                                      isDarkMode: isDarkMode,
                                      zoomScale: viewport.zoom,
                                      onDrag: _onTileDrag,
                                      onTap: (id) {},
                                      onDoubleTap: _onTileDoubleTap,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // ── Top HUD Info ──
                    Consumer(
                      builder: (context, ref, _) {
                        final viewport = ref.watch(viewportStateProvider);
                        final tiles = ref.watch(tilesStateProvider);
                        final activeTilesCount =
                            tiles.where((t) => !t.isArchived).length;
                        return _buildHud(context, viewport.zoom, activeTilesCount);
                      },
                    ),

                    // ── Familiar System + Radial Menu + Satellite ──
                    Consumer(
                      builder: (context, ref, _) {
                        final viewport = ref.watch(viewportStateProvider);
                        return _buildFamiliarSystem(
                          context,
                          isDarkMode: isDarkMode,
                          viewportZoom: viewport.zoom,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ), // end GestureDetector
          ); // end Scaffold
        },
      ), // end Builder
    ); // end ThemeSwitchingArea
  }

  // ── HUD Widget Builder ────────────────────────────────────────────────

  Widget _buildHud(BuildContext context, double zoom, int activeTilesCount) {
    final onSurfaceVariant =
        Theme.of(context).colorScheme.onSurfaceVariant;
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 10,
          color: onSurfaceVariant,
        );

    return Positioned(
      top: 24,
      left: 24,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SCATTER',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(LucideIcons.grid, size: 10, color: onSurfaceVariant),
                const SizedBox(width: 4),
                Text('Zoom: ${(zoom * 100).round()}%', style: labelStyle),
                const SizedBox(width: 8),
                Text(
                  '•',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 9,
                        color: onSurfaceVariant,
                      ),
                ),
                const SizedBox(width: 8),
                Icon(LucideIcons.layers, size: 10, color: onSurfaceVariant),
                const SizedBox(width: 4),
                Text('Active: $activeTilesCount', style: labelStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Familiar System Builder ───────────────────────────────────────────

  Widget _buildFamiliarSystem(
    BuildContext context, {
    required bool isDarkMode,
    required double viewportZoom,
  }) {
    final screenSize = MediaQuery.of(context).size;

    return TweenAnimationBuilder<Offset>(
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutBack,
      tween: Tween<Offset>(
        begin: Offset(screenSize.width / 2, screenSize.height - 56),
        end: Offset(
          (screenSize.width / 2) + (_isMenuOpen ? -205.0 : 0.0),
          screenSize.height - 56,
        ),
      ),
      builder: (context, animatedFamiliarPos, child) {
        return Stack(
          children: [
            // Radial Menu
            ThemeSwitcher(
              builder: (switcherContext) {
                return RadialMenuWidget(
                  isDarkMode: isDarkMode,
                  onToggleDarkMode: () => _onToggleDarkMode(switcherContext),
                  activeColor: _activeColor,
                  onColorChange: _onColorChange,
                  activeThickness: _activeThickness,
                  onThicknessChange: _onThicknessChange,
                  onAddTile: _onAddTile,
                  onClearCanvas: _onClearCanvas,
                  onResetCamera: () => _onResetCamera(animatedFamiliarPos),
                  isOrbitMode: _isOrbitMode,
                  onDoubleTapMenu: _onToggleOrbitMode,
                  zoom: viewportZoom,
                  onZoomChange: _onZoomChange,
                  isMenuOpen: _isMenuOpen,
                  onToggleMenu: _onToggleMenu,
                  familiarX: animatedFamiliarPos.dx,
                );
              },
            ),

            // Familiar Orb
            FamiliarWidget(
              state: FamiliarState.idle,
              position: animatedFamiliarPos,
              isDarkMode: isDarkMode,
              isSatelliteFlying: false,
              onOrbClick: _onToggleMenu,
            ),

            // Satellite Flight Renderer
            AnimatedBuilder(
              animation: _flightAnimController,
              builder: (context, child) {
                final curvedProgress = CurvedAnimation(
                  parent: _flightAnimController,
                  curve: Curves.easeInOutCubic,
                ).value;

                return SatelliteFlightRendererWidget(
                  flight: _flightState,
                  familiarPos: animatedFamiliarPos,
                  isDarkMode: isDarkMode,
                  isMenuOpen: _isMenuOpen,
                  zoomScale: viewportZoom,
                  screenSize: screenSize,
                  selectedTileScreenPos: null,
                  activeMenuColorHex: _activeColor,
                  flightProgress: curvedProgress,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
