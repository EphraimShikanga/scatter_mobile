// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Stroke _$StrokeFromJson(Map<String, dynamic> json) => _Stroke(
  id: json['id'] as String,
  points:
      (json['points'] as List<dynamic>?)
          ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  color: json['color'] as String,
  thickness: (json['thickness'] as num).toDouble(),
);

Map<String, dynamic> _$StrokeToJson(_Stroke instance) => <String, dynamic>{
  'id': instance.id,
  'points': instance.points,
  'color': instance.color,
  'thickness': instance.thickness,
};
