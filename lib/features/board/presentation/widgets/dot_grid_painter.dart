import 'package:flutter/material.dart';

class DotGridPainter extends CustomPainter {
  final bool isDarkMode;
  final double viewportX;
  final double viewportY;
  final double zoom;

  DotGridPainter({
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
          ? Colors.white.withValues(alpha: 0.25)
          : Colors.black.withValues(alpha: 0.25)
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
  bool shouldRepaint(covariant DotGridPainter oldDelegate) {
    return oldDelegate.isDarkMode != isDarkMode ||
        oldDelegate.viewportX != viewportX ||
        oldDelegate.viewportY != viewportY ||
        oldDelegate.zoom != zoom;
  }
}
