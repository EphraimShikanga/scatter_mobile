// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_beacon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EdgeBeacon _$EdgeBeaconFromJson(Map<String, dynamic> json) => _EdgeBeacon(
  id: json['id'] as String,
  tileId: json['tileId'] as String,
  direction: Point.fromJson(json['direction'] as Map<String, dynamic>),
  angle: (json['angle'] as num).toDouble(),
  colorHex: json['colorHex'] as String,
  distance: (json['distance'] as num).toDouble(),
  edgeX: (json['edgeX'] as num).toDouble(),
  edgeY: (json['edgeY'] as num).toDouble(),
  isClusterBeacon: json['isClusterBeacon'] as bool? ?? false,
  clusterId: json['clusterId'] as String?,
  targetWorldX: (json['targetWorldX'] as num?)?.toDouble(),
  targetWorldY: (json['targetWorldY'] as num?)?.toDouble(),
);

Map<String, dynamic> _$EdgeBeaconToJson(_EdgeBeacon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tileId': instance.tileId,
      'direction': instance.direction,
      'angle': instance.angle,
      'colorHex': instance.colorHex,
      'distance': instance.distance,
      'edgeX': instance.edgeX,
      'edgeY': instance.edgeY,
      'isClusterBeacon': instance.isClusterBeacon,
      'clusterId': instance.clusterId,
      'targetWorldX': instance.targetWorldX,
      'targetWorldY': instance.targetWorldY,
    };
