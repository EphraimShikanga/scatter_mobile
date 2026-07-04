import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chroma_tile.dart';
import '../models/stroke.dart';

import '../constants/initial_tiles.dart';

part 'tiles_provider.g.dart';

@riverpod
class TilesState extends _$TilesState {
  @override
  List<ChromaTile> build() {
    return initialTiles;
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

  void updateTile(
    String id, {
    String? title,
    String? content,
    List<Stroke>? strokes,
    List<int>? struckLineIndices,
    bool? isSunk,
    bool? isMicro,
  }) {
    state = state.map((tile) {
      if (tile.id == id) {
        return tile.copyWith(
          title: title ?? tile.title,
          content: content ?? tile.content,
          strokes: strokes ?? tile.strokes,
          struckLineIndices: struckLineIndices ?? tile.struckLineIndices,
          isSunk: isSunk ?? tile.isSunk,
          isMicro: isMicro ?? tile.isMicro,
        );
      }
      return tile;
    }).toList();
  }

  void clear() {
    state = [];
  }
}
