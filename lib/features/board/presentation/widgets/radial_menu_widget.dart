import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/initial_tiles.dart';

class RadialMenuWidget extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final String activeColor;
  final Function(String) onColorChange;
  final double activeThickness;
  final Function(double) onThicknessChange;
  final Function(String?) onAddTile;
  final VoidCallback onClearCanvas;
  final VoidCallback onResetCamera;
  final bool isOrbitMode;
  final double zoom;
  final Function(double) onZoomChange;
  final VoidCallback? onDoubleTapMenu;
  final bool isMenuOpen;
  final VoidCallback onToggleMenu;
  final double familiarX;

  const RadialMenuWidget({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.activeColor,
    required this.onColorChange,
    required this.activeThickness,
    required this.onThicknessChange,
    required this.onAddTile,
    required this.onClearCanvas,
    required this.onResetCamera,
    required this.isOrbitMode,
    required this.zoom,
    required this.onZoomChange,
    this.onDoubleTapMenu,
    required this.isMenuOpen,
    required this.onToggleMenu,
    required this.familiarX,
  });

  @override
  State<RadialMenuWidget> createState() => _RadialMenuWidgetState();
}

class _RadialMenuWidgetState extends State<RadialMenuWidget> {
  bool _showHelp = false;
  bool _showZoomSlider = false;

  Color _parseColor(String hex) {
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  @override
  Widget build(BuildContext context) {
    // Colors matching React classes
    final bgColor = widget.isDarkMode 
        ? const Color(0xE6171717) // bg-neutral-900/90
        : const Color(0xE6FFFFFF); // bg-white/90
        
    final borderColor = widget.isDarkMode 
        ? const Color(0xFF262626) // border-neutral-800
        : const Color(0xFFE5E5E5); // border-neutral-200

    return Positioned(
      bottom: 32,
      left: widget.familiarX - 24, // simplified positioning
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_showHelp || _showZoomSlider)
            Container(
              width: 320,
              margin: const EdgeInsets.only(bottom: 12, left: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.isDarkMode ? const Color(0xF2171717) : const Color(0xF2FFFFFF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  )
                ],
              ),
              child: _showZoomSlider ? _buildZoomSlider() : _buildHelp(),
            ),
          
          // Main Menu Row (Capsule)
          Row(
            children: [
              // Familiar spacer trigger
              GestureDetector(
                onTap: widget.onToggleMenu,
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.transparent,
                ),
              ),
              
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 550),
                curve: Curves.easeOutBack,
                tween: Tween<double>(begin: 0.0, end: widget.isMenuOpen ? 1.0 : 0.0),
                builder: (context, value, child) {
                  // Prevent negative widthFactor/opacity when using bouncy curves
                  final clampedValue = value.clamp(0.0, double.infinity);
                  final opacityValue = value.clamp(0.0, 1.0);
                  
                  return ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: clampedValue,
                      child: Opacity(
                        opacity: opacityValue,
                        child: Transform.translate(
                          offset: Offset(-15 * (1 - opacityValue), 0),
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: borderColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.isDarkMode 
                                        ? Colors.black.withValues(alpha: 0.4) 
                                        : const Color(0xFFE5E5E5).withValues(alpha: 0.5),
                                    blurRadius: 40,
                                    offset: const Offset(0, 12),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Left: Quick Spawn Color Notes
                                  _buildColorBtn('canary', colorCanary),
                                  const SizedBox(width: 6),
                                  _buildColorBtn('mint', colorMint),
                                  const SizedBox(width: 6),
                                  _buildColorBtn('coral', colorCoral),
                                  const SizedBox(width: 6),
                                  _buildColorBtn('iceBlue', colorIceBlue),
                                  
                                  const SizedBox(width: 16),
                                  
                                  // Minimal Divider
                                  Container(
                                    width: 1,
                                    height: 20,
                                    color: widget.isDarkMode 
                                        ? const Color(0xFF262626) 
                                        : const Color(0xFFE5E5E5),
                                  ),
                                  
                                  const SizedBox(width: 4),

                                  // Right: Quick View & Global Settings
                                  _buildIconTextBtn(
                                    '${(widget.zoom * 100).round()}%',
                                    _showZoomSlider,
                                    () {
                                      setState(() {
                                        _showZoomSlider = !_showZoomSlider;
                                        if (_showZoomSlider) _showHelp = false;
                                      });
                                    },
                                  ),
                                  
                                  _buildIconBtn(
                                    LucideIcons.layoutGrid, 
                                    widget.isOrbitMode, 
                                    () {
                                      if (widget.onDoubleTapMenu != null) {
                                        widget.onDoubleTapMenu!();
                                      }
                                    }
                                  ),

                                  _buildIconBtn(
                                    widget.isDarkMode ? LucideIcons.sun : LucideIcons.moon, 
                                    false, 
                                    widget.onToggleDarkMode,
                                    iconOverrideColor: widget.isDarkMode ? Colors.amber : null,
                                  ),
                                  
                                  _buildIconBtn(
                                    LucideIcons.compass, 
                                    false, 
                                    widget.onResetCamera
                                  ),
                                  
                                  _buildIconBtn(
                                    LucideIcons.helpCircle, 
                                    _showHelp, 
                                    () {
                                      setState(() {
                                        _showHelp = !_showHelp;
                                        if (_showHelp) _showZoomSlider = false;
                                      });
                                    }
                                  ),
                                  
                                  _buildIconBtn(
                                    LucideIcons.trash2, 
                                    false, 
                                    widget.onClearCanvas,
                                    hoverColor: Colors.redAccent.withValues(alpha: 0.1),
                                    iconHoverColor: Colors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColorBtn(String name, String hex) {
    return GestureDetector(
      onTap: () => widget.onAddTile(name),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: _parseColor(hex),
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.isDarkMode 
                ? Colors.white.withValues(alpha: 0.15) 
                : Colors.black.withValues(alpha: 0.12)
          ),
        ),
        child: const Center(
          child: Icon(LucideIcons.plus, size: 14, color: Color(0xFF171717)),
        ),
      ),
    );
  }

  Widget _buildIconTextBtn(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w900 : FontWeight.bold,
            letterSpacing: 1.0,
            color: isActive 
                ? Colors.amber.shade600 
                : (widget.isDarkMode ? const Color(0xFFA3A3A3) : const Color(0xFF737373)),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBtn(
    IconData icon, 
    bool isActive, 
    VoidCallback onTap, 
    {Color? hoverColor, Color? iconHoverColor, Color? iconOverrideColor}
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber.withValues(alpha: 0.15) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconOverrideColor ?? (isActive 
              ? Colors.amber.shade600 
              : (widget.isDarkMode ? const Color(0xFFA3A3A3) : const Color(0xFF737373))),
        ),
      ),
    );
  }

  Widget _buildZoomSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VIEWPORT ZOOM SCALE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: widget.isDarkMode ? Colors.white.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.6),
              ),
            ),
            Text(
              '${(widget.zoom * 100).round()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: widget.zoom,
          min: 0.15,
          max: 2.0,
          onChanged: widget.onZoomChange,
          activeColor: widget.isDarkMode ? Colors.white : Colors.black,
        ),
      ],
    );
  }

  Widget _buildHelp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CANVAS INTERACTION MODEL',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: widget.isDarkMode ? Colors.white.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(height: 8),
        _buildHelpRow('Spawn Chroma Tile', 'Double-tap workspace background', false),
        _buildHelpRow('Sketch and Write', 'Double-tap note body', false),
        _buildHelpRow('Dynamic Grouping', 'Drag note close to another', false),
        _buildHelpRow('Unlink Group', 'Tap Unlink button on header', false),
        _buildHelpRow('Sink Note to Canvas', 'Hold 400ms or click Minimize icon', true),
        _buildHelpRow('Restore Sunken Note', 'Click the floating micro-card', false),
      ],
    );
  }

  Widget _buildHelpRow(String label, String value, bool highlightValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label, 
            style: TextStyle(
              fontSize: 10, 
              fontWeight: FontWeight.w500,
              color: widget.isDarkMode ? Colors.white.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.6),
            )
          ),
          Text(
            value, 
            style: TextStyle(
              fontSize: 9,
              fontWeight: highlightValue ? FontWeight.bold : FontWeight.normal,
              color: highlightValue 
                  ? Colors.amber 
                  : (widget.isDarkMode ? Colors.white.withValues(alpha: 0.95) : Colors.black.withValues(alpha: 0.95)),
            )
          ),
        ],
      ),
    );
  }
}
