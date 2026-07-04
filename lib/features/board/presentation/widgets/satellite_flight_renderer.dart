import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum SatelliteFlightType { spawn, theme, recenter, wipe, sink }
enum SatelliteFlightPhase { none, outgoing, impact, returning }

class SatelliteFlightState {
  final SatelliteFlightType type;
  final double targetX;
  final double targetY;
  final String color;
  final SatelliteFlightPhase phase;

  SatelliteFlightState({
    required this.type,
    required this.targetX,
    required this.targetY,
    required this.color,
    required this.phase,
  });
}

class SatelliteFlightRenderer extends StatefulWidget {
  final SatelliteFlightState flight;
  final Offset familiarPos;
  final bool isDarkMode;
  final bool isMenuOpen;
  final dynamic selectedTile;
  final Offset? selectedTileScreenPos;
  final double zoomScale;
  final Size screenSize;
  final VoidCallback onImpact;
  final VoidCallback onComplete;

  const SatelliteFlightRenderer({
    super.key,
    required this.flight,
    required this.familiarPos,
    required this.isDarkMode,
    required this.isMenuOpen,
    this.selectedTile,
    this.selectedTileScreenPos,
    required this.zoomScale,
    required this.screenSize,
    required this.onImpact,
    required this.onComplete,
  });

  @override
  State<SatelliteFlightRenderer> createState() => _SatelliteFlightRendererState();
}

class _SatelliteFlightRendererState extends State<SatelliteFlightRenderer> {
  @override
  Widget build(BuildContext context) {
    if (widget.flight.phase == SatelliteFlightPhase.none) {
      return const SizedBox.shrink();
    }

    // Simplified for now: just rendering a flying orb
    return Positioned(
      left: widget.flight.targetX,
      top: widget.flight.targetY,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.familiarGlow,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.familiarGlow.withValues(alpha: 0.5),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
      ),
    );
  }
}
