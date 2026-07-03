import 'package:freezed_annotation/freezed_annotation.dart';
import 'point.dart';

part 'edge_beacon.freezed.dart';
part 'edge_beacon.g.dart';

@freezed
abstract class EdgeBeacon with _$EdgeBeacon {
  const EdgeBeacon._();
  const factory EdgeBeacon({
    required String id,
    required String tileId,
    required Point direction,
    required double angle,
    required String colorHex,
    required double distance,
    required double edgeX,
    required double edgeY,
    @Default(false) bool isClusterBeacon,
    String? clusterId,
    double? targetWorldX,
    double? targetWorldY,
  }) = _EdgeBeacon;

  factory EdgeBeacon.fromJson(Map<String, dynamic> json) => _$EdgeBeaconFromJson(json);
}
