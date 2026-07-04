import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/models/chroma_tile.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/providers/tiles_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'strokes_painter.dart';

class ChromaTileWidget extends ConsumerStatefulWidget {
  final ChromaTile tile;
  final bool isDarkMode;
  final double zoomScale;
  final Function(String id, double dx, double dy) onDrag;
  final Function(String id) onTap;
  final Function(String id) onDoubleTap;

  const ChromaTileWidget({
    super.key,
    required this.tile,
    required this.isDarkMode,
    required this.zoomScale,
    required this.onDrag,
    required this.onTap,
    required this.onDoubleTap,
  });

  @override
  ConsumerState<ChromaTileWidget> createState() => _ChromaTileWidgetState();
}

class _ChromaTileWidgetState extends ConsumerState<ChromaTileWidget> {
  Color _parseColor(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  double getRotationAngle(String id) {
    int hash = 0;
    for (int i = 0; i < id.length; i++) {
      hash = id.codeUnitAt(i) + ((hash << 5) - hash);
    }
    double angleDeg = (hash % 5) / 3.0;
    return angleDeg * (3.1415926535897932 / 180.0);
  }
  Widget _buildMicroCard(Color bgColor, Color borderColor) {
    return GestureDetector(
      onTap: () {
        ref.read(tilesStateProvider.notifier).updateTile(
          widget.tile.id,
          isMicro: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: bgColor.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Miniature header line
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withValues(alpha: 0.08),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.tile.title.isEmpty ? 'NOTE' : widget.tile.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        color: AppColors.tileText.withValues(alpha: 0.6),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.tileText.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            // Miniature content preview
            Expanded(
              child: Text(
                widget.tile.content.isNotEmpty
                    ? widget.tile.content
                    : (widget.tile.strokes.isNotEmpty ? 'Drawing' : 'Empty'),
                style: TextStyle(
                  fontSize: 6,
                  height: 1.4,
                  color: AppColors.tileText.withValues(
                    alpha: widget.tile.content.isNotEmpty ? 0.6 : 0.4,
                  ),
                  fontStyle: widget.tile.content.isNotEmpty
                      ? FontStyle.normal
                      : FontStyle.italic,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _parseColor(widget.tile.colorHex);
    final borderColor = widget.isDarkMode
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.08);

    return Positioned(
      left: widget.tile.isMicro ? widget.tile.x + widget.tile.width / 2 - 42 : widget.tile.x,
      top: widget.tile.isMicro ? widget.tile.y + widget.tile.height / 2 - 30 : widget.tile.y,
      width: widget.tile.isMicro ? 84.0 : widget.tile.width,
      height: widget.tile.isMicro ? 60.0 : widget.tile.height,
      child: Transform.rotate(
        angle: getRotationAngle(widget.tile.id),
        child: GestureDetector(
          onTap: () => widget.onTap(widget.tile.id),
          onDoubleTap: () => widget.onDoubleTap(widget.tile.id),
          onPanUpdate: widget.tile.isMicro ? (details) {
            widget.onDrag(
              widget.tile.id,
              details.delta.dx,
              details.delta.dy,
            );
          } : null,
          child: widget.tile.isMicro 
            ? _buildMicroCard(bgColor, borderColor)
            : Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
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
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        widget.onDrag(
                          widget.tile.id,
                          details.delta.dx,
                          details.delta.dy,
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.015),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.gripVertical,
                                    size: 13,
                                    color: AppColors.tileIcon,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      widget.tile.title.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                            color: AppColors.tileText
                                                .withValues(alpha: 0.6),
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Opacity(
                              opacity: 0.3,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(tilesStateProvider.notifier)
                                          .updateTile(
                                            widget.tile.id,
                                            isMicro: true,
                                          );
                                    },
                                    child: Icon(
                                      LucideIcons.minimize2,
                                      size: 11,
                                      color: AppColors.tileText,
                                    ),
                                  ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      LucideIcons.anchor,
                                      size: 11,
                                      color: AppColors.tileText,
                                    ),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () =>
                                          widget.onDoubleTap(widget.tile.id),
                                      child: Icon(
                                        LucideIcons.maximize2,
                                        size: 11,
                                        color: AppColors.tileText,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      LucideIcons.trash2,
                                      size: 11,
                                      color: AppColors.tileText,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Body text + placeholder
                  Positioned(
                    top: 36,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: widget.tile.content.isNotEmpty
                          ? Text(
                              widget.tile.content,
                              style: GoogleFonts.kalam(
                                textStyle: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      height: 1.6,
                                      color: AppColors.tileText.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                              ),
                            )
                          : (widget.tile.strokes.isNotEmpty
                                ? const SizedBox.shrink()
                                : Text(
                                    'Double-tap to open writing board...',
                                    style: GoogleFonts.kalam(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: AppColors.tileText
                                                .withValues(alpha: 0.25),
                                          ),
                                    ),
                                  )),
                    ),
                  ),

                  // Bottom subtle bar - cluster indicator
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
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                  // Strokes overlay
                  if (widget.tile.content.isEmpty)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: StrokesPainter(strokes: widget.tile.strokes),
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
