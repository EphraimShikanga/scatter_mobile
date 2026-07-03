import 'package:freezed_annotation/freezed_annotation.dart';
import 'point.dart';

part 'stroke.freezed.dart';
part 'stroke.g.dart';

@freezed
abstract class Stroke with _$Stroke {
  const Stroke._();
  const factory Stroke({
    required String id,
    @Default([]) List<Point> points,
    required String color,
    required double thickness,
  }) = _Stroke;

  factory Stroke.fromJson(Map<String, dynamic> json) => _$StrokeFromJson(json);
}
