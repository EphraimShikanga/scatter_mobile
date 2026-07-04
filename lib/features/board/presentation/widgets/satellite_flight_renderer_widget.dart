import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SatelliteFlightState {
  final String phase; // 'none', 'outgoing', 'impact', 'returning'
  final String type; // 'spawn', 'theme', 'recenter', 'wipe', 'sink'
  final Offset targetPos;
  final String colorHex;

  const SatelliteFlightState({
    required this.phase,
    required this.type,
    required this.targetPos,
    required this.colorHex,
  });

  static const idle = SatelliteFlightState(
    phase: 'none',
    type: 'none',
    targetPos: Offset.zero,
    colorHex: '#FFFFFF',
  );
}

class SatelliteFlightRendererWidget extends StatefulWidget {
  final SatelliteFlightState flight;
  final Offset familiarPos;
  final bool isDarkMode;
  final bool isMenuOpen;
  final double zoomScale;
  final Size screenSize;
  final Offset? selectedTileScreenPos;
  final Size? selectedTileSize;
  final String? selectedTileColorHex;
  final String activeMenuColorHex;
  final double flightProgress;
  final VoidCallback? onImpact;
  final VoidCallback? onComplete;

  const SatelliteFlightRendererWidget({
    super.key,
    required this.flight,
    required this.familiarPos,
    required this.isDarkMode,
    required this.isMenuOpen,
    required this.zoomScale,
    required this.screenSize,
    required this.activeMenuColorHex,
    this.selectedTileScreenPos,
    this.selectedTileSize,
    this.selectedTileColorHex,
    this.flightProgress = 0.0,
    this.onImpact,
    this.onComplete,
  });

  @override
  State<SatelliteFlightRendererWidget> createState() => _SatelliteFlightRendererWidgetState();
}

class _SatelliteFlightRendererWidgetState extends State<SatelliteFlightRendererWidget> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final ValueNotifier<double> _timeNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      // 60fps = 16.6ms per frame. 0.05 per frame in React.
      // 0.05 per 16.6ms -> 0.05 / 16.6 ms -> 3.0 per second
      _timeNotifier.value = elapsed.inMicroseconds / 1000000.0 * 3.0; 
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _timeNotifier.dispose();
    super.dispose();
  }

  Color _parseColor(String? hex, double time) {
    if (hex == null || hex == 'rainbow' || hex == '#FFFFFF') {
      return HSVColor.fromAHSV(1.0, (time * 50) % 360, 0.8, 1.0).toColor();
    }
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ValueListenableBuilder<double>(
          valueListenable: _timeNotifier,
          builder: (context, time, child) {
            // Replicate the exact math from React SatelliteFlightRenderer
            double localX = 0;
            double localY = 0;
            double localRotate = 0;

            final cardW = widget.selectedTileSize?.width ?? 280.0 * widget.zoomScale;
            final cardH = widget.selectedTileSize?.height ?? 240.0 * widget.zoomScale;

            // The HUD is unscaled, so orbit radius should be constant
            final rx = 80.0;
            final ry = 40.0;

            if (widget.flight.phase == 'none') {
              if (widget.selectedTileScreenPos != null) {
                localX = cos(time * 0.25) * rx;
                localY = sin(time * 0.25) * ry;
                localRotate = time * 30;
              } else if (widget.isMenuOpen) {
                final slowTime = time * 0.35;
                localX = sin(slowTime * 1.4) * 55 + cos(slowTime * 2.7) * 35 + sin(slowTime * 0.45) * 15;
                localY = cos(slowTime * 0.95) * 55 + sin(slowTime * 2.1) * 35 + cos(slowTime * 0.55) * 15;
                localRotate = time * 8;
              } else {
                localX = cos(time * 0.02) * 44;
                localY = sin(time * 0.02) * 44;
                localRotate = time * 4;
              }
            } else if (widget.flight.phase == 'outgoing' || widget.flight.phase == 'returning') {
              // Interpolate from familiar base to target
              final targetLocal = widget.flight.targetPos - widget.familiarPos;
              localX = targetLocal.dx * widget.flightProgress;
              localY = targetLocal.dy * widget.flightProgress;
              localRotate = time * 20; // Spin fast during flight
            }

            Offset basePos = widget.familiarPos;
            if (widget.selectedTileScreenPos != null) {
              basePos = Offset(widget.selectedTileScreenPos!.dx + cardW / 2, widget.selectedTileScreenPos!.dy + cardH / 2);
            }

            final currentHex = widget.flight.phase == 'none' 
                ? (widget.selectedTileColorHex ?? widget.activeMenuColorHex)
                : widget.flight.colorHex;

            final dotColor = _parseColor(currentHex, time);
            final flightColor = _parseColor(currentHex, time);

            return CustomPaint(
              painter: _SatellitePainter(
                time: time,
                basePos: basePos,
                localX: localX,
                localY: localY,
                localRotate: localRotate,
                zoomScale: widget.zoomScale,
                dotColor: dotColor,
                flightColor: flightColor,
                phase: widget.flight.phase,
                isMenuOpen: widget.isMenuOpen,
                hasSelectedTile: widget.selectedTileScreenPos != null,
                rx: rx,
                ry: ry,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SatellitePainter extends CustomPainter {
  final double time;
  final Offset basePos;
  final double localX;
  final double localY;
  final double localRotate;
  final double zoomScale;
  final Color dotColor;
  final Color flightColor;
  final String phase;
  final bool isMenuOpen;
  final bool hasSelectedTile;
  final double rx;
  final double ry;

  _SatellitePainter({
    required this.time,
    required this.basePos,
    required this.localX,
    required this.localY,
    required this.localRotate,
    required this.zoomScale,
    required this.dotColor,
    required this.flightColor,
    required this.phase,
    required this.isMenuOpen,
    required this.hasSelectedTile,
    required this.rx,
    required this.ry,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final satelliteCenter = Offset(basePos.dx + localX, basePos.dy + localY);

    // Prevent satellite from disappearing entirely when zoomed out
    final effectiveZoom = max(0.45, zoomScale);

    // 1. Orbital history trailing dots
    if (hasSelectedTile && phase == 'none') {
      for (int i = 1; i <= 5; i++) {
        final trailTime = time - i * 0.12;
        final tx = cos(trailTime * 0.25) * rx;
        final ty = sin(trailTime * 0.25) * ry;
        final opacity = 0.5 * (1 - i / 6);
        final scale = 1 - i * 0.1;
        final trailSize = max(3.0, 7.0) * scale * effectiveZoom;
        
        final paint = Paint()
          ..color = dotColor.withValues(alpha: opacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12 * effectiveZoom);
        
        canvas.drawCircle(Offset(basePos.dx + tx, basePos.dy + ty), trailSize / 2, paint);
        
        final corePaint = Paint()
          ..color = dotColor.withValues(alpha: opacity * 1.5);
        canvas.drawCircle(Offset(basePos.dx + tx, basePos.dy + ty), trailSize / 4, corePaint);
      }
    }

    // 2. Flashlight beam
    if (hasSelectedTile && phase == 'none') {
      final distance = sqrt(localX * localX + localY * localY);
      final angleRad = atan2(-localY, -localX);
      
      canvas.save();
      canvas.translate(satelliteCenter.dx, satelliteCenter.dy);
      canvas.rotate(angleRad);
      
      final beamPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            dotColor.withValues(alpha: 0.7),
            dotColor.withValues(alpha: 0.35),
            dotColor.withValues(alpha: 0.12),
            dotColor.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.2, 0.6, 1.0],
        ).createShader(Rect.fromLTRB(0, -distance, distance, distance))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

      final path = Path();
      path.moveTo(0, -4);
      path.lineTo(distance * 0.82, -distance * 0.7);
      path.lineTo(distance * 0.82, distance * 0.7);
      path.close();
      
      // opacity pulse
      final beamOpacity = 0.55 + (sin(time * 0.5).abs() * 0.1);
      beamPaint.color = beamPaint.color.withValues(alpha: beamOpacity);
      
      canvas.drawPath(path, beamPaint);
      
      final corePath = Path();
      corePath.moveTo(0, -1);
      corePath.lineTo(distance * 0.68, -distance * 0.25);
      corePath.lineTo(distance * 0.68, distance * 0.25);
      corePath.close();
      
      final corePaint = Paint()
        ..shader = beamPaint.shader
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0)
        ..color = Colors.white.withValues(alpha: 0.35);
        
      canvas.drawPath(corePath, corePaint);
      
      canvas.restore();
    }

    // 3. Main glowing physical particle
    // Outer glow
    final glowPaint = Paint()
      ..color = flightColor.withValues(alpha: 0.8)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18.0 * effectiveZoom);
    canvas.drawCircle(satelliteCenter, 6.5 * effectiveZoom, glowPaint);
    
    // Outer secondary glow
    final corePaint = Paint()
      ..color = dotColor.withValues(alpha: 1.0)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0 * effectiveZoom);
    canvas.drawCircle(satelliteCenter, 4.5 * effectiveZoom, corePaint);
    
    final innerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(satelliteCenter, 2.0 * effectiveZoom, innerPaint);
    
    // Inner white dot
    final dotPaint = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1 * effectiveZoom);
    canvas.drawCircle(satelliteCenter, 1.0 * effectiveZoom, dotPaint);

  }

  @override
  bool shouldRepaint(covariant _SatellitePainter oldDelegate) => true;
}
