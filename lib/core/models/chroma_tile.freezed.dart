// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chroma_tile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChromaTile {

 String get id; double get x; double get y; double get width; double get height; String get colorName; String get colorHex; String get title; String get content; List<Stroke> get strokes; bool get isArchived; bool get isSunk; int get createdAt; String? get clusterId; bool get isMicro; List<int> get struckLineIndices;
/// Create a copy of ChromaTile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChromaTileCopyWith<ChromaTile> get copyWith => _$ChromaTileCopyWithImpl<ChromaTile>(this as ChromaTile, _$identity);

  /// Serializes this ChromaTile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChromaTile&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.colorName, colorName) || other.colorName == colorName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.strokes, strokes)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isSunk, isSunk) || other.isSunk == isSunk)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.isMicro, isMicro) || other.isMicro == isMicro)&&const DeepCollectionEquality().equals(other.struckLineIndices, struckLineIndices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,x,y,width,height,colorName,colorHex,title,content,const DeepCollectionEquality().hash(strokes),isArchived,isSunk,createdAt,clusterId,isMicro,const DeepCollectionEquality().hash(struckLineIndices));

@override
String toString() {
  return 'ChromaTile(id: $id, x: $x, y: $y, width: $width, height: $height, colorName: $colorName, colorHex: $colorHex, title: $title, content: $content, strokes: $strokes, isArchived: $isArchived, isSunk: $isSunk, createdAt: $createdAt, clusterId: $clusterId, isMicro: $isMicro, struckLineIndices: $struckLineIndices)';
}


}

/// @nodoc
abstract mixin class $ChromaTileCopyWith<$Res>  {
  factory $ChromaTileCopyWith(ChromaTile value, $Res Function(ChromaTile) _then) = _$ChromaTileCopyWithImpl;
@useResult
$Res call({
 String id, double x, double y, double width, double height, String colorName, String colorHex, String title, String content, List<Stroke> strokes, bool isArchived, bool isSunk, int createdAt, String? clusterId, bool isMicro, List<int> struckLineIndices
});




}
/// @nodoc
class _$ChromaTileCopyWithImpl<$Res>
    implements $ChromaTileCopyWith<$Res> {
  _$ChromaTileCopyWithImpl(this._self, this._then);

  final ChromaTile _self;
  final $Res Function(ChromaTile) _then;

/// Create a copy of ChromaTile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? colorName = null,Object? colorHex = null,Object? title = null,Object? content = null,Object? strokes = null,Object? isArchived = null,Object? isSunk = null,Object? createdAt = null,Object? clusterId = freezed,Object? isMicro = null,Object? struckLineIndices = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,colorName: null == colorName ? _self.colorName : colorName // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,strokes: null == strokes ? _self.strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<Stroke>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isSunk: null == isSunk ? _self.isSunk : isSunk // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as String?,isMicro: null == isMicro ? _self.isMicro : isMicro // ignore: cast_nullable_to_non_nullable
as bool,struckLineIndices: null == struckLineIndices ? _self.struckLineIndices : struckLineIndices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChromaTile].
extension ChromaTilePatterns on ChromaTile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChromaTile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChromaTile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChromaTile value)  $default,){
final _that = this;
switch (_that) {
case _ChromaTile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChromaTile value)?  $default,){
final _that = this;
switch (_that) {
case _ChromaTile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double x,  double y,  double width,  double height,  String colorName,  String colorHex,  String title,  String content,  List<Stroke> strokes,  bool isArchived,  bool isSunk,  int createdAt,  String? clusterId,  bool isMicro,  List<int> struckLineIndices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChromaTile() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.width,_that.height,_that.colorName,_that.colorHex,_that.title,_that.content,_that.strokes,_that.isArchived,_that.isSunk,_that.createdAt,_that.clusterId,_that.isMicro,_that.struckLineIndices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double x,  double y,  double width,  double height,  String colorName,  String colorHex,  String title,  String content,  List<Stroke> strokes,  bool isArchived,  bool isSunk,  int createdAt,  String? clusterId,  bool isMicro,  List<int> struckLineIndices)  $default,) {final _that = this;
switch (_that) {
case _ChromaTile():
return $default(_that.id,_that.x,_that.y,_that.width,_that.height,_that.colorName,_that.colorHex,_that.title,_that.content,_that.strokes,_that.isArchived,_that.isSunk,_that.createdAt,_that.clusterId,_that.isMicro,_that.struckLineIndices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double x,  double y,  double width,  double height,  String colorName,  String colorHex,  String title,  String content,  List<Stroke> strokes,  bool isArchived,  bool isSunk,  int createdAt,  String? clusterId,  bool isMicro,  List<int> struckLineIndices)?  $default,) {final _that = this;
switch (_that) {
case _ChromaTile() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.width,_that.height,_that.colorName,_that.colorHex,_that.title,_that.content,_that.strokes,_that.isArchived,_that.isSunk,_that.createdAt,_that.clusterId,_that.isMicro,_that.struckLineIndices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChromaTile extends ChromaTile {
  const _ChromaTile({required this.id, required this.x, required this.y, required this.width, required this.height, required this.colorName, required this.colorHex, required this.title, required this.content, final  List<Stroke> strokes = const [], this.isArchived = false, this.isSunk = false, required this.createdAt, this.clusterId, this.isMicro = false, final  List<int> struckLineIndices = const []}): _strokes = strokes,_struckLineIndices = struckLineIndices,super._();
  factory _ChromaTile.fromJson(Map<String, dynamic> json) => _$ChromaTileFromJson(json);

@override final  String id;
@override final  double x;
@override final  double y;
@override final  double width;
@override final  double height;
@override final  String colorName;
@override final  String colorHex;
@override final  String title;
@override final  String content;
 final  List<Stroke> _strokes;
@override@JsonKey() List<Stroke> get strokes {
  if (_strokes is EqualUnmodifiableListView) return _strokes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strokes);
}

@override@JsonKey() final  bool isArchived;
@override@JsonKey() final  bool isSunk;
@override final  int createdAt;
@override final  String? clusterId;
@override@JsonKey() final  bool isMicro;
 final  List<int> _struckLineIndices;
@override@JsonKey() List<int> get struckLineIndices {
  if (_struckLineIndices is EqualUnmodifiableListView) return _struckLineIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_struckLineIndices);
}


/// Create a copy of ChromaTile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChromaTileCopyWith<_ChromaTile> get copyWith => __$ChromaTileCopyWithImpl<_ChromaTile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChromaTileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChromaTile&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.colorName, colorName) || other.colorName == colorName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._strokes, _strokes)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isSunk, isSunk) || other.isSunk == isSunk)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.isMicro, isMicro) || other.isMicro == isMicro)&&const DeepCollectionEquality().equals(other._struckLineIndices, _struckLineIndices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,x,y,width,height,colorName,colorHex,title,content,const DeepCollectionEquality().hash(_strokes),isArchived,isSunk,createdAt,clusterId,isMicro,const DeepCollectionEquality().hash(_struckLineIndices));

@override
String toString() {
  return 'ChromaTile(id: $id, x: $x, y: $y, width: $width, height: $height, colorName: $colorName, colorHex: $colorHex, title: $title, content: $content, strokes: $strokes, isArchived: $isArchived, isSunk: $isSunk, createdAt: $createdAt, clusterId: $clusterId, isMicro: $isMicro, struckLineIndices: $struckLineIndices)';
}


}

/// @nodoc
abstract mixin class _$ChromaTileCopyWith<$Res> implements $ChromaTileCopyWith<$Res> {
  factory _$ChromaTileCopyWith(_ChromaTile value, $Res Function(_ChromaTile) _then) = __$ChromaTileCopyWithImpl;
@override @useResult
$Res call({
 String id, double x, double y, double width, double height, String colorName, String colorHex, String title, String content, List<Stroke> strokes, bool isArchived, bool isSunk, int createdAt, String? clusterId, bool isMicro, List<int> struckLineIndices
});




}
/// @nodoc
class __$ChromaTileCopyWithImpl<$Res>
    implements _$ChromaTileCopyWith<$Res> {
  __$ChromaTileCopyWithImpl(this._self, this._then);

  final _ChromaTile _self;
  final $Res Function(_ChromaTile) _then;

/// Create a copy of ChromaTile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? colorName = null,Object? colorHex = null,Object? title = null,Object? content = null,Object? strokes = null,Object? isArchived = null,Object? isSunk = null,Object? createdAt = null,Object? clusterId = freezed,Object? isMicro = null,Object? struckLineIndices = null,}) {
  return _then(_ChromaTile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,colorName: null == colorName ? _self.colorName : colorName // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,strokes: null == strokes ? _self._strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<Stroke>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isSunk: null == isSunk ? _self.isSunk : isSunk // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as String?,isMicro: null == isMicro ? _self.isMicro : isMicro // ignore: cast_nullable_to_non_nullable
as bool,struckLineIndices: null == struckLineIndices ? _self._struckLineIndices : struckLineIndices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
