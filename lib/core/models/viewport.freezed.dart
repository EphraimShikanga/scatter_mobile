// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Viewport {

 double get x; double get y; double get zoom;
/// Create a copy of Viewport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewportCopyWith<Viewport> get copyWith => _$ViewportCopyWithImpl<Viewport>(this as Viewport, _$identity);

  /// Serializes this Viewport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Viewport&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,zoom);

@override
String toString() {
  return 'Viewport(x: $x, y: $y, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $ViewportCopyWith<$Res>  {
  factory $ViewportCopyWith(Viewport value, $Res Function(Viewport) _then) = _$ViewportCopyWithImpl;
@useResult
$Res call({
 double x, double y, double zoom
});




}
/// @nodoc
class _$ViewportCopyWithImpl<$Res>
    implements $ViewportCopyWith<$Res> {
  _$ViewportCopyWithImpl(this._self, this._then);

  final Viewport _self;
  final $Res Function(Viewport) _then;

/// Create a copy of Viewport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? zoom = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Viewport].
extension ViewportPatterns on Viewport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Viewport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Viewport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Viewport value)  $default,){
final _that = this;
switch (_that) {
case _Viewport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Viewport value)?  $default,){
final _that = this;
switch (_that) {
case _Viewport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y,  double zoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Viewport() when $default != null:
return $default(_that.x,_that.y,_that.zoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y,  double zoom)  $default,) {final _that = this;
switch (_that) {
case _Viewport():
return $default(_that.x,_that.y,_that.zoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y,  double zoom)?  $default,) {final _that = this;
switch (_that) {
case _Viewport() when $default != null:
return $default(_that.x,_that.y,_that.zoom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Viewport extends Viewport {
  const _Viewport({required this.x, required this.y, this.zoom = 1.0}): super._();
  factory _Viewport.fromJson(Map<String, dynamic> json) => _$ViewportFromJson(json);

@override final  double x;
@override final  double y;
@override@JsonKey() final  double zoom;

/// Create a copy of Viewport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ViewportCopyWith<_Viewport> get copyWith => __$ViewportCopyWithImpl<_Viewport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ViewportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Viewport&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,zoom);

@override
String toString() {
  return 'Viewport(x: $x, y: $y, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$ViewportCopyWith<$Res> implements $ViewportCopyWith<$Res> {
  factory _$ViewportCopyWith(_Viewport value, $Res Function(_Viewport) _then) = __$ViewportCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double zoom
});




}
/// @nodoc
class __$ViewportCopyWithImpl<$Res>
    implements _$ViewportCopyWith<$Res> {
  __$ViewportCopyWithImpl(this._self, this._then);

  final _Viewport _self;
  final $Res Function(_Viewport) _then;

/// Create a copy of Viewport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? zoom = null,}) {
  return _then(_Viewport(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
