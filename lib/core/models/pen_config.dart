import 'package:freezed_annotation/freezed_annotation.dart';

part 'pen_config.freezed.dart';
part 'pen_config.g.dart';

@freezed
abstract class PenConfig with _$PenConfig {
  const PenConfig._();
  const factory PenConfig({
    required String color,
    required double thickness,
  }) = _PenConfig;

  factory PenConfig.fromJson(Map<String, dynamic> json) => _$PenConfigFromJson(json);
}
