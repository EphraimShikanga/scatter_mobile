// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pen_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PenConfig _$PenConfigFromJson(Map<String, dynamic> json) => _PenConfig(
  color: json['color'] as String,
  thickness: (json['thickness'] as num).toDouble(),
);

Map<String, dynamic> _$PenConfigToJson(_PenConfig instance) =>
    <String, dynamic>{'color': instance.color, 'thickness': instance.thickness};
