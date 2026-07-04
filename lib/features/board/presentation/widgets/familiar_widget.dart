import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

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
              // Glow halo
              Positioned(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.familiarGlow.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2.seconds),

              // Spectral Orb Body
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [
                      Colors.yellowAccent,
                      AppColors.familiarAccent,
                      AppColors.familiarGlow,
                    ],
                    stops: [0.2, 0.6, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.familiarGlow.withValues(alpha: 0.7),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05), duration: 1.5.seconds),
              
              if (state == FamiliarState.consuming)
                ...List.generate(6, (index) {
                  return const Positioned(
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: AppColors.familiarAccent,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                   .fadeIn(duration: 400.ms)
                   .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.2, 0.2))
                   .move(
                     duration: 800.ms,
                     begin: Offset.zero,
                     // Fake random directions for consuming
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
