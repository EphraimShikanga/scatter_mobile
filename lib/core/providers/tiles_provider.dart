import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chroma_tile.dart';
import '../models/stroke.dart';

part 'tiles_provider.g.dart';

@riverpod
class TilesState extends _$TilesState {
  @override
  List<ChromaTile> build() {
    // We will initialize with INITIAL_TILES later
    return [];
  }

  void addTile(ChromaTile tile) {
    state = [...state, tile];
  }

  void updateTilePosition(String id, double dx, double dy) {
    state = state.map((tile) {
      if (tile.id == id) {
        return tile.copyWith(x: tile.x + dx, y: tile.y + dy);
      }
      return tile;
    }).toList();
  }

  void addStrokeToTile(String tileId, Stroke stroke) {
    state = state.map((tile) {
      if (tile.id == tileId) {
        return tile.copyWith(strokes: [...tile.strokes, stroke]);
      }
      return tile;
    }).toList();
  }
}
