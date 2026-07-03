import 'package:freezed_annotation/freezed_annotation.dart';

part 'viewport.freezed.dart';
part 'viewport.g.dart';

@freezed
abstract class Viewport with _$Viewport {
  const Viewport._();
  const factory Viewport({
    required double x,
    required double y,
    @Default(1.0) double zoom,
  }) = _Viewport;

  factory Viewport.fromJson(Map<String, dynamic> json) => _$ViewportFromJson(json);
}
