import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/providers/viewport_provider.dart';
import '../../../../core/providers/tiles_provider.dart';

class ScatterBoardPage extends ConsumerStatefulWidget {
  const ScatterBoardPage({super.key});

  @override
  ConsumerState<ScatterBoardPage> createState() => _ScatterBoardPageState();
}

class _ScatterBoardPageState extends ConsumerState<ScatterBoardPage> {
  double _startZoom = 1.0;

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
                        // Tiles will be rendered here later
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
