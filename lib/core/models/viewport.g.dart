// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Viewport _$ViewportFromJson(Map<String, dynamic> json) => _Viewport(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  zoom: (json['zoom'] as num?)?.toDouble() ?? 1.0,
);

Map<String, dynamic> _$ViewportToJson(_Viewport instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'zoom': instance.zoom,
};
