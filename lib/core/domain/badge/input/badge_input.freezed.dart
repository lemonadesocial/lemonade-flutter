// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetBadgesInput _$GetBadgesInputFromJson(Map<String, dynamic> json) {
  return _GetBadgesInput.fromJson(json);
}

/// @nodoc
mixin _$GetBadgesInput {
  int? get skip => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  List<String>? get list => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  List<String>? get id => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetBadgesInputCopyWith<GetBadgesInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetBadgesInputCopyWith<$Res> {
  factory $GetBadgesInputCopyWith(
          GetBadgesInput value, $Res Function(GetBadgesInput) then) =
      _$GetBadgesInputCopyWithImpl<$Res, GetBadgesInput>;
  @useResult
  $Res call(
      {int? skip,
      int? limit,
      List<String>? list,
      @JsonKey(name: '_id') List<String>? id,
      String? city,
      String? country,
      double? distance});
}

/// @nodoc
class _$GetBadgesInputCopyWithImpl<$Res, $Val extends GetBadgesInput>
    implements $GetBadgesInputCopyWith<$Res> {
  _$GetBadgesInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? list = freezed,
    Object? id = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetBadgesInputCopyWith<$Res>
    implements $GetBadgesInputCopyWith<$Res> {
  factory _$$_GetBadgesInputCopyWith(
          _$_GetBadgesInput value, $Res Function(_$_GetBadgesInput) then) =
      __$$_GetBadgesInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? skip,
      int? limit,
      List<String>? list,
      @JsonKey(name: '_id') List<String>? id,
      String? city,
      String? country,
      double? distance});
}

/// @nodoc
class __$$_GetBadgesInputCopyWithImpl<$Res>
    extends _$GetBadgesInputCopyWithImpl<$Res, _$_GetBadgesInput>
    implements _$$_GetBadgesInputCopyWith<$Res> {
  __$$_GetBadgesInputCopyWithImpl(
      _$_GetBadgesInput _value, $Res Function(_$_GetBadgesInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? list = freezed,
    Object? id = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? distance = freezed,
  }) {
    return _then(_$_GetBadgesInput(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: freezed == id
          ? _value._id
          : id // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetBadgesInput implements _GetBadgesInput {
  _$_GetBadgesInput(
      {this.skip,
      this.limit,
      final List<String>? list,
      @JsonKey(name: '_id') final List<String>? id,
      this.city,
      this.country,
      this.distance})
      : _list = list,
        _id = id;

  factory _$_GetBadgesInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetBadgesInputFromJson(json);

  @override
  final int? skip;
  @override
  final int? limit;
  final List<String>? _list;
  @override
  List<String>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _id;
  @override
  @JsonKey(name: '_id')
  List<String>? get id {
    final value = _id;
    if (value == null) return null;
    if (_id is EqualUnmodifiableListView) return _id;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? city;
  @override
  final String? country;
  @override
  final double? distance;

  @override
  String toString() {
    return 'GetBadgesInput(skip: $skip, limit: $limit, list: $list, id: $id, city: $city, country: $country, distance: $distance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetBadgesInput &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._id, _id) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      skip,
      limit,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_id),
      city,
      country,
      distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetBadgesInputCopyWith<_$_GetBadgesInput> get copyWith =>
      __$$_GetBadgesInputCopyWithImpl<_$_GetBadgesInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetBadgesInputToJson(
      this,
    );
  }
}

abstract class _GetBadgesInput implements GetBadgesInput {
  factory _GetBadgesInput(
      {final int? skip,
      final int? limit,
      final List<String>? list,
      @JsonKey(name: '_id') final List<String>? id,
      final String? city,
      final String? country,
      final double? distance}) = _$_GetBadgesInput;

  factory _GetBadgesInput.fromJson(Map<String, dynamic> json) =
      _$_GetBadgesInput.fromJson;

  @override
  int? get skip;
  @override
  int? get limit;
  @override
  List<String>? get list;
  @override
  @JsonKey(name: '_id')
  List<String>? get id;
  @override
  String? get city;
  @override
  String? get country;
  @override
  double? get distance;
  @override
  @JsonKey(ignore: true)
  _$$_GetBadgesInputCopyWith<_$_GetBadgesInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetBadgeListsInput _$GetBadgeListsInputFromJson(Map<String, dynamic> json) {
  return _GetBadgeListsInput.fromJson(json);
}

/// @nodoc
mixin _$GetBadgeListsInput {
  int? get skip => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetBadgeListsInputCopyWith<GetBadgeListsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetBadgeListsInputCopyWith<$Res> {
  factory $GetBadgeListsInputCopyWith(
          GetBadgeListsInput value, $Res Function(GetBadgeListsInput) then) =
      _$GetBadgeListsInputCopyWithImpl<$Res, GetBadgeListsInput>;
  @useResult
  $Res call({int? skip, int? limit, String? user, String? title});
}

/// @nodoc
class _$GetBadgeListsInputCopyWithImpl<$Res, $Val extends GetBadgeListsInput>
    implements $GetBadgeListsInputCopyWith<$Res> {
  _$GetBadgeListsInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? user = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetBadgeListsInputCopyWith<$Res>
    implements $GetBadgeListsInputCopyWith<$Res> {
  factory _$$_GetBadgeListsInputCopyWith(_$_GetBadgeListsInput value,
          $Res Function(_$_GetBadgeListsInput) then) =
      __$$_GetBadgeListsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? skip, int? limit, String? user, String? title});
}

/// @nodoc
class __$$_GetBadgeListsInputCopyWithImpl<$Res>
    extends _$GetBadgeListsInputCopyWithImpl<$Res, _$_GetBadgeListsInput>
    implements _$$_GetBadgeListsInputCopyWith<$Res> {
  __$$_GetBadgeListsInputCopyWithImpl(
      _$_GetBadgeListsInput _value, $Res Function(_$_GetBadgeListsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? user = freezed,
    Object? title = freezed,
  }) {
    return _then(_$_GetBadgeListsInput(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetBadgeListsInput implements _GetBadgeListsInput {
  _$_GetBadgeListsInput({this.skip, this.limit, this.user, this.title});

  factory _$_GetBadgeListsInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetBadgeListsInputFromJson(json);

  @override
  final int? skip;
  @override
  final int? limit;
  @override
  final String? user;
  @override
  final String? title;

  @override
  String toString() {
    return 'GetBadgeListsInput(skip: $skip, limit: $limit, user: $user, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetBadgeListsInput &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skip, limit, user, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetBadgeListsInputCopyWith<_$_GetBadgeListsInput> get copyWith =>
      __$$_GetBadgeListsInputCopyWithImpl<_$_GetBadgeListsInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetBadgeListsInputToJson(
      this,
    );
  }
}

abstract class _GetBadgeListsInput implements GetBadgeListsInput {
  factory _GetBadgeListsInput(
      {final int? skip,
      final int? limit,
      final String? user,
      final String? title}) = _$_GetBadgeListsInput;

  factory _GetBadgeListsInput.fromJson(Map<String, dynamic> json) =
      _$_GetBadgeListsInput.fromJson;

  @override
  int? get skip;
  @override
  int? get limit;
  @override
  String? get user;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_GetBadgeListsInputCopyWith<_$_GetBadgeListsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetBadgeCitiesInput _$GetBadgeCitiesInputFromJson(Map<String, dynamic> json) {
  return _GetBadgeCitiesInput.fromJson(json);
}

/// @nodoc
mixin _$GetBadgeCitiesInput {
  int? get skip => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetBadgeCitiesInputCopyWith<GetBadgeCitiesInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetBadgeCitiesInputCopyWith<$Res> {
  factory $GetBadgeCitiesInputCopyWith(
          GetBadgeCitiesInput value, $Res Function(GetBadgeCitiesInput) then) =
      _$GetBadgeCitiesInputCopyWithImpl<$Res, GetBadgeCitiesInput>;
  @useResult
  $Res call({int? skip, int? limit, String? user, String? title});
}

/// @nodoc
class _$GetBadgeCitiesInputCopyWithImpl<$Res, $Val extends GetBadgeCitiesInput>
    implements $GetBadgeCitiesInputCopyWith<$Res> {
  _$GetBadgeCitiesInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? user = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetBadgeCitiesInputCopyWith<$Res>
    implements $GetBadgeCitiesInputCopyWith<$Res> {
  factory _$$_GetBadgeCitiesInputCopyWith(_$_GetBadgeCitiesInput value,
          $Res Function(_$_GetBadgeCitiesInput) then) =
      __$$_GetBadgeCitiesInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? skip, int? limit, String? user, String? title});
}

/// @nodoc
class __$$_GetBadgeCitiesInputCopyWithImpl<$Res>
    extends _$GetBadgeCitiesInputCopyWithImpl<$Res, _$_GetBadgeCitiesInput>
    implements _$$_GetBadgeCitiesInputCopyWith<$Res> {
  __$$_GetBadgeCitiesInputCopyWithImpl(_$_GetBadgeCitiesInput _value,
      $Res Function(_$_GetBadgeCitiesInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? user = freezed,
    Object? title = freezed,
  }) {
    return _then(_$_GetBadgeCitiesInput(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetBadgeCitiesInput implements _GetBadgeCitiesInput {
  _$_GetBadgeCitiesInput({this.skip, this.limit, this.user, this.title});

  factory _$_GetBadgeCitiesInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetBadgeCitiesInputFromJson(json);

  @override
  final int? skip;
  @override
  final int? limit;
  @override
  final String? user;
  @override
  final String? title;

  @override
  String toString() {
    return 'GetBadgeCitiesInput(skip: $skip, limit: $limit, user: $user, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetBadgeCitiesInput &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skip, limit, user, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetBadgeCitiesInputCopyWith<_$_GetBadgeCitiesInput> get copyWith =>
      __$$_GetBadgeCitiesInputCopyWithImpl<_$_GetBadgeCitiesInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetBadgeCitiesInputToJson(
      this,
    );
  }
}

abstract class _GetBadgeCitiesInput implements GetBadgeCitiesInput {
  factory _GetBadgeCitiesInput(
      {final int? skip,
      final int? limit,
      final String? user,
      final String? title}) = _$_GetBadgeCitiesInput;

  factory _GetBadgeCitiesInput.fromJson(Map<String, dynamic> json) =
      _$_GetBadgeCitiesInput.fromJson;

  @override
  int? get skip;
  @override
  int? get limit;
  @override
  String? get user;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_GetBadgeCitiesInputCopyWith<_$_GetBadgeCitiesInput> get copyWith =>
      throw _privateConstructorUsedError;
}
