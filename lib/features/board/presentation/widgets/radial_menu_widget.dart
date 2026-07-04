import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: widget.familiarX - 24, // simplified positioning
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_showHelp || _showZoomSlider)
            Container(
              width: 320,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.plus),
                  onPressed: () => widget.onAddTile(null),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                IconButton(
                  icon: Icon(widget.isDarkMode ? LucideIcons.sun : LucideIcons.moon),
                  onPressed: widget.onToggleDarkMode,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.zoomIn),
                  onPressed: () {
                    setState(() {
                      _showZoomSlider = !_showZoomSlider;
                      if (_showZoomSlider) _showHelp = false;
                    });
                  },
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.helpCircle),
                  onPressed: () {
                    setState(() {
                      _showHelp = !_showHelp;
                      if (_showHelp) _showZoomSlider = false;
                    });
                  },
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.trash2),
                  onPressed: widget.onClearCanvas,
                  color: Colors.redAccent,
                ),
              ],
            ),
          )
        ],
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
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            Text(
              '${(widget.zoom * 100).round()}%',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
          activeColor: Theme.of(context).colorScheme.onSurface,
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
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        _buildHelpRow('Spawn Chroma Tile', 'Double-tap workspace'),
        _buildHelpRow('Sketch and Write', 'Double-tap note body'),
        _buildHelpRow('Dynamic Grouping', 'Drag note close to another'),
      ],
    );
  }

  Widget _buildHelpRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label, 
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 10, 
                  fontWeight: FontWeight.w500
                )
          ),
          Text(
            value, 
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9)
          ),
        ],
      ),
    );
  }
}
