import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/models/chroma_tile.dart';
import '../../../../core/models/stroke.dart' as model_stroke;

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

  @override
  Widget build(BuildContext context) {
    final bgColor = _parseColor(widget.tile.colorHex);
    final borderColor = widget.isDarkMode 
        ? Colors.white.withValues(alpha: 0.15) 
        : Colors.black.withValues(alpha: 0.12);

    return Positioned(
      left: widget.tile.x,
      top: widget.tile.y,
      width: widget.tile.width,
      height: widget.tile.height,
      child: Listener(
        onPointerDown: _handlePointerDown,
        onPointerMove: _handlePointerMove,
        onPointerUp: _handlePointerUp,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Forward drag events back up
            widget.onDrag(widget.tile.id, details.delta.dx, details.delta.dy);
          },
          onTap: () => widget.onTap(widget.tile.id),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Header
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 36,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.tile.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withValues(alpha: 0.8),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(LucideIcons.gripVertical, size: 16, color: Colors.black.withValues(alpha: 0.3)),
                        ],
                      ),
                    ),
                  ),

                  // Body text
                  Positioned(
                    top: 36,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        widget.tile.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withValues(alpha: 0.8),
                        ),
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
