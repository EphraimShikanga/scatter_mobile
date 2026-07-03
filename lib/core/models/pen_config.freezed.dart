// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pen_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PenConfig {

 String get color; double get thickness;
/// Create a copy of PenConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenConfigCopyWith<PenConfig> get copyWith => _$PenConfigCopyWithImpl<PenConfig>(this as PenConfig, _$identity);

  /// Serializes this PenConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenConfig&&(identical(other.color, color) || other.color == color)&&(identical(other.thickness, thickness) || other.thickness == thickness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,thickness);

@override
String toString() {
  return 'PenConfig(color: $color, thickness: $thickness)';
}


}

/// @nodoc
abstract mixin class $PenConfigCopyWith<$Res>  {
  factory $PenConfigCopyWith(PenConfig value, $Res Function(PenConfig) _then) = _$PenConfigCopyWithImpl;
@useResult
$Res call({
 String color, double thickness
});




}
/// @nodoc
class _$PenConfigCopyWithImpl<$Res>
    implements $PenConfigCopyWith<$Res> {
  _$PenConfigCopyWithImpl(this._self, this._then);

  final PenConfig _self;
  final $Res Function(PenConfig) _then;

/// Create a copy of PenConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? thickness = null,}) {
  return _then(_self.copyWith(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,thickness: null == thickness ? _self.thickness : thickness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PenConfig].
extension PenConfigPatterns on PenConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PenConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PenConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PenConfig value)  $default,){
final _that = this;
switch (_that) {
case _PenConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PenConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PenConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String color,  double thickness)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PenConfig() when $default != null:
return $default(_that.color,_that.thickness);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String color,  double thickness)  $default,) {final _that = this;
switch (_that) {
case _PenConfig():
return $default(_that.color,_that.thickness);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String color,  double thickness)?  $default,) {final _that = this;
switch (_that) {
case _PenConfig() when $default != null:
return $default(_that.color,_that.thickness);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PenConfig extends PenConfig {
  const _PenConfig({required this.color, required this.thickness}): super._();
  factory _PenConfig.fromJson(Map<String, dynamic> json) => _$PenConfigFromJson(json);

@override final  String color;
@override final  double thickness;

/// Create a copy of PenConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PenConfigCopyWith<_PenConfig> get copyWith => __$PenConfigCopyWithImpl<_PenConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PenConfig&&(identical(other.color, color) || other.color == color)&&(identical(other.thickness, thickness) || other.thickness == thickness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,thickness);

@override
String toString() {
  return 'PenConfig(color: $color, thickness: $thickness)';
}


}

/// @nodoc
abstract mixin class _$PenConfigCopyWith<$Res> implements $PenConfigCopyWith<$Res> {
  factory _$PenConfigCopyWith(_PenConfig value, $Res Function(_PenConfig) _then) = __$PenConfigCopyWithImpl;
@override @useResult
$Res call({
 String color, double thickness
});




}
/// @nodoc
class __$PenConfigCopyWithImpl<$Res>
    implements _$PenConfigCopyWith<$Res> {
  __$PenConfigCopyWithImpl(this._self, this._then);

  final _PenConfig _self;
  final $Res Function(_PenConfig) _then;

/// Create a copy of PenConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? thickness = null,}) {
  return _then(_PenConfig(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,thickness: null == thickness ? _self.thickness : thickness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
