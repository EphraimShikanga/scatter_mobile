import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum FamiliarState {
  idle,
  flyingToHarvest,
  consuming,
  returning,
  flyingFetch,
  returningFetch,
}

class FamiliarWidget extends StatelessWidget {
  final FamiliarState state;
  final Offset position;
  final Offset? bezierTargetPos;
  final bool isDarkMode;
  final VoidCallback? onOrbClick;
  final bool isSatelliteFlying;

  const FamiliarWidget({
    super.key,
    required this.state,
    required this.position,
    this.bezierTargetPos,
    required this.isDarkMode,
    this.onOrbClick,
    this.isSatelliteFlying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 20, // Center the 40x40 orb
      top: position.dy - 20,
      child: GestureDetector(
        onTap: onOrbClick,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Drag Bezier String
              if (state == FamiliarState.returningFetch && bezierTargetPos != null)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BezierStringPainter(bezierTargetPos: bezierTargetPos!, startPos: position),
                  ),
                ),

              // Glow halo
              Positioned(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF59E0B).withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7],
                    ),
                  ),
                ),
              ),

              // Spectral Orb Body
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFF59E0B), // amber-500
                      Color(0xFFFBBF24), // amber-400
                      Color(0xFFFDE047), // yellow-300
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.7),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              
              if (state == FamiliarState.consuming)
                ...List.generate(6, (index) {
                  return const Positioned(
                    child: CircleAvatar(
                      radius: 3, // w-1.5 h-1.5
                      backgroundColor: Color(0xFFFBBF24), // amber-400
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                   .fadeIn(duration: 400.ms)
                   .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.2, 0.2))
                   .move(
                     duration: 800.ms,
                     begin: Offset.zero,
                     end: Offset((index % 2 == 0 ? 30 : -30), (index % 3 == 0 ? 30 : -30)),
                   )
                   .fadeOut();
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class _BezierStringPainter extends CustomPainter {
  final Offset bezierTargetPos;
  final Offset startPos;

  _BezierStringPainter({required this.bezierTargetPos, required this.startPos});

  @override
  void paint(Canvas canvas, Size size) {
    // simplified version of the drag string for fetch
    final paint = Paint()
      ..color = const Color(0xFF10B981) // roughly the middle of the gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    // Draw string to target
    path.quadraticBezierTo(
      (size.width / 2 + (bezierTargetPos.dx - startPos.dx)) / 2,
      (size.height / 2 + (bezierTargetPos.dy - startPos.dy)) / 2 - 40,
      size.width / 2 + (bezierTargetPos.dx - startPos.dx),
      size.height / 2 + (bezierTargetPos.dy - startPos.dy),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
