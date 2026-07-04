import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/viewport.dart';

part 'viewport_provider.g.dart';

@riverpod
class ViewportState extends _$ViewportState {
  @override
  Viewport build() {
    return const Viewport(x: 0, y: 0, zoom: 1.0);
  }

  void updateViewport({double? x, double? y, double? zoom}) {
    state = state.copyWith(
      x: x ?? state.x,
      y: y ?? state.y,
      zoom: zoom ?? state.zoom,
    );
  }

  void reset() {
    state = const Viewport(x: 0, y: 0, zoom: 1.0);
  }
}
