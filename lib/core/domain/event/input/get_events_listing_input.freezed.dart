// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_events_listing_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetEventsInput _$GetEventsInputFromJson(Map<String, dynamic> json) {
  return _GetEventsInput.fromJson(json);
}

/// @nodoc
mixin _$GetEventsInput {
  @JsonKey(includeIfNull: false)
  String? get search => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  bool? get highlight => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get accepted => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get skip => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetEventsInputCopyWith<GetEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetEventsInputCopyWith<$Res> {
  factory $GetEventsInputCopyWith(
          GetEventsInput value, $Res Function(GetEventsInput) then) =
      _$GetEventsInputCopyWithImpl<$Res, GetEventsInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? search,
      @JsonKey(includeIfNull: false) bool? highlight,
      @JsonKey(includeIfNull: false) String? accepted,
      int limit,
      int skip});
}

/// @nodoc
class _$GetEventsInputCopyWithImpl<$Res, $Val extends GetEventsInput>
    implements $GetEventsInputCopyWith<$Res> {
  _$GetEventsInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? highlight = freezed,
    Object? accepted = freezed,
    Object? limit = null,
    Object? skip = null,
  }) {
    return _then(_value.copyWith(
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      highlight: freezed == highlight
          ? _value.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as bool?,
      accepted: freezed == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      skip: null == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetEventsInputCopyWith<$Res>
    implements $GetEventsInputCopyWith<$Res> {
  factory _$$_GetEventsInputCopyWith(
          _$_GetEventsInput value, $Res Function(_$_GetEventsInput) then) =
      __$$_GetEventsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? search,
      @JsonKey(includeIfNull: false) bool? highlight,
      @JsonKey(includeIfNull: false) String? accepted,
      int limit,
      int skip});
}

/// @nodoc
class __$$_GetEventsInputCopyWithImpl<$Res>
    extends _$GetEventsInputCopyWithImpl<$Res, _$_GetEventsInput>
    implements _$$_GetEventsInputCopyWith<$Res> {
  __$$_GetEventsInputCopyWithImpl(
      _$_GetEventsInput _value, $Res Function(_$_GetEventsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? highlight = freezed,
    Object? accepted = freezed,
    Object? limit = null,
    Object? skip = null,
  }) {
    return _then(_$_GetEventsInput(
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      highlight: freezed == highlight
          ? _value.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as bool?,
      accepted: freezed == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      skip: null == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetEventsInput implements _GetEventsInput {
  const _$_GetEventsInput(
      {@JsonKey(includeIfNull: false) this.search,
      @JsonKey(includeIfNull: false) this.highlight,
      @JsonKey(includeIfNull: false) this.accepted,
      this.limit = 100,
      this.skip = 0});

  factory _$_GetEventsInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetEventsInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? search;
  @override
  @JsonKey(includeIfNull: false)
  final bool? highlight;
  @override
  @JsonKey(includeIfNull: false)
  final String? accepted;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int skip;

  @override
  String toString() {
    return 'GetEventsInput(search: $search, highlight: $highlight, accepted: $accepted, limit: $limit, skip: $skip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetEventsInput &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.skip, skip) || other.skip == skip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, search, highlight, accepted, limit, skip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetEventsInputCopyWith<_$_GetEventsInput> get copyWith =>
      __$$_GetEventsInputCopyWithImpl<_$_GetEventsInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetEventsInputToJson(
      this,
    );
  }
}

abstract class _GetEventsInput implements GetEventsInput {
  const factory _GetEventsInput(
      {@JsonKey(includeIfNull: false) final String? search,
      @JsonKey(includeIfNull: false) final bool? highlight,
      @JsonKey(includeIfNull: false) final String? accepted,
      final int limit,
      final int skip}) = _$_GetEventsInput;

  factory _GetEventsInput.fromJson(Map<String, dynamic> json) =
      _$_GetEventsInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get search;
  @override
  @JsonKey(includeIfNull: false)
  bool? get highlight;
  @override
  @JsonKey(includeIfNull: false)
  String? get accepted;
  @override
  int get limit;
  @override
  int get skip;
  @override
  @JsonKey(ignore: true)
  _$$_GetEventsInputCopyWith<_$_GetEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetHomeEventsInput _$GetHomeEventsInputFromJson(Map<String, dynamic> json) {
  return _GetHomeEventsInput.fromJson(json);
}

/// @nodoc
mixin _$GetHomeEventsInput {
  @JsonKey(includeIfNull: false)
  String? get query => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  EventTense get tense => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetHomeEventsInputCopyWith<GetHomeEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetHomeEventsInputCopyWith<$Res> {
  factory $GetHomeEventsInputCopyWith(
          GetHomeEventsInput value, $Res Function(GetHomeEventsInput) then) =
      _$GetHomeEventsInputCopyWithImpl<$Res, GetHomeEventsInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? query,
      int limit,
      double latitude,
      double longitude,
      EventTense tense});
}

/// @nodoc
class _$GetHomeEventsInputCopyWithImpl<$Res, $Val extends GetHomeEventsInput>
    implements $GetHomeEventsInputCopyWith<$Res> {
  _$GetHomeEventsInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? limit = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? tense = null,
  }) {
    return _then(_value.copyWith(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      tense: null == tense
          ? _value.tense
          : tense // ignore: cast_nullable_to_non_nullable
              as EventTense,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetHomeEventsInputCopyWith<$Res>
    implements $GetHomeEventsInputCopyWith<$Res> {
  factory _$$_GetHomeEventsInputCopyWith(_$_GetHomeEventsInput value,
          $Res Function(_$_GetHomeEventsInput) then) =
      __$$_GetHomeEventsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? query,
      int limit,
      double latitude,
      double longitude,
      EventTense tense});
}

/// @nodoc
class __$$_GetHomeEventsInputCopyWithImpl<$Res>
    extends _$GetHomeEventsInputCopyWithImpl<$Res, _$_GetHomeEventsInput>
    implements _$$_GetHomeEventsInputCopyWith<$Res> {
  __$$_GetHomeEventsInputCopyWithImpl(
      _$_GetHomeEventsInput _value, $Res Function(_$_GetHomeEventsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? limit = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? tense = null,
  }) {
    return _then(_$_GetHomeEventsInput(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      tense: null == tense
          ? _value.tense
          : tense // ignore: cast_nullable_to_non_nullable
              as EventTense,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetHomeEventsInput implements _GetHomeEventsInput {
  const _$_GetHomeEventsInput(
      {@JsonKey(includeIfNull: false) this.query,
      this.limit = 100,
      this.latitude = 0,
      this.longitude = 0,
      this.tense = EventTense.Future});

  factory _$_GetHomeEventsInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetHomeEventsInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? query;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final EventTense tense;

  @override
  String toString() {
    return 'GetHomeEventsInput(query: $query, limit: $limit, latitude: $latitude, longitude: $longitude, tense: $tense)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetHomeEventsInput &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.tense, tense) || other.tense == tense));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, query, limit, latitude, longitude, tense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetHomeEventsInputCopyWith<_$_GetHomeEventsInput> get copyWith =>
      __$$_GetHomeEventsInputCopyWithImpl<_$_GetHomeEventsInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetHomeEventsInputToJson(
      this,
    );
  }
}

abstract class _GetHomeEventsInput implements GetHomeEventsInput {
  const factory _GetHomeEventsInput(
      {@JsonKey(includeIfNull: false) final String? query,
      final int limit,
      final double latitude,
      final double longitude,
      final EventTense tense}) = _$_GetHomeEventsInput;

  factory _GetHomeEventsInput.fromJson(Map<String, dynamic> json) =
      _$_GetHomeEventsInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get query;
  @override
  int get limit;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  EventTense get tense;
  @override
  @JsonKey(ignore: true)
  _$$_GetHomeEventsInputCopyWith<_$_GetHomeEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetHostingEventsInput _$GetHostingEventsInputFromJson(
    Map<String, dynamic> json) {
  return _GetHostingEventsInput.fromJson(json);
}

/// @nodoc
mixin _$GetHostingEventsInput {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  FilterEventInput? get state => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  dynamic get skip => throw _privateConstructorUsedError;
  dynamic get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetHostingEventsInputCopyWith<GetHostingEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetHostingEventsInputCopyWith<$Res> {
  factory $GetHostingEventsInputCopyWith(GetHostingEventsInput value,
          $Res Function(GetHostingEventsInput) then) =
      _$GetHostingEventsInputCopyWithImpl<$Res, GetHostingEventsInput>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(includeIfNull: false) FilterEventInput? state,
      int limit,
      dynamic skip,
      dynamic order});

  $FilterEventInputCopyWith<$Res>? get state;
}

/// @nodoc
class _$GetHostingEventsInputCopyWithImpl<$Res,
        $Val extends GetHostingEventsInput>
    implements $GetHostingEventsInputCopyWith<$Res> {
  _$GetHostingEventsInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = freezed,
    Object? limit = null,
    Object? skip = freezed,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as FilterEventInput?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as dynamic,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FilterEventInputCopyWith<$Res>? get state {
    if (_value.state == null) {
      return null;
    }

    return $FilterEventInputCopyWith<$Res>(_value.state!, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GetHostingEventsInputCopyWith<$Res>
    implements $GetHostingEventsInputCopyWith<$Res> {
  factory _$$_GetHostingEventsInputCopyWith(_$_GetHostingEventsInput value,
          $Res Function(_$_GetHostingEventsInput) then) =
      __$$_GetHostingEventsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(includeIfNull: false) FilterEventInput? state,
      int limit,
      dynamic skip,
      dynamic order});

  @override
  $FilterEventInputCopyWith<$Res>? get state;
}

/// @nodoc
class __$$_GetHostingEventsInputCopyWithImpl<$Res>
    extends _$GetHostingEventsInputCopyWithImpl<$Res, _$_GetHostingEventsInput>
    implements _$$_GetHostingEventsInputCopyWith<$Res> {
  __$$_GetHostingEventsInputCopyWithImpl(_$_GetHostingEventsInput _value,
      $Res Function(_$_GetHostingEventsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = freezed,
    Object? limit = null,
    Object? skip = freezed,
    Object? order = freezed,
  }) {
    return _then(_$_GetHostingEventsInput(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as FilterEventInput?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      skip: freezed == skip ? _value.skip! : skip,
      order: freezed == order ? _value.order! : order,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetHostingEventsInput implements _GetHostingEventsInput {
  const _$_GetHostingEventsInput(
      {required this.id,
      @JsonKey(includeIfNull: false) this.state,
      this.limit = 100,
      this.skip = 0,
      this.order = -1});

  factory _$_GetHostingEventsInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetHostingEventsInputFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(includeIfNull: false)
  final FilterEventInput? state;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final dynamic skip;
  @override
  @JsonKey()
  final dynamic order;

  @override
  String toString() {
    return 'GetHostingEventsInput(id: $id, state: $state, limit: $limit, skip: $skip, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetHostingEventsInput &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            const DeepCollectionEquality().equals(other.skip, skip) &&
            const DeepCollectionEquality().equals(other.order, order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      state,
      limit,
      const DeepCollectionEquality().hash(skip),
      const DeepCollectionEquality().hash(order));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetHostingEventsInputCopyWith<_$_GetHostingEventsInput> get copyWith =>
      __$$_GetHostingEventsInputCopyWithImpl<_$_GetHostingEventsInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetHostingEventsInputToJson(
      this,
    );
  }
}

abstract class _GetHostingEventsInput implements GetHostingEventsInput {
  const factory _GetHostingEventsInput(
      {required final String id,
      @JsonKey(includeIfNull: false) final FilterEventInput? state,
      final int limit,
      final dynamic skip,
      final dynamic order}) = _$_GetHostingEventsInput;

  factory _GetHostingEventsInput.fromJson(Map<String, dynamic> json) =
      _$_GetHostingEventsInput.fromJson;

  @override
  String get id;
  @override
  @JsonKey(includeIfNull: false)
  FilterEventInput? get state;
  @override
  int get limit;
  @override
  dynamic get skip;
  @override
  dynamic get order;
  @override
  @JsonKey(ignore: true)
  _$$_GetHostingEventsInputCopyWith<_$_GetHostingEventsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

FilterEventInput _$FilterEventInputFromJson(Map<String, dynamic> json) {
  return _FilterEventInput.fromJson(json);
}

/// @nodoc
mixin _$FilterEventInput {
  @JsonKey(includeIfNull: false)
  EventState? get eq => throw _privateConstructorUsedError;
  @JsonKey(name: 'in', includeIfNull: false)
  List<EventState>? get include => throw _privateConstructorUsedError;
  @JsonKey(name: 'nin', includeIfNull: false)
  List<EventState>? get notInclude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterEventInputCopyWith<FilterEventInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterEventInputCopyWith<$Res> {
  factory $FilterEventInputCopyWith(
          FilterEventInput value, $Res Function(FilterEventInput) then) =
      _$FilterEventInputCopyWithImpl<$Res, FilterEventInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false)
          EventState? eq,
      @JsonKey(name: 'in', includeIfNull: false)
          List<EventState>? include,
      @JsonKey(name: 'nin', includeIfNull: false)
          List<EventState>? notInclude});
}

/// @nodoc
class _$FilterEventInputCopyWithImpl<$Res, $Val extends FilterEventInput>
    implements $FilterEventInputCopyWith<$Res> {
  _$FilterEventInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eq = freezed,
    Object? include = freezed,
    Object? notInclude = freezed,
  }) {
    return _then(_value.copyWith(
      eq: freezed == eq
          ? _value.eq
          : eq // ignore: cast_nullable_to_non_nullable
              as EventState?,
      include: freezed == include
          ? _value.include
          : include // ignore: cast_nullable_to_non_nullable
              as List<EventState>?,
      notInclude: freezed == notInclude
          ? _value.notInclude
          : notInclude // ignore: cast_nullable_to_non_nullable
              as List<EventState>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilterEventInputCopyWith<$Res>
    implements $FilterEventInputCopyWith<$Res> {
  factory _$$_FilterEventInputCopyWith(
          _$_FilterEventInput value, $Res Function(_$_FilterEventInput) then) =
      __$$_FilterEventInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false)
          EventState? eq,
      @JsonKey(name: 'in', includeIfNull: false)
          List<EventState>? include,
      @JsonKey(name: 'nin', includeIfNull: false)
          List<EventState>? notInclude});
}

/// @nodoc
class __$$_FilterEventInputCopyWithImpl<$Res>
    extends _$FilterEventInputCopyWithImpl<$Res, _$_FilterEventInput>
    implements _$$_FilterEventInputCopyWith<$Res> {
  __$$_FilterEventInputCopyWithImpl(
      _$_FilterEventInput _value, $Res Function(_$_FilterEventInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eq = freezed,
    Object? include = freezed,
    Object? notInclude = freezed,
  }) {
    return _then(_$_FilterEventInput(
      eq: freezed == eq
          ? _value.eq
          : eq // ignore: cast_nullable_to_non_nullable
              as EventState?,
      include: freezed == include
          ? _value._include
          : include // ignore: cast_nullable_to_non_nullable
              as List<EventState>?,
      notInclude: freezed == notInclude
          ? _value._notInclude
          : notInclude // ignore: cast_nullable_to_non_nullable
              as List<EventState>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FilterEventInput implements _FilterEventInput {
  const _$_FilterEventInput(
      {@JsonKey(includeIfNull: false)
          this.eq,
      @JsonKey(name: 'in', includeIfNull: false)
          final List<EventState>? include,
      @JsonKey(name: 'nin', includeIfNull: false)
          final List<EventState>? notInclude})
      : _include = include,
        _notInclude = notInclude;

  factory _$_FilterEventInput.fromJson(Map<String, dynamic> json) =>
      _$$_FilterEventInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final EventState? eq;
  final List<EventState>? _include;
  @override
  @JsonKey(name: 'in', includeIfNull: false)
  List<EventState>? get include {
    final value = _include;
    if (value == null) return null;
    if (_include is EqualUnmodifiableListView) return _include;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EventState>? _notInclude;
  @override
  @JsonKey(name: 'nin', includeIfNull: false)
  List<EventState>? get notInclude {
    final value = _notInclude;
    if (value == null) return null;
    if (_notInclude is EqualUnmodifiableListView) return _notInclude;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FilterEventInput(eq: $eq, include: $include, notInclude: $notInclude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilterEventInput &&
            (identical(other.eq, eq) || other.eq == eq) &&
            const DeepCollectionEquality().equals(other._include, _include) &&
            const DeepCollectionEquality()
                .equals(other._notInclude, _notInclude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eq,
      const DeepCollectionEquality().hash(_include),
      const DeepCollectionEquality().hash(_notInclude));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterEventInputCopyWith<_$_FilterEventInput> get copyWith =>
      __$$_FilterEventInputCopyWithImpl<_$_FilterEventInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterEventInputToJson(
      this,
    );
  }
}

abstract class _FilterEventInput implements FilterEventInput {
  const factory _FilterEventInput(
      {@JsonKey(includeIfNull: false)
          final EventState? eq,
      @JsonKey(name: 'in', includeIfNull: false)
          final List<EventState>? include,
      @JsonKey(name: 'nin', includeIfNull: false)
          final List<EventState>? notInclude}) = _$_FilterEventInput;

  factory _FilterEventInput.fromJson(Map<String, dynamic> json) =
      _$_FilterEventInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  EventState? get eq;
  @override
  @JsonKey(name: 'in', includeIfNull: false)
  List<EventState>? get include;
  @override
  @JsonKey(name: 'nin', includeIfNull: false)
  List<EventState>? get notInclude;
  @override
  @JsonKey(ignore: true)
  _$$_FilterEventInputCopyWith<_$_FilterEventInput> get copyWith =>
      throw _privateConstructorUsedError;
}
