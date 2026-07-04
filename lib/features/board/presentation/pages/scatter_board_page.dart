import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/providers/viewport_provider.dart';
import '../../../../core/providers/tiles_provider.dart';
import '../widgets/chroma_tile_widget.dart';
import '../widgets/radial_menu_widget.dart';
import '../widgets/familiar_widget.dart';
import '../widgets/satellite_flight_renderer_widget.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/models/chroma_tile.dart';

class ScatterBoardPage extends ConsumerStatefulWidget {
  const ScatterBoardPage({super.key});

  @override
  ConsumerState<ScatterBoardPage> createState() => _ScatterBoardPageState();
}

class _ScatterBoardPageState extends ConsumerState<ScatterBoardPage> with TickerProviderStateMixin {
  double _startZoom = 1.0;
  bool _isMenuOpen = false;
  String _activeColor = '#FFEF00'; // Canary default
  double _activeThickness = 3.0;
  bool _isOrbitMode = false;
  late final AnimationController _cameraController;
  late final AnimationController _flightAnimController;
  VoidCallback? _cameraListener;
  SatelliteFlightState _flightState = SatelliteFlightState.idle;

  @override
  void initState() {
    super.initState();
    _cameraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _flightAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _flightAnimController.dispose();
    super.dispose();
  }

  void _triggerSatelliteFlight(String type, Offset target, String colorHex, VoidCallback onImpact) {
    setState(() {
      _flightState = SatelliteFlightState(
        phase: 'outgoing',
        type: type,
        targetPos: target,
        colorHex: colorHex,
      );
    });
    
    _flightAnimController.forward(from: 0.0).then((_) {
      onImpact();
      setState(() {
         _flightState = SatelliteFlightState(
           phase: 'none',
           type: 'none',
           targetPos: Offset.zero,
           colorHex: colorHex,
         );
      });
    });
  }

  void _animateCamera(double targetX, double targetY, double targetZoom) {
    final startX = ref.read(viewportStateProvider).x;
    final startY = ref.read(viewportStateProvider).y;
    final startZoom = ref.read(viewportStateProvider).zoom;
    
    final curved = CurvedAnimation(parent: _cameraController, curve: Curves.easeOutCubic);
    
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

  @override
  Widget build(BuildContext context) {
    final viewport = ref.watch(viewportStateProvider);
    final tiles = ref.watch(tilesStateProvider);
    final activeTilesCount = tiles.where((t) => !t.isArchived).length;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onScaleStart: (details) {
          _startZoom = ref.read(viewportStateProvider).zoom;
        },
        onScaleUpdate: (details) {
          final currentViewport = ref.read(viewportStateProvider);
          
          if (details.scale == 1.0) {
            // Panning only (No need to divide by zoom since Transform.translate is applied first)
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
        },
        child: Container(
          color: Colors.transparent, // Capture all gestures
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Infinite Reference Dot Grid Pattern
              CustomPaint(
                painter: _DotGridPainter(
                  isDarkMode: isDarkMode,
                  viewportX: viewport.x,
                  viewportY: viewport.y,
                  zoom: viewport.zoom,
                ),
                child: Container(),
              ),
              
              // Here is where the ChromaTiles will go, positioned based on viewport
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(viewport.x, viewport.y),
                  child: Transform.scale(
                    scale: viewport.zoom,
                    alignment: Alignment.topLeft,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ...tiles.map((tile) {
                          return ChromaTileWidget(
                            key: ValueKey(tile.id),
                            tile: tile,
                            isDarkMode: isDarkMode,
                            zoomScale: viewport.zoom,
                            onDrag: (id, dx, dy) {
                              ref.read(tilesStateProvider.notifier).updateTilePosition(id, dx / viewport.zoom, dy / viewport.zoom);
                            },
                            onTap: (id) {
                              // Focus mode handled later
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),

              // Top HUD Info
              Positioned(
                top: 24,
                left: 24, // Matching web app's top-6 left-6
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
                          Icon(LucideIcons.grid, size: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            'Zoom: ${(viewport.zoom * 100).round()}%',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•', 
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 9, 
                              color: Theme.of(context).colorScheme.onSurfaceVariant
                            )
                          ),
                          const SizedBox(width: 8),
                          Icon(LucideIcons.layers, size: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            'Active: $activeTilesCount',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // The Gamified Spatial Familiar System (Animated reactive positioning)
              TweenAnimationBuilder<Offset>(
                duration: const Duration(milliseconds: 550),
                curve: Curves.easeOutBack,
                tween: Tween<Offset>(
                  begin: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height - 56),
                  end: Offset(
                    (MediaQuery.of(context).size.width / 2) + (_isMenuOpen ? -205.0 : 0.0),
                    MediaQuery.of(context).size.height - 56,
                  ),
                ),
                builder: (context, animatedFamiliarPos, child) {
                  return Stack(
                    children: [
                      // Radial Menu
                      RadialMenuWidget(
                        isDarkMode: isDarkMode,
                        onToggleDarkMode: () {
                          _triggerSatelliteFlight('theme', animatedFamiliarPos, _activeColor, () {
                            final currentTheme = ref.read(themeModeProvider);
                            ref.read(themeModeProvider.notifier).state = 
                                currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                          });
                        },
                        activeColor: _activeColor,
                        onColorChange: (c) => setState(() => _activeColor = c),
                        activeThickness: _activeThickness,
                        onThicknessChange: (t) => setState(() => _activeThickness = t),
                        onAddTile: (clusterId, colorHex) {
                          final screenSize = MediaQuery.of(context).size;
                          final spawnTarget = Offset(screenSize.width / 2, screenSize.height / 2);
                          
                          _triggerSatelliteFlight('spawn', spawnTarget, colorHex, () {
                            final newTile = ChromaTile(
                              id: 'tile-${DateTime.now().millisecondsSinceEpoch}',
                              x: -viewport.x + (MediaQuery.of(context).size.width / 2) / viewport.zoom - 140,
                              y: -viewport.y + (MediaQuery.of(context).size.height / 2) / viewport.zoom - 110,
                              width: 280,
                              height: 220,
                              colorName: 'custom',
                              colorHex: colorHex,
                              title: 'New Note',
                              content: '',
                              strokes: [],
                              isArchived: false,
                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            );
                            ref.read(tilesStateProvider.notifier).addTile(newTile);
                          });
                        },
                        onClearCanvas: () {
                          ref.read(tilesStateProvider.notifier).clear();
                        },
                        onResetCamera: () {
                          _triggerSatelliteFlight('recenter', animatedFamiliarPos, _activeColor, () {
                            _animateCamera(0, 0, 1.0);
                            if (_isOrbitMode) {
                              setState(() => _isOrbitMode = false);
                            }
                          });
                        },
                        isOrbitMode: _isOrbitMode,
                        onDoubleTapMenu: () {
                          setState(() {
                            _isOrbitMode = !_isOrbitMode;
                            if (_isOrbitMode) {
                              // Bird's eye / microview
                              final screenSize = MediaQuery.of(context).size;
                              _animateCamera(
                                screenSize.width / 2, 
                                screenSize.height / 2, 
                                0.2
                              );
                            } else {
                              _animateCamera(0, 0, 1.0);
                            }
                          });
                        },
                        zoom: viewport.zoom,
                        onZoomChange: (z) {
                          ref.read(viewportStateProvider.notifier).updateViewport(zoom: z);
                        },
                        isMenuOpen: _isMenuOpen,
                        onToggleMenu: () => setState(() => _isMenuOpen = !_isMenuOpen),
                        familiarX: animatedFamiliarPos.dx,
                      ),

                      // Familiar Orb
                      FamiliarWidget(
                        state: FamiliarState.idle,
                        position: animatedFamiliarPos,
                        isDarkMode: isDarkMode,
                        isSatelliteFlying: false,
                        onOrbClick: () => setState(() => _isMenuOpen = !_isMenuOpen),
                      ),

                      // Satellite Flight Renderer
                      AnimatedBuilder(
                        animation: _flightAnimController,
                        builder: (context, child) {
                          return SatelliteFlightRendererWidget(
                            flight: _flightState,
                            familiarPos: animatedFamiliarPos,
                            isDarkMode: isDarkMode,
                            isMenuOpen: _isMenuOpen,
                            zoomScale: viewport.zoom,
                            screenSize: MediaQuery.of(context).size,
                            selectedTileScreenPos: null, // to be updated when focus mode works
                            flightProgress: _flightAnimController.value,
                          );
                        }
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final bool isDarkMode;
  final double viewportX;
  final double viewportY;
  final double zoom;

  _DotGridPainter({
    required this.isDarkMode,
    required this.viewportX,
    required this.viewportY,
    required this.zoom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double spacing = 24.0 * zoom;
    double radius = 1.0 * zoom;

    // Performance fix: when zoomed out significantly (like in orbit mode), 
    // the spacing becomes extremely small, causing hundreds of thousands of dots to be drawn.
    // We scale up the spacing by powers of 2 to keep density manageable.
    while (spacing < 16.0) {
      spacing *= 2.0;
    }

    // Ensure dots are always visible even when heavily zoomed out
    if (radius < 1.0) {
      radius = 1.0;
    }
    
    // Web app dot styling
    // Light mode opacity increased for better visibility
    final paint = Paint()
      ..color = isDarkMode 
          ? Colors.white.withValues(alpha: 0.10) 
          : Colors.black.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    // Calculate the offset based on viewport translation
    // We use modulo to create the infinite repeating effect
    final double offsetX = (viewportX * zoom) % spacing;
    final double offsetY = (viewportY * zoom) % spacing;

    for (double x = offsetX; x < size.width + spacing; x += spacing) {
      for (double y = offsetY; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) {
    return oldDelegate.isDarkMode != isDarkMode ||
           oldDelegate.viewportX != viewportX ||
           oldDelegate.viewportY != viewportY ||
           oldDelegate.zoom != zoom;
  }
}
