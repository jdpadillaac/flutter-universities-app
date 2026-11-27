// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'universities_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UniversitiesPage {

 List<University> get items; bool get hasReachedMax;
/// Create a copy of UniversitiesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversitiesPageCopyWith<UniversitiesPage> get copyWith => _$UniversitiesPageCopyWithImpl<UniversitiesPage>(this as UniversitiesPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UniversitiesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversitiesPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.hasReachedMax, _this.hasReachedMax) || other.hasReachedMax == _this.hasReachedMax));
}


@override
int get hashCode {
  final _this = this as UniversitiesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.hasReachedMax);
}

@override
String toString() {
  final _this = this as UniversitiesPage;
  return 'UniversitiesPage(items: ${_this.items}, hasReachedMax: ${_this.hasReachedMax})';
}


}

/// @nodoc
abstract mixin class $UniversitiesPageCopyWith<$Res>  {
  factory $UniversitiesPageCopyWith(UniversitiesPage value, $Res Function(UniversitiesPage) _then) = _$UniversitiesPageCopyWithImpl;
@useResult
$Res call({
 List<University> items, bool hasReachedMax
});




}
/// @nodoc
class _$UniversitiesPageCopyWithImpl<$Res>
    implements $UniversitiesPageCopyWith<$Res> {
  _$UniversitiesPageCopyWithImpl(this._self, this._then);

  final UniversitiesPage _self;
  final $Res Function(UniversitiesPage) _then;

/// Create a copy of UniversitiesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasReachedMax = null,}) {
  return _then(UniversitiesPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<University>,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UniversitiesPage].
extension UniversitiesPagePatterns on UniversitiesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UniversitiesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UniversitiesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UniversitiesPage value)  $default,){
final _that = this;
switch (_that) {
case _UniversitiesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UniversitiesPage value)?  $default,){
final _that = this;
switch (_that) {
case _UniversitiesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<University> items,  bool hasReachedMax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UniversitiesPage() when $default != null:
return $default(_that.items,_that.hasReachedMax);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<University> items,  bool hasReachedMax)  $default,) {final _that = this;
switch (_that) {
case _UniversitiesPage():
return $default(_that.items,_that.hasReachedMax);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<University> items,  bool hasReachedMax)?  $default,) {final _that = this;
switch (_that) {
case _UniversitiesPage() when $default != null:
return $default(_that.items,_that.hasReachedMax);case _:
  return null;

}
}

}

/// @nodoc


class _UniversitiesPage implements UniversitiesPage {
  const _UniversitiesPage({required  List<University> items, required this.hasReachedMax}): _items = items;
  

 final  List<University> _items;
@override List<University> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasReachedMax;

/// Create a copy of UniversitiesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversitiesPageCopyWith<_UniversitiesPage> get copyWith => __$UniversitiesPageCopyWithImpl<_UniversitiesPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversitiesPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasReachedMax);
}

@override
String toString() {
    return 'UniversitiesPage(items: $items, hasReachedMax: $hasReachedMax)';
}


}

/// @nodoc
abstract mixin class _$UniversitiesPageCopyWith<$Res> implements $UniversitiesPageCopyWith<$Res> {
  factory _$UniversitiesPageCopyWith(_UniversitiesPage value, $Res Function(_UniversitiesPage) _then) = __$UniversitiesPageCopyWithImpl;
@override @useResult
$Res call({
 List<University> items, bool hasReachedMax
});




}
/// @nodoc
class __$UniversitiesPageCopyWithImpl<$Res>
    implements _$UniversitiesPageCopyWith<$Res> {
  __$UniversitiesPageCopyWithImpl(this._self, this._then);

  final _UniversitiesPage _self;
  final $Res Function(_UniversitiesPage) _then;

/// Create a copy of UniversitiesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasReachedMax = null,}) {
  return _then(_UniversitiesPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<University>,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
