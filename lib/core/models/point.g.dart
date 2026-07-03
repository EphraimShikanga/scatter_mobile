// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Point _$PointFromJson(Map<String, dynamic> json) => _Point(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  pressure: (json['pressure'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PointToJson(_Point instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'pressure': instance.pressure,
};
