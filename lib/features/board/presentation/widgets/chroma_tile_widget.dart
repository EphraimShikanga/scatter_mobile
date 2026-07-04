import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/models/chroma_tile.dart';
import '../../../../core/models/stroke.dart' as model_stroke;
import '../../../../core/theme/app_colors.dart';

class ChromaTileWidget extends ConsumerStatefulWidget {
  final ChromaTile tile;
  final bool isDarkMode;
  final double zoomScale;
  final Function(String id, double dx, double dy) onDrag;
  final Function(String id) onTap;

  const ChromaTileWidget({
    super.key,
    required this.tile,
    required this.isDarkMode,
    required this.zoomScale,
    required this.onDrag,
    required this.onTap,
  });

  @override
  ConsumerState<ChromaTileWidget> createState() => _ChromaTileWidgetState();
}

class _ChromaTileWidgetState extends ConsumerState<ChromaTileWidget> {
  // Parsing the hex string (e.g., "#FFEF00" to Color)
  Color _parseColor(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  void _handlePointerDown(PointerDownEvent event) {
    // We only care about touch and stylus for sketching/interacting inside
    if (event.kind == PointerDeviceKind.stylus || event.kind == PointerDeviceKind.touch) {
      // Logic for drawing start could be dispatched to a provider here
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (event.kind == PointerDeviceKind.stylus || event.kind == PointerDeviceKind.touch) {
      // Logic for drawing move
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (event.kind == PointerDeviceKind.stylus || event.kind == PointerDeviceKind.touch) {
      // Logic for drawing end
    }
  }

  double getRotationAngle(String id) {
    int hash = 0;
    for (int i = 0; i < id.length; i++) {
      hash = id.codeUnitAt(i) + ((hash << 5) - hash);
    }
    double angleDeg = (hash % 5) / 3.0; 
    return angleDeg * (3.1415926535897932 / 180.0); // Convert to radians
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _parseColor(widget.tile.colorHex);
    final borderColor = widget.isDarkMode 
        ? Colors.white.withValues(alpha: 0.08) 
        : Colors.black.withValues(alpha: 0.08);

    return Positioned(
      left: widget.tile.x,
      top: widget.tile.y,
      width: widget.tile.width,
      height: widget.tile.height,
      child: Transform.rotate(
        angle: getRotationAngle(widget.tile.id),
        child: Listener(
          onPointerDown: _handlePointerDown,
          onPointerMove: _handlePointerMove,
          onPointerUp: _handlePointerUp,
          child: GestureDetector(
            onPanUpdate: (details) {
              widget.onDrag(widget.tile.id, details.delta.dx, details.delta.dy);
            },
            onTap: () => widget.onTap(widget.tile.id),
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16), // rounded-2xl
                border: Border.all(color: borderColor, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06), // shadow-[0_4px_16px_rgba(0,0,0,0.06)]
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Header (Integrated)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.015), // bg-black/[0.015]
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // px-3 py-2
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(LucideIcons.gripVertical, size: 13, color: AppColors.tileIcon), // size 13
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      widget.tile.title.toUpperCase(),
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            fontSize: 11, // text-[11px]
                                            fontWeight: FontWeight.bold, // font-bold
                                            letterSpacing: 0.5, // tracking-wider
                                            color: AppColors.tileText.withValues(alpha: 0.6), // text-neutral-900/60
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!widget.tile.isSunk)
                              Opacity(
                                opacity: 0.3, // opacity-30
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.minimize2, size: 11, color: AppColors.tileText),
                                    const SizedBox(width: 6),
                                    Icon(LucideIcons.anchor, size: 11, color: AppColors.tileText),
                                    const SizedBox(width: 6),
                                    Icon(LucideIcons.maximize2, size: 11, color: AppColors.tileText),
                                    const SizedBox(width: 6),
                                    Icon(LucideIcons.trash2, size: 11, color: AppColors.tileText),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Body text
                    Positioned(
                      top: 36, // Below header
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16), // p-4 pt-1
                        child: Text(
                          widget.tile.content,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12, // text-xs
                                height: 1.6, // leading-relaxed
                                color: AppColors.tileText.withValues(alpha: 0.8), // text-neutral-900/80
                              ),
                        ),
                      ),
                    ),

                    // Bottom subtle bar - cluster indicator if clustered
                    if (widget.tile.clusterId != null)
                      Positioned(
                        bottom: 6,
                        right: 10,
                        child: Text(
                          'LINKED',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 8, 
                            fontWeight: FontWeight.bold, 
                            color: AppColors.tileText.withValues(alpha: 0.35), 
                            letterSpacing: 0.5
                          ),
                        ),
                      ),

                    // Strokes overlay
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _StrokesPainter(
                          strokes: widget.tile.strokes,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StrokesPainter extends CustomPainter {
  final List<model_stroke.Stroke> strokes;

  _StrokesPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var stroke in strokes) {
      if (stroke.points.isEmpty) continue;

      final paint = Paint()
        ..color = _parseColor(stroke.color)
        ..strokeWidth = stroke.thickness
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(stroke.points.first.x, stroke.points.first.y);

      for (int i = 1; i < stroke.points.length; i++) {
        final prev = stroke.points[i - 1];
        final current = stroke.points[i];
        final midX = (prev.x + current.x) / 2;
        final midY = (prev.y + current.y) / 2;
        path.quadraticBezierTo(prev.x, prev.y, midX, midY);
      }

      // If there's only one point, draw a circle to represent a dot
      if (stroke.points.length == 1) {
        canvas.drawCircle(
          Offset(stroke.points.first.x, stroke.points.first.y),
          stroke.thickness / 2,
          paint..style = PaintingStyle.fill,
        );
      } else {
        canvas.drawPath(path, paint);
      }
    }
  }

  Color _parseColor(String hex) {
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.tryParse(hex, radix: 16) ?? 0xFF000000);
  }

  @override
  bool shouldRepaint(covariant _StrokesPainter oldDelegate) {
    return true; // Simplify for now
  }
}
