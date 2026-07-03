import 'package:freezed_annotation/freezed_annotation.dart';
import 'stroke.dart';

part 'chroma_tile.freezed.dart';
part 'chroma_tile.g.dart';

@freezed
abstract class ChromaTile with _$ChromaTile {
  const ChromaTile._();
  const factory ChromaTile({
    required String id,
    required double x,
    required double y,
    required double width,
    required double height,
    required String colorName,
    required String colorHex,
    required String title,
    required String content,
    @Default([]) List<Stroke> strokes,
    @Default(false) bool isArchived,
    @Default(false) bool isSunk,
    required int createdAt,
    String? clusterId,
    @Default(false) bool isMicro,
    @Default([]) List<int> struckLineIndices,
  }) = _ChromaTile;

  factory ChromaTile.fromJson(Map<String, dynamic> json) => _$ChromaTileFromJson(json);
}
