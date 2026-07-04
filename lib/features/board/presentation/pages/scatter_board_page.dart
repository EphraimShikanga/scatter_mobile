import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/providers/viewport_provider.dart';
import '../../../../core/providers/tiles_provider.dart';
import '../widgets/chroma_tile_widget.dart';
import '../widgets/radial_menu_widget.dart';
import '../widgets/familiar_widget.dart';
import '../widgets/satellite_flight_renderer_widget.dart';
import '../../../../core/models/chroma_tile.dart';

class ScatterBoardPage extends ConsumerStatefulWidget {
  const ScatterBoardPage({super.key});

  @override
  ConsumerState<ScatterBoardPage> createState() => _ScatterBoardPageState();
}

class _ScatterBoardPageState extends ConsumerState<ScatterBoardPage> {
  double _startZoom = 1.0;
  bool _isMenuOpen = false;
  String _activeColor = '#FFEF00'; // Canary default
  double _activeThickness = 3.0;

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
            // Panning only
            ref.read(viewportStateProvider.notifier).updateViewport(
              x: currentViewport.x + details.focalPointDelta.dx / currentViewport.zoom,
              y: currentViewport.y + details.focalPointDelta.dy / currentViewport.zoom,
            );
          } else {
            // Zooming and Panning
            ref.read(viewportStateProvider.notifier).updateViewport(
              x: currentViewport.x + details.focalPointDelta.dx / currentViewport.zoom,
              y: currentViewport.y + details.focalPointDelta.dy / currentViewport.zoom,
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
                        onToggleDarkMode: () {},
                        activeColor: _activeColor,
                        onColorChange: (c) => setState(() => _activeColor = c),
                        activeThickness: _activeThickness,
                        onThicknessChange: (t) => setState(() => _activeThickness = t),
                        onAddTile: (clusterId) {
                          final newTile = ChromaTile(
                            id: 'tile-${DateTime.now().millisecondsSinceEpoch}',
                            x: -viewport.x + (MediaQuery.of(context).size.width / 2) / viewport.zoom - 140,
                            y: -viewport.y + (MediaQuery.of(context).size.height / 2) / viewport.zoom - 110,
                            width: 280,
                            height: 220,
                            colorName: 'custom',
                            colorHex: _activeColor,
                            title: 'New Note',
                            content: '',
                            strokes: [],
                            isArchived: false,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          );
                          ref.read(tilesStateProvider.notifier).addTile(newTile);
                        },
                        onClearCanvas: () {
                          ref.read(tilesStateProvider.notifier).clear();
                        },
                        onResetCamera: () {
                          ref.read(viewportStateProvider.notifier).reset();
                        },
                        isOrbitMode: false,
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
                      SatelliteFlightRendererWidget(
                        flight: SatelliteFlightState.idle,
                        familiarPos: animatedFamiliarPos,
                        isDarkMode: isDarkMode,
                        isMenuOpen: _isMenuOpen,
                        zoomScale: viewport.zoom,
                        screenSize: MediaQuery.of(context).size,
                        selectedTileScreenPos: null, // to be updated when focus mode works
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
    final double spacing = 24.0 * zoom;
    final double radius = 1.0 * zoom;
    
    // Web app dot styling
    // Light: rgba(0,0,0,0.04), Dark: rgba(255,255,255,0.06)
    final paint = Paint()
      ..color = isDarkMode 
          ? Colors.white.withValues(alpha: 0.06) 
          : Colors.black.withValues(alpha: 0.04)
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
