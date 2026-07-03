// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge_beacon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EdgeBeacon {

 String get id; String get tileId; Point get direction; double get angle; String get colorHex; double get distance; double get edgeX; double get edgeY; bool get isClusterBeacon; String? get clusterId; double? get targetWorldX; double? get targetWorldY;
/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EdgeBeaconCopyWith<EdgeBeacon> get copyWith => _$EdgeBeaconCopyWithImpl<EdgeBeacon>(this as EdgeBeacon, _$identity);

  /// Serializes this EdgeBeacon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdgeBeacon&&(identical(other.id, id) || other.id == id)&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.edgeX, edgeX) || other.edgeX == edgeX)&&(identical(other.edgeY, edgeY) || other.edgeY == edgeY)&&(identical(other.isClusterBeacon, isClusterBeacon) || other.isClusterBeacon == isClusterBeacon)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.targetWorldX, targetWorldX) || other.targetWorldX == targetWorldX)&&(identical(other.targetWorldY, targetWorldY) || other.targetWorldY == targetWorldY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tileId,direction,angle,colorHex,distance,edgeX,edgeY,isClusterBeacon,clusterId,targetWorldX,targetWorldY);

@override
String toString() {
  return 'EdgeBeacon(id: $id, tileId: $tileId, direction: $direction, angle: $angle, colorHex: $colorHex, distance: $distance, edgeX: $edgeX, edgeY: $edgeY, isClusterBeacon: $isClusterBeacon, clusterId: $clusterId, targetWorldX: $targetWorldX, targetWorldY: $targetWorldY)';
}


}

/// @nodoc
abstract mixin class $EdgeBeaconCopyWith<$Res>  {
  factory $EdgeBeaconCopyWith(EdgeBeacon value, $Res Function(EdgeBeacon) _then) = _$EdgeBeaconCopyWithImpl;
@useResult
$Res call({
 String id, String tileId, Point direction, double angle, String colorHex, double distance, double edgeX, double edgeY, bool isClusterBeacon, String? clusterId, double? targetWorldX, double? targetWorldY
});


$PointCopyWith<$Res> get direction;

}
/// @nodoc
class _$EdgeBeaconCopyWithImpl<$Res>
    implements $EdgeBeaconCopyWith<$Res> {
  _$EdgeBeaconCopyWithImpl(this._self, this._then);

  final EdgeBeacon _self;
  final $Res Function(EdgeBeacon) _then;

/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tileId = null,Object? direction = null,Object? angle = null,Object? colorHex = null,Object? distance = null,Object? edgeX = null,Object? edgeY = null,Object? isClusterBeacon = null,Object? clusterId = freezed,Object? targetWorldX = freezed,Object? targetWorldY = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Point,angle: null == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,edgeX: null == edgeX ? _self.edgeX : edgeX // ignore: cast_nullable_to_non_nullable
as double,edgeY: null == edgeY ? _self.edgeY : edgeY // ignore: cast_nullable_to_non_nullable
as double,isClusterBeacon: null == isClusterBeacon ? _self.isClusterBeacon : isClusterBeacon // ignore: cast_nullable_to_non_nullable
as bool,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as String?,targetWorldX: freezed == targetWorldX ? _self.targetWorldX : targetWorldX // ignore: cast_nullable_to_non_nullable
as double?,targetWorldY: freezed == targetWorldY ? _self.targetWorldY : targetWorldY // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointCopyWith<$Res> get direction {
  
  return $PointCopyWith<$Res>(_self.direction, (value) {
    return _then(_self.copyWith(direction: value));
  });
}
}


/// Adds pattern-matching-related methods to [EdgeBeacon].
extension EdgeBeaconPatterns on EdgeBeacon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EdgeBeacon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EdgeBeacon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EdgeBeacon value)  $default,){
final _that = this;
switch (_that) {
case _EdgeBeacon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EdgeBeacon value)?  $default,){
final _that = this;
switch (_that) {
case _EdgeBeacon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tileId,  Point direction,  double angle,  String colorHex,  double distance,  double edgeX,  double edgeY,  bool isClusterBeacon,  String? clusterId,  double? targetWorldX,  double? targetWorldY)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EdgeBeacon() when $default != null:
return $default(_that.id,_that.tileId,_that.direction,_that.angle,_that.colorHex,_that.distance,_that.edgeX,_that.edgeY,_that.isClusterBeacon,_that.clusterId,_that.targetWorldX,_that.targetWorldY);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tileId,  Point direction,  double angle,  String colorHex,  double distance,  double edgeX,  double edgeY,  bool isClusterBeacon,  String? clusterId,  double? targetWorldX,  double? targetWorldY)  $default,) {final _that = this;
switch (_that) {
case _EdgeBeacon():
return $default(_that.id,_that.tileId,_that.direction,_that.angle,_that.colorHex,_that.distance,_that.edgeX,_that.edgeY,_that.isClusterBeacon,_that.clusterId,_that.targetWorldX,_that.targetWorldY);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tileId,  Point direction,  double angle,  String colorHex,  double distance,  double edgeX,  double edgeY,  bool isClusterBeacon,  String? clusterId,  double? targetWorldX,  double? targetWorldY)?  $default,) {final _that = this;
switch (_that) {
case _EdgeBeacon() when $default != null:
return $default(_that.id,_that.tileId,_that.direction,_that.angle,_that.colorHex,_that.distance,_that.edgeX,_that.edgeY,_that.isClusterBeacon,_that.clusterId,_that.targetWorldX,_that.targetWorldY);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EdgeBeacon extends EdgeBeacon {
  const _EdgeBeacon({required this.id, required this.tileId, required this.direction, required this.angle, required this.colorHex, required this.distance, required this.edgeX, required this.edgeY, this.isClusterBeacon = false, this.clusterId, this.targetWorldX, this.targetWorldY}): super._();
  factory _EdgeBeacon.fromJson(Map<String, dynamic> json) => _$EdgeBeaconFromJson(json);

@override final  String id;
@override final  String tileId;
@override final  Point direction;
@override final  double angle;
@override final  String colorHex;
@override final  double distance;
@override final  double edgeX;
@override final  double edgeY;
@override@JsonKey() final  bool isClusterBeacon;
@override final  String? clusterId;
@override final  double? targetWorldX;
@override final  double? targetWorldY;

/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EdgeBeaconCopyWith<_EdgeBeacon> get copyWith => __$EdgeBeaconCopyWithImpl<_EdgeBeacon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EdgeBeaconToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EdgeBeacon&&(identical(other.id, id) || other.id == id)&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.edgeX, edgeX) || other.edgeX == edgeX)&&(identical(other.edgeY, edgeY) || other.edgeY == edgeY)&&(identical(other.isClusterBeacon, isClusterBeacon) || other.isClusterBeacon == isClusterBeacon)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.targetWorldX, targetWorldX) || other.targetWorldX == targetWorldX)&&(identical(other.targetWorldY, targetWorldY) || other.targetWorldY == targetWorldY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tileId,direction,angle,colorHex,distance,edgeX,edgeY,isClusterBeacon,clusterId,targetWorldX,targetWorldY);

@override
String toString() {
  return 'EdgeBeacon(id: $id, tileId: $tileId, direction: $direction, angle: $angle, colorHex: $colorHex, distance: $distance, edgeX: $edgeX, edgeY: $edgeY, isClusterBeacon: $isClusterBeacon, clusterId: $clusterId, targetWorldX: $targetWorldX, targetWorldY: $targetWorldY)';
}


}

/// @nodoc
abstract mixin class _$EdgeBeaconCopyWith<$Res> implements $EdgeBeaconCopyWith<$Res> {
  factory _$EdgeBeaconCopyWith(_EdgeBeacon value, $Res Function(_EdgeBeacon) _then) = __$EdgeBeaconCopyWithImpl;
@override @useResult
$Res call({
 String id, String tileId, Point direction, double angle, String colorHex, double distance, double edgeX, double edgeY, bool isClusterBeacon, String? clusterId, double? targetWorldX, double? targetWorldY
});


@override $PointCopyWith<$Res> get direction;

}
/// @nodoc
class __$EdgeBeaconCopyWithImpl<$Res>
    implements _$EdgeBeaconCopyWith<$Res> {
  __$EdgeBeaconCopyWithImpl(this._self, this._then);

  final _EdgeBeacon _self;
  final $Res Function(_EdgeBeacon) _then;

/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tileId = null,Object? direction = null,Object? angle = null,Object? colorHex = null,Object? distance = null,Object? edgeX = null,Object? edgeY = null,Object? isClusterBeacon = null,Object? clusterId = freezed,Object? targetWorldX = freezed,Object? targetWorldY = freezed,}) {
  return _then(_EdgeBeacon(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Point,angle: null == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,edgeX: null == edgeX ? _self.edgeX : edgeX // ignore: cast_nullable_to_non_nullable
as double,edgeY: null == edgeY ? _self.edgeY : edgeY // ignore: cast_nullable_to_non_nullable
as double,isClusterBeacon: null == isClusterBeacon ? _self.isClusterBeacon : isClusterBeacon // ignore: cast_nullable_to_non_nullable
as bool,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as String?,targetWorldX: freezed == targetWorldX ? _self.targetWorldX : targetWorldX // ignore: cast_nullable_to_non_nullable
as double?,targetWorldY: freezed == targetWorldY ? _self.targetWorldY : targetWorldY // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EdgeBeacon
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointCopyWith<$Res> get direction {
  
  return $PointCopyWith<$Res>(_self.direction, (value) {
    return _then(_self.copyWith(direction: value));
  });
}
}

// dart format on
