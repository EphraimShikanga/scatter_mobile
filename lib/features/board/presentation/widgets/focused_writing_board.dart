import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/models/chroma_tile.dart';
import '../../../../core/models/stroke.dart' as model_stroke;
import '../../../../core/models/point.dart' as model_point;
import 'strokes_painter.dart';

/// Ink color presets matching the web app exactly.
const List<({String label, String hex})> _inkColors = [
  (label: 'Coal', hex: '#171717'),
  (label: 'Cobalt', hex: '#2563EB'),
  (label: 'Crimson', hex: '#DC2626'),
  (label: 'Emerald', hex: '#16A34A'),
  (label: 'Amber', hex: '#D97706'),
  (label: 'Amethyst', hex: '#7C3AED'),
];

/// Ink thickness presets matching the web app exactly.
const List<({double thickness, double dotSize})> _inkThicknesses = [
  (thickness: 1.5, dotSize: 3),
  (thickness: 3.5, dotSize: 5),
  (thickness: 6.5, dotSize: 7),
  (thickness: 12.0, dotSize: 9),
];

enum _FocusMode { draw, type }

class FocusedWritingBoard extends StatefulWidget {
  final ChromaTile tile;
  final String activeColor;
  final double activeThickness;
  final void Function(String activeColor) onColorChange;
  final void Function(double activeThickness) onThicknessChange;
  final void Function({
    required String title,
    required String content,
    required List<model_stroke.Stroke> strokes,
  }) onSave;
  final VoidCallback onCancel;

  const FocusedWritingBoard({
    super.key,
    required this.tile,
    required this.activeColor,
    required this.activeThickness,
    required this.onColorChange,
    required this.onThicknessChange,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<FocusedWritingBoard> createState() => _FocusedWritingBoardState();
}

class _FocusedWritingBoardState extends State<FocusedWritingBoard> {
  late String _title;
  late String _content;
  late List<model_stroke.Stroke> _strokes;
  late _FocusMode _mode;
  late TextEditingController _contentController;
  late TextEditingController _titleController;

  // Active drawing state — kept local for zero-latency stylus response
  model_stroke.Stroke? _activeStroke;
  int? _activePointerId;

  @override
  void initState() {
    super.initState();
    _title = widget.tile.title;
    _content = widget.tile.content;
    _strokes = List.of(widget.tile.strokes);
    _mode = _FocusMode.type;
    _contentController = TextEditingController(text: _content);
    _titleController = TextEditingController(text: _title);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  // ── Drawing Handlers ──────────────────────────────────────────────────

  void _onDrawStart(PointerDownEvent event) {
    if (_activePointerId != null) {
      // Palm rejection: if a palm is resting (touch) and stylus comes down, steal the gesture.
      if (event.kind == PointerDeviceKind.stylus) {
        // Save current interrupted stroke
        if (_activeStroke != null) {
          _strokes.add(_activeStroke!);
        }
      } else {
        // Ignore secondary touches
        return;
      }
    }

    _activePointerId = event.pointer;
    final localPos = event.localPosition;
    final newStroke = model_stroke.Stroke(
      id: 'stroke-${DateTime.now().microsecondsSinceEpoch}',
      color: widget.activeColor,
      thickness: widget.activeThickness,
      points: [model_point.Point(x: localPos.dx, y: localPos.dy, pressure: event.pressure)],
    );

    setState(() {
      _activeStroke = newStroke;
    });
  }

  void _onDrawMove(PointerMoveEvent event) {
    if (event.pointer != _activePointerId || _activeStroke == null) return;

    final updatedPoints = [
      ..._activeStroke!.points,
      model_point.Point(
        x: event.localPosition.dx,
        y: event.localPosition.dy,
        pressure: event.pressure,
      ),
    ];

    setState(() {
      _activeStroke = _activeStroke!.copyWith(points: updatedPoints);
    });
  }

  void _onDrawEnd(PointerUpEvent event) {
    if (event.pointer != _activePointerId) return;

    setState(() {
      if (_activeStroke != null) {
        _strokes = [..._strokes, _activeStroke!];
        _activeStroke = null;
      }
      _activePointerId = null;
    });
  }

  void _onDrawCancel(PointerCancelEvent event) {
    if (event.pointer != _activePointerId) return;
    
    setState(() {
      if (_activeStroke != null) {
        _strokes = [..._strokes, _activeStroke!];
        _activeStroke = null;
      }
      _activePointerId = null;
    });
  }

  // ── Save / Cancel / Clear ─────────────────────────────────────────────

  void _handleSave() {
    widget.onSave(
      title: _titleController.text,
      content: _contentController.text,
      strokes: _strokes,
    );
  }

  void _handleClear() {
    setState(() {
      if (_mode == _FocusMode.draw) {
        _strokes = [];
        _activeStroke = null;
      } else {
        _contentController.clear();
      }
    });
  }

  // ── Color Parsing ─────────────────────────────────────────────────────

  Color _parseHex(String hex) {
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  // ── Build ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tileColor = _parseHex(widget.tile.colorHex);

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.80),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.08),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 64,
                    offset: const Offset(0, 32),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  children: [
                    _buildToolbar(),
                    Expanded(
                      child: _mode == _FocusMode.draw
                          ? _buildDrawCanvas()
                          : _buildTypeArea(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Toolbar ───────────────────────────────────────────────────────────

  Widget _buildToolbar() {
    const textColor = Color(0xFF121212);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.015),
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // ── Left: Title Input + Mode Toggle ──
          Expanded(
            child: Row(
              children: [
                // Title input
                SizedBox(
                  width: 140,
                  child: TextField(
                    controller: _titleController,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Title...',
                      hintStyle: TextStyle(
                        color: textColor.withValues(alpha: 0.3),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.black.withValues(alpha: 0.05),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Mode toggle (Draw / Type)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.03),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _modeButton(
                        icon: LucideIcons.penLine,
                        isActive: _mode == _FocusMode.draw,
                        tooltip: 'Sketching Mode',
                        onTap: () => setState(() => _mode = _FocusMode.draw),
                      ),
                      _modeButton(
                        icon: LucideIcons.type,
                        isActive: _mode == _FocusMode.type,
                        tooltip: 'Typewriter Mode',
                        onTap: () => setState(() => _mode = _FocusMode.type),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Middle: Draw tools (only in draw mode) ──
          if (_mode == _FocusMode.draw) ...[
            const SizedBox(width: 12),
            _buildDrawTools(),
          ],

          const SizedBox(width: 12),

          // ── Right: Clear, Cancel, Save ──
          _buildActions(),
        ],
      ),
    );
  }

  Widget _modeButton({
    required IconData icon,
    required bool isActive,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0A0A0A) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 13,
            color: isActive ? Colors.white : const Color(0xFF737373),
          ),
        ),
      ),
    );
  }

  // ── Draw Tools (Color Palette + Thickness) ────────────────────────────

  Widget _buildDrawTools() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color palette
          for (final col in _inkColors) ...[
            _colorDot(col.hex, col.label),
            if (col != _inkColors.last) const SizedBox(width: 4),
          ],
          const SizedBox(width: 8),
          // Divider
          Container(
            width: 1,
            height: 16,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          const SizedBox(width: 8),
          // Thickness picker
          for (final item in _inkThicknesses) ...[
            _thicknessDot(item.thickness, item.dotSize),
            if (item != _inkThicknesses.last) const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }

  Widget _colorDot(String hex, String label) {
    final isSelected = widget.activeColor == hex;
    final color = _parseHex(hex);

    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: () => widget.onColorChange(hex),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF121212)
                  : Colors.transparent,
              width: isSelected ? 1.5 : 0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF121212).withValues(alpha: 0.3),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _thicknessDot(double thickness, double dotSize) {
    final isSelected = widget.activeThickness == thickness;

    return Tooltip(
      message: 'Brush size: ${thickness}px',
      child: GestureDetector(
        onTap: () => widget.onThicknessChange(thickness),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0A0A0A) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFF171717),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Actions (Clear / Cancel / Save) ───────────────────────────────────

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Clear
        Tooltip(
          message: _mode == _FocusMode.draw
              ? 'Clear entire sketch canvas'
              : 'Clear all typed text',
          child: GestureDetector(
            onTap: _handleClear,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                LucideIcons.rotateCcw,
                size: 13,
                color: const Color(0xFF525252),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),

        // Divider
        Container(
          width: 1,
          height: 20,
          color: Colors.black.withValues(alpha: 0.1),
          margin: const EdgeInsets.symmetric(horizontal: 4),
        ),

        // Cancel
        Tooltip(
          message: 'Cancel and discard changes',
          child: GestureDetector(
            onTap: widget.onCancel,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                LucideIcons.x,
                size: 14,
                color: const Color(0xFF525252),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Save
        Tooltip(
          message: 'Save and close',
          child: GestureDetector(
            onTap: _handleSave,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Draw Canvas ───────────────────────────────────────────────────────

  Widget _buildDrawCanvas() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Ghost text lines behind the canvas for reference
          if (_content.isNotEmpty)
            Positioned.fill(
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _content.split('\n').map((line) {
                      if (line.trim().isEmpty) return const SizedBox(height: 18);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          line,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF121212).withValues(alpha: 0.15),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

          // The drawing surface
          Positioned.fill(
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: _onDrawStart,
              onPointerMove: _onDrawMove,
              onPointerUp: _onDrawEnd,
              onPointerCancel: _onDrawCancel,
              child: CustomPaint(
                painter: StrokesPainter(
                  strokes: _strokes,
                  activeStroke: _activeStroke,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),

          // Status watermark
          Positioned(
            bottom: 0,
            left: 0,
            child: IgnorePointer(
              child: Text(
                'Sketchboard Active',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  letterSpacing: 0.5,
                  color: const Color(0xFF0A0A0A).withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Type Area ─────────────────────────────────────────────────────────

  Widget _buildTypeArea() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _contentController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: GoogleFonts.kalam(
                textStyle: const TextStyle(
                  fontSize: 20,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF121212),
                ),
              ),
              decoration: InputDecoration(
                hintText:
                    'Type notes, summaries, ideas, transcripts, or references...',
                hintStyle: GoogleFonts.kalam(
                  textStyle: TextStyle(
                    color: const Color(0xFF171717).withValues(alpha: 0.4),
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              autofocus: true,
              onChanged: (value) {
                _content = value;
              },
            ),
          ),
          // Status bar
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _contentController,
                builder: (context, value, _) {
                  return Text(
                    'Typewriter Active • Character Count: ${value.text.length}',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
                      color: const Color(0xFF0A0A0A).withValues(alpha: 0.4),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
