// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch_orders_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderWhereComplex _$OrderWhereComplexFromJson(Map<String, dynamic> json) {
  return _OrderWhereComplex.fromJson(json);
}

/// @nodoc
mixin _$OrderWhereComplex {
  @JsonKey(name: 'maker_in', includeIfNull: false)
  List<String>? get makerIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_eq', includeIfNull: false)
  bool? get openEq => throw _privateConstructorUsedError;
  @JsonKey(name: 'taker_exists', includeIfNull: false)
  bool? get takerExists => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderWhereComplexCopyWith<OrderWhereComplex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderWhereComplexCopyWith<$Res> {
  factory $OrderWhereComplexCopyWith(
          OrderWhereComplex value, $Res Function(OrderWhereComplex) then) =
      _$OrderWhereComplexCopyWithImpl<$Res, OrderWhereComplex>;
  @useResult
  $Res call(
      {@JsonKey(name: 'maker_in', includeIfNull: false) List<String>? makerIn,
      @JsonKey(name: 'open_eq', includeIfNull: false) bool? openEq,
      @JsonKey(name: 'taker_exists', includeIfNull: false) bool? takerExists});
}

/// @nodoc
class _$OrderWhereComplexCopyWithImpl<$Res, $Val extends OrderWhereComplex>
    implements $OrderWhereComplexCopyWith<$Res> {
  _$OrderWhereComplexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? makerIn = freezed,
    Object? openEq = freezed,
    Object? takerExists = freezed,
  }) {
    return _then(_value.copyWith(
      makerIn: freezed == makerIn
          ? _value.makerIn
          : makerIn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      openEq: freezed == openEq
          ? _value.openEq
          : openEq // ignore: cast_nullable_to_non_nullable
              as bool?,
      takerExists: freezed == takerExists
          ? _value.takerExists
          : takerExists // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderWhereComplexCopyWith<$Res>
    implements $OrderWhereComplexCopyWith<$Res> {
  factory _$$_OrderWhereComplexCopyWith(_$_OrderWhereComplex value,
          $Res Function(_$_OrderWhereComplex) then) =
      __$$_OrderWhereComplexCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'maker_in', includeIfNull: false) List<String>? makerIn,
      @JsonKey(name: 'open_eq', includeIfNull: false) bool? openEq,
      @JsonKey(name: 'taker_exists', includeIfNull: false) bool? takerExists});
}

/// @nodoc
class __$$_OrderWhereComplexCopyWithImpl<$Res>
    extends _$OrderWhereComplexCopyWithImpl<$Res, _$_OrderWhereComplex>
    implements _$$_OrderWhereComplexCopyWith<$Res> {
  __$$_OrderWhereComplexCopyWithImpl(
      _$_OrderWhereComplex _value, $Res Function(_$_OrderWhereComplex) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? makerIn = freezed,
    Object? openEq = freezed,
    Object? takerExists = freezed,
  }) {
    return _then(_$_OrderWhereComplex(
      makerIn: freezed == makerIn
          ? _value._makerIn
          : makerIn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      openEq: freezed == openEq
          ? _value.openEq
          : openEq // ignore: cast_nullable_to_non_nullable
              as bool?,
      takerExists: freezed == takerExists
          ? _value.takerExists
          : takerExists // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderWhereComplex implements _OrderWhereComplex {
  const _$_OrderWhereComplex(
      {@JsonKey(name: 'maker_in', includeIfNull: false)
      final List<String>? makerIn,
      @JsonKey(name: 'open_eq', includeIfNull: false) this.openEq,
      @JsonKey(name: 'taker_exists', includeIfNull: false) this.takerExists})
      : _makerIn = makerIn;

  factory _$_OrderWhereComplex.fromJson(Map<String, dynamic> json) =>
      _$$_OrderWhereComplexFromJson(json);

  final List<String>? _makerIn;
  @override
  @JsonKey(name: 'maker_in', includeIfNull: false)
  List<String>? get makerIn {
    final value = _makerIn;
    if (value == null) return null;
    if (_makerIn is EqualUnmodifiableListView) return _makerIn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'open_eq', includeIfNull: false)
  final bool? openEq;
  @override
  @JsonKey(name: 'taker_exists', includeIfNull: false)
  final bool? takerExists;

  @override
  String toString() {
    return 'OrderWhereComplex(makerIn: $makerIn, openEq: $openEq, takerExists: $takerExists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderWhereComplex &&
            const DeepCollectionEquality().equals(other._makerIn, _makerIn) &&
            (identical(other.openEq, openEq) || other.openEq == openEq) &&
            (identical(other.takerExists, takerExists) ||
                other.takerExists == takerExists));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_makerIn), openEq, takerExists);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderWhereComplexCopyWith<_$_OrderWhereComplex> get copyWith =>
      __$$_OrderWhereComplexCopyWithImpl<_$_OrderWhereComplex>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderWhereComplexToJson(
      this,
    );
  }
}

abstract class _OrderWhereComplex implements OrderWhereComplex {
  const factory _OrderWhereComplex(
      {@JsonKey(name: 'maker_in', includeIfNull: false)
      final List<String>? makerIn,
      @JsonKey(name: 'open_eq', includeIfNull: false) final bool? openEq,
      @JsonKey(name: 'taker_exists', includeIfNull: false)
      final bool? takerExists}) = _$_OrderWhereComplex;

  factory _OrderWhereComplex.fromJson(Map<String, dynamic> json) =
      _$_OrderWhereComplex.fromJson;

  @override
  @JsonKey(name: 'maker_in', includeIfNull: false)
  List<String>? get makerIn;
  @override
  @JsonKey(name: 'open_eq', includeIfNull: false)
  bool? get openEq;
  @override
  @JsonKey(name: 'taker_exists', includeIfNull: false)
  bool? get takerExists;
  @override
  @JsonKey(ignore: true)
  _$$_OrderWhereComplexCopyWith<_$_OrderWhereComplex> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderSort _$OrderSortFromJson(Map<String, dynamic> json) {
  return _OrderSort.fromJson(json);
}

/// @nodoc
mixin _$OrderSort {
  @JsonKey(includeIfNull: false)
  OrderSortBy? get by => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  SortDirection? get direction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderSortCopyWith<OrderSort> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSortCopyWith<$Res> {
  factory $OrderSortCopyWith(OrderSort value, $Res Function(OrderSort) then) =
      _$OrderSortCopyWithImpl<$Res, OrderSort>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) OrderSortBy? by,
      @JsonKey(includeIfNull: false) SortDirection? direction});
}

/// @nodoc
class _$OrderSortCopyWithImpl<$Res, $Val extends OrderSort>
    implements $OrderSortCopyWith<$Res> {
  _$OrderSortCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? by = freezed,
    Object? direction = freezed,
  }) {
    return _then(_value.copyWith(
      by: freezed == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as OrderSortBy?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderSortCopyWith<$Res> implements $OrderSortCopyWith<$Res> {
  factory _$$_OrderSortCopyWith(
          _$_OrderSort value, $Res Function(_$_OrderSort) then) =
      __$$_OrderSortCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) OrderSortBy? by,
      @JsonKey(includeIfNull: false) SortDirection? direction});
}

/// @nodoc
class __$$_OrderSortCopyWithImpl<$Res>
    extends _$OrderSortCopyWithImpl<$Res, _$_OrderSort>
    implements _$$_OrderSortCopyWith<$Res> {
  __$$_OrderSortCopyWithImpl(
      _$_OrderSort _value, $Res Function(_$_OrderSort) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? by = freezed,
    Object? direction = freezed,
  }) {
    return _then(_$_OrderSort(
      by: freezed == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as OrderSortBy?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderSort implements _OrderSort {
  const _$_OrderSort(
      {@JsonKey(includeIfNull: false) this.by,
      @JsonKey(includeIfNull: false) this.direction});

  factory _$_OrderSort.fromJson(Map<String, dynamic> json) =>
      _$$_OrderSortFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final OrderSortBy? by;
  @override
  @JsonKey(includeIfNull: false)
  final SortDirection? direction;

  @override
  String toString() {
    return 'OrderSort(by: $by, direction: $direction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderSort &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, by, direction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderSortCopyWith<_$_OrderSort> get copyWith =>
      __$$_OrderSortCopyWithImpl<_$_OrderSort>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderSortToJson(
      this,
    );
  }
}

abstract class _OrderSort implements OrderSort {
  const factory _OrderSort(
          {@JsonKey(includeIfNull: false) final OrderSortBy? by,
          @JsonKey(includeIfNull: false) final SortDirection? direction}) =
      _$_OrderSort;

  factory _OrderSort.fromJson(Map<String, dynamic> json) =
      _$_OrderSort.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  OrderSortBy? get by;
  @override
  @JsonKey(includeIfNull: false)
  SortDirection? get direction;
  @override
  @JsonKey(ignore: true)
  _$$_OrderSortCopyWith<_$_OrderSort> get copyWith =>
      throw _privateConstructorUsedError;
}

WatchOrdersInput _$WatchOrdersInputFromJson(Map<String, dynamic> json) {
  return _WatchOrdersInput.fromJson(json);
}

/// @nodoc
mixin _$WatchOrdersInput {
  @JsonKey(includeIfNull: false)
  OrderWhereComplex? get where => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  OrderSort? get sort => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  bool? get query => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get skip => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get limit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WatchOrdersInputCopyWith<WatchOrdersInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchOrdersInputCopyWith<$Res> {
  factory $WatchOrdersInputCopyWith(
          WatchOrdersInput value, $Res Function(WatchOrdersInput) then) =
      _$WatchOrdersInputCopyWithImpl<$Res, WatchOrdersInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) OrderWhereComplex? where,
      @JsonKey(includeIfNull: false) OrderSort? sort,
      @JsonKey(includeIfNull: false) bool? query,
      @JsonKey(includeIfNull: false) int? skip,
      @JsonKey(includeIfNull: false) int? limit});

  $OrderWhereComplexCopyWith<$Res>? get where;
  $OrderSortCopyWith<$Res>? get sort;
}

/// @nodoc
class _$WatchOrdersInputCopyWithImpl<$Res, $Val extends WatchOrdersInput>
    implements $WatchOrdersInputCopyWith<$Res> {
  _$WatchOrdersInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? where = freezed,
    Object? sort = freezed,
    Object? query = freezed,
    Object? skip = freezed,
    Object? limit = freezed,
  }) {
    return _then(_value.copyWith(
      where: freezed == where
          ? _value.where
          : where // ignore: cast_nullable_to_non_nullable
              as OrderWhereComplex?,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as OrderSort?,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as bool?,
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderWhereComplexCopyWith<$Res>? get where {
    if (_value.where == null) {
      return null;
    }

    return $OrderWhereComplexCopyWith<$Res>(_value.where!, (value) {
      return _then(_value.copyWith(where: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderSortCopyWith<$Res>? get sort {
    if (_value.sort == null) {
      return null;
    }

    return $OrderSortCopyWith<$Res>(_value.sort!, (value) {
      return _then(_value.copyWith(sort: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WatchOrdersInputCopyWith<$Res>
    implements $WatchOrdersInputCopyWith<$Res> {
  factory _$$_WatchOrdersInputCopyWith(
          _$_WatchOrdersInput value, $Res Function(_$_WatchOrdersInput) then) =
      __$$_WatchOrdersInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) OrderWhereComplex? where,
      @JsonKey(includeIfNull: false) OrderSort? sort,
      @JsonKey(includeIfNull: false) bool? query,
      @JsonKey(includeIfNull: false) int? skip,
      @JsonKey(includeIfNull: false) int? limit});

  @override
  $OrderWhereComplexCopyWith<$Res>? get where;
  @override
  $OrderSortCopyWith<$Res>? get sort;
}

/// @nodoc
class __$$_WatchOrdersInputCopyWithImpl<$Res>
    extends _$WatchOrdersInputCopyWithImpl<$Res, _$_WatchOrdersInput>
    implements _$$_WatchOrdersInputCopyWith<$Res> {
  __$$_WatchOrdersInputCopyWithImpl(
      _$_WatchOrdersInput _value, $Res Function(_$_WatchOrdersInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? where = freezed,
    Object? sort = freezed,
    Object? query = freezed,
    Object? skip = freezed,
    Object? limit = freezed,
  }) {
    return _then(_$_WatchOrdersInput(
      where: freezed == where
          ? _value.where
          : where // ignore: cast_nullable_to_non_nullable
              as OrderWhereComplex?,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as OrderSort?,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as bool?,
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_WatchOrdersInput implements _WatchOrdersInput {
  const _$_WatchOrdersInput(
      {@JsonKey(includeIfNull: false) this.where,
      @JsonKey(includeIfNull: false) this.sort,
      @JsonKey(includeIfNull: false) this.query,
      @JsonKey(includeIfNull: false) this.skip,
      @JsonKey(includeIfNull: false) this.limit});

  factory _$_WatchOrdersInput.fromJson(Map<String, dynamic> json) =>
      _$$_WatchOrdersInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final OrderWhereComplex? where;
  @override
  @JsonKey(includeIfNull: false)
  final OrderSort? sort;
  @override
  @JsonKey(includeIfNull: false)
  final bool? query;
  @override
  @JsonKey(includeIfNull: false)
  final int? skip;
  @override
  @JsonKey(includeIfNull: false)
  final int? limit;

  @override
  String toString() {
    return 'WatchOrdersInput(where: $where, sort: $sort, query: $query, skip: $skip, limit: $limit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WatchOrdersInput &&
            (identical(other.where, where) || other.where == where) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, where, sort, query, skip, limit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WatchOrdersInputCopyWith<_$_WatchOrdersInput> get copyWith =>
      __$$_WatchOrdersInputCopyWithImpl<_$_WatchOrdersInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WatchOrdersInputToJson(
      this,
    );
  }
}

abstract class _WatchOrdersInput implements WatchOrdersInput {
  const factory _WatchOrdersInput(
      {@JsonKey(includeIfNull: false) final OrderWhereComplex? where,
      @JsonKey(includeIfNull: false) final OrderSort? sort,
      @JsonKey(includeIfNull: false) final bool? query,
      @JsonKey(includeIfNull: false) final int? skip,
      @JsonKey(includeIfNull: false) final int? limit}) = _$_WatchOrdersInput;

  factory _WatchOrdersInput.fromJson(Map<String, dynamic> json) =
      _$_WatchOrdersInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  OrderWhereComplex? get where;
  @override
  @JsonKey(includeIfNull: false)
  OrderSort? get sort;
  @override
  @JsonKey(includeIfNull: false)
  bool? get query;
  @override
  @JsonKey(includeIfNull: false)
  int? get skip;
  @override
  @JsonKey(includeIfNull: false)
  int? get limit;
  @override
  @JsonKey(ignore: true)
  _$$_WatchOrdersInputCopyWith<_$_WatchOrdersInput> get copyWith =>
      throw _privateConstructorUsedError;
}
