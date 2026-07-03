import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';
part 'point.g.dart';

@freezed
abstract class Point with _$Point {
  const Point._();
  const factory Point({
    required double x,
    required double y,
    double? pressure,
  }) = _Point;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}
