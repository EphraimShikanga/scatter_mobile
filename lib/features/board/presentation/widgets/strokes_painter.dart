import 'package:flutter/material.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import '../../../../core/models/stroke.dart' as model_stroke;

/// Shared painter that renders ink strokes using smooth perfect_freehand polygons.
/// Used by both ChromaTileWidget (mini card view) and FocusedWritingBoard (full canvas).
class StrokesPainter extends CustomPainter {
  final List<model_stroke.Stroke> strokes;
  final model_stroke.Stroke? activeStroke;

  StrokesPainter({
    required this.strokes,
    this.activeStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw completed strokes
    for (var stroke in strokes) {
      _drawStroke(canvas, stroke);
    }
    // Draw the in-progress stroke on top
    if (activeStroke != null) {
      _drawStroke(canvas, activeStroke!);
    }
  }

  void _drawStroke(Canvas canvas, model_stroke.Stroke stroke) {
    if (stroke.points.isEmpty) return;

    final paint = Paint()
      ..color = _parseColor(stroke.color)
      ..style = PaintingStyle.fill;

    // Map our Point model to perfect_freehand's PointVector model
    final pfPoints = stroke.points
        .map((p) => PointVector(p.x, p.y, p.pressure))
        .toList();

    // Generate outline polygon
    final outlinePoints = getStroke(
      pfPoints,
      options: StrokeOptions(
        size: stroke.thickness,
        thinning: 0.7,
        smoothing: 0.5,
        streamline: 0.5,
        simulatePressure: false,
      ),
    );

    if (outlinePoints.isEmpty) return;

    final path = Path();
    path.moveTo(outlinePoints.first.dx, outlinePoints.first.dy);
    for (int i = 1; i < outlinePoints.length; i++) {
      path.lineTo(outlinePoints[i].dx, outlinePoints[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  static Color _parseColor(String hex) {
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.tryParse(hex, radix: 16) ?? 0xFF000000);
  }

  @override
  bool shouldRepaint(covariant StrokesPainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
        oldDelegate.activeStroke != activeStroke;
  }
}
