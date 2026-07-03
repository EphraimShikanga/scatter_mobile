// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stroke.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Stroke {

 String get id; List<Point> get points; String get color; double get thickness;
/// Create a copy of Stroke
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrokeCopyWith<Stroke> get copyWith => _$StrokeCopyWithImpl<Stroke>(this as Stroke, _$identity);

  /// Serializes this Stroke to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stroke&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.color, color) || other.color == color)&&(identical(other.thickness, thickness) || other.thickness == thickness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(points),color,thickness);

@override
String toString() {
  return 'Stroke(id: $id, points: $points, color: $color, thickness: $thickness)';
}


}

/// @nodoc
abstract mixin class $StrokeCopyWith<$Res>  {
  factory $StrokeCopyWith(Stroke value, $Res Function(Stroke) _then) = _$StrokeCopyWithImpl;
@useResult
$Res call({
 String id, List<Point> points, String color, double thickness
});




}
/// @nodoc
class _$StrokeCopyWithImpl<$Res>
    implements $StrokeCopyWith<$Res> {
  _$StrokeCopyWithImpl(this._self, this._then);

  final Stroke _self;
  final $Res Function(Stroke) _then;

/// Create a copy of Stroke
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? points = null,Object? color = null,Object? thickness = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<Point>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,thickness: null == thickness ? _self.thickness : thickness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Stroke].
extension StrokePatterns on Stroke {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stroke value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stroke() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stroke value)  $default,){
final _that = this;
switch (_that) {
case _Stroke():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stroke value)?  $default,){
final _that = this;
switch (_that) {
case _Stroke() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<Point> points,  String color,  double thickness)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stroke() when $default != null:
return $default(_that.id,_that.points,_that.color,_that.thickness);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<Point> points,  String color,  double thickness)  $default,) {final _that = this;
switch (_that) {
case _Stroke():
return $default(_that.id,_that.points,_that.color,_that.thickness);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<Point> points,  String color,  double thickness)?  $default,) {final _that = this;
switch (_that) {
case _Stroke() when $default != null:
return $default(_that.id,_that.points,_that.color,_that.thickness);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stroke extends Stroke {
  const _Stroke({required this.id, final  List<Point> points = const [], required this.color, required this.thickness}): _points = points,super._();
  factory _Stroke.fromJson(Map<String, dynamic> json) => _$StrokeFromJson(json);

@override final  String id;
 final  List<Point> _points;
@override@JsonKey() List<Point> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  String color;
@override final  double thickness;

/// Create a copy of Stroke
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StrokeCopyWith<_Stroke> get copyWith => __$StrokeCopyWithImpl<_Stroke>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StrokeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stroke&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.color, color) || other.color == color)&&(identical(other.thickness, thickness) || other.thickness == thickness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_points),color,thickness);

@override
String toString() {
  return 'Stroke(id: $id, points: $points, color: $color, thickness: $thickness)';
}


}

/// @nodoc
abstract mixin class _$StrokeCopyWith<$Res> implements $StrokeCopyWith<$Res> {
  factory _$StrokeCopyWith(_Stroke value, $Res Function(_Stroke) _then) = __$StrokeCopyWithImpl;
@override @useResult
$Res call({
 String id, List<Point> points, String color, double thickness
});




}
/// @nodoc
class __$StrokeCopyWithImpl<$Res>
    implements _$StrokeCopyWith<$Res> {
  __$StrokeCopyWithImpl(this._self, this._then);

  final _Stroke _self;
  final $Res Function(_Stroke) _then;

/// Create a copy of Stroke
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? points = null,Object? color = null,Object? thickness = null,}) {
  return _then(_Stroke(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<Point>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,thickness: null == thickness ? _self.thickness : thickness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
