// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'university.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$University {

 String get id; String get name; String get country; String get countryCode; List<String> get domains; List<String> get webPages; String? get stateProvince;
/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityCopyWith<University> get copyWith => _$UniversityCopyWithImpl<University>(this as University, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as University;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is University&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&const DeepCollectionEquality().equals(other.domains, _this.domains)&&const DeepCollectionEquality().equals(other.webPages, _this.webPages)&&(identical(other.stateProvince, _this.stateProvince) || other.stateProvince == _this.stateProvince));
}


@override
int get hashCode {
  final _this = this as University;
  return Object.hash(runtimeType,_this.id,_this.name,_this.country,_this.countryCode,const DeepCollectionEquality().hash(_this.domains),const DeepCollectionEquality().hash(_this.webPages),_this.stateProvince);
}

@override
String toString() {
  final _this = this as University;
  return 'University(id: ${_this.id}, name: ${_this.name}, country: ${_this.country}, countryCode: ${_this.countryCode}, domains: ${_this.domains}, webPages: ${_this.webPages}, stateProvince: ${_this.stateProvince})';
}


}

/// @nodoc
abstract mixin class $UniversityCopyWith<$Res>  {
  factory $UniversityCopyWith(University value, $Res Function(University) _then) = _$UniversityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String country, String countryCode, List<String> domains, List<String> webPages, String? stateProvince
});




}
/// @nodoc
class _$UniversityCopyWithImpl<$Res>
    implements $UniversityCopyWith<$Res> {
  _$UniversityCopyWithImpl(this._self, this._then);

  final University _self;
  final $Res Function(University) _then;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,Object? countryCode = null,Object? domains = null,Object? webPages = null,Object? stateProvince = freezed,}) {
  return _then(University(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,domains: null == domains ? _self.domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>,webPages: null == webPages ? _self.webPages : webPages // ignore: cast_nullable_to_non_nullable
as List<String>,stateProvince: freezed == stateProvince ? _self.stateProvince : stateProvince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [University].
extension UniversityPatterns on University {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _University value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _University() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _University value)  $default,){
final _that = this;
switch (_that) {
case _University():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _University value)?  $default,){
final _that = this;
switch (_that) {
case _University() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String country,  String countryCode,  List<String> domains,  List<String> webPages,  String? stateProvince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _University() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.countryCode,_that.domains,_that.webPages,_that.stateProvince);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String country,  String countryCode,  List<String> domains,  List<String> webPages,  String? stateProvince)  $default,) {final _that = this;
switch (_that) {
case _University():
return $default(_that.id,_that.name,_that.country,_that.countryCode,_that.domains,_that.webPages,_that.stateProvince);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String country,  String countryCode,  List<String> domains,  List<String> webPages,  String? stateProvince)?  $default,) {final _that = this;
switch (_that) {
case _University() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.countryCode,_that.domains,_that.webPages,_that.stateProvince);case _:
  return null;

}
}

}

/// @nodoc


class _University implements University {
  const _University({required this.id, required this.name, required this.country, required this.countryCode, required  List<String> domains, required  List<String> webPages, this.stateProvince}): _domains = domains,_webPages = webPages;
  

@override final  String id;
@override final  String name;
@override final  String country;
@override final  String countryCode;
 final  List<String> _domains;
@override List<String> get domains {
  if (_domains is EqualUnmodifiableListView) return _domains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_domains);
}

 final  List<String> _webPages;
@override List<String> get webPages {
  if (_webPages is EqualUnmodifiableListView) return _webPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_webPages);
}

@override final  String? stateProvince;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityCopyWith<_University> get copyWith => __$UniversityCopyWithImpl<_University>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _University&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&const DeepCollectionEquality().equals(other.domains, _domains)&&const DeepCollectionEquality().equals(other.webPages, _webPages)&&(identical(other.stateProvince, stateProvince) || other.stateProvince == stateProvince));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,country,countryCode,const DeepCollectionEquality().hash(_domains),const DeepCollectionEquality().hash(_webPages),stateProvince);
}

@override
String toString() {
    return 'University(id: $id, name: $name, country: $country, countryCode: $countryCode, domains: $domains, webPages: $webPages, stateProvince: $stateProvince)';
}


}

/// @nodoc
abstract mixin class _$UniversityCopyWith<$Res> implements $UniversityCopyWith<$Res> {
  factory _$UniversityCopyWith(_University value, $Res Function(_University) _then) = __$UniversityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String country, String countryCode, List<String> domains, List<String> webPages, String? stateProvince
});




}
/// @nodoc
class __$UniversityCopyWithImpl<$Res>
    implements _$UniversityCopyWith<$Res> {
  __$UniversityCopyWithImpl(this._self, this._then);

  final _University _self;
  final $Res Function(_University) _then;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,Object? countryCode = null,Object? domains = null,Object? webPages = null,Object? stateProvince = freezed,}) {
  return _then(_University(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,domains: null == domains ? _self._domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>,webPages: null == webPages ? _self._webPages : webPages // ignore: cast_nullable_to_non_nullable
as List<String>,stateProvince: freezed == stateProvince ? _self.stateProvince : stateProvince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
