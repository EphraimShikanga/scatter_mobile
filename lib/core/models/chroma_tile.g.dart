// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chroma_tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChromaTile _$ChromaTileFromJson(Map<String, dynamic> json) => _ChromaTile(
  id: json['id'] as String,
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  colorName: json['colorName'] as String,
  colorHex: json['colorHex'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  strokes:
      (json['strokes'] as List<dynamic>?)
          ?.map((e) => Stroke.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isArchived: json['isArchived'] as bool? ?? false,
  isSunk: json['isSunk'] as bool? ?? false,
  createdAt: (json['createdAt'] as num).toInt(),
  clusterId: json['clusterId'] as String?,
  isMicro: json['isMicro'] as bool? ?? false,
  struckLineIndices:
      (json['struckLineIndices'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$ChromaTileToJson(_ChromaTile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'colorName': instance.colorName,
      'colorHex': instance.colorHex,
      'title': instance.title,
      'content': instance.content,
      'strokes': instance.strokes,
      'isArchived': instance.isArchived,
      'isSunk': instance.isSunk,
      'createdAt': instance.createdAt,
      'clusterId': instance.clusterId,
      'isMicro': instance.isMicro,
      'struckLineIndices': instance.struckLineIndices,
    };
