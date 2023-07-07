// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_listing_subscription_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrdersListingSubscriptionEvent {
  WatchOrdersInput? get input => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WatchOrdersInput? input) start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WatchOrdersInput? input)? start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WatchOrdersInput? input)? start,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionEventStart value) start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionEventStart value)? start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionEventStart value)? start,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersListingSubscriptionEventCopyWith<OrdersListingSubscriptionEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersListingSubscriptionEventCopyWith<$Res> {
  factory $OrdersListingSubscriptionEventCopyWith(
          OrdersListingSubscriptionEvent value,
          $Res Function(OrdersListingSubscriptionEvent) then) =
      _$OrdersListingSubscriptionEventCopyWithImpl<$Res,
          OrdersListingSubscriptionEvent>;
  @useResult
  $Res call({WatchOrdersInput? input});

  $WatchOrdersInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$OrdersListingSubscriptionEventCopyWithImpl<$Res,
        $Val extends OrdersListingSubscriptionEvent>
    implements $OrdersListingSubscriptionEventCopyWith<$Res> {
  _$OrdersListingSubscriptionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_value.copyWith(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as WatchOrdersInput?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WatchOrdersInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $WatchOrdersInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrdersListingSubscriptionEventStartCopyWith<$Res>
    implements $OrdersListingSubscriptionEventCopyWith<$Res> {
  factory _$$OrdersListingSubscriptionEventStartCopyWith(
          _$OrdersListingSubscriptionEventStart value,
          $Res Function(_$OrdersListingSubscriptionEventStart) then) =
      __$$OrdersListingSubscriptionEventStartCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WatchOrdersInput? input});

  @override
  $WatchOrdersInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$OrdersListingSubscriptionEventStartCopyWithImpl<$Res>
    extends _$OrdersListingSubscriptionEventCopyWithImpl<$Res,
        _$OrdersListingSubscriptionEventStart>
    implements _$$OrdersListingSubscriptionEventStartCopyWith<$Res> {
  __$$OrdersListingSubscriptionEventStartCopyWithImpl(
      _$OrdersListingSubscriptionEventStart _value,
      $Res Function(_$OrdersListingSubscriptionEventStart) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$OrdersListingSubscriptionEventStart(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as WatchOrdersInput?,
    ));
  }
}

/// @nodoc

class _$OrdersListingSubscriptionEventStart
    implements OrdersListingSubscriptionEventStart {
  const _$OrdersListingSubscriptionEventStart({this.input});

  @override
  final WatchOrdersInput? input;

  @override
  String toString() {
    return 'OrdersListingSubscriptionEvent.start(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListingSubscriptionEventStart &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersListingSubscriptionEventStartCopyWith<
          _$OrdersListingSubscriptionEventStart>
      get copyWith => __$$OrdersListingSubscriptionEventStartCopyWithImpl<
          _$OrdersListingSubscriptionEventStart>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WatchOrdersInput? input) start,
  }) {
    return start(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WatchOrdersInput? input)? start,
  }) {
    return start?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WatchOrdersInput? input)? start,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionEventStart value) start,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionEventStart value)? start,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionEventStart value)? start,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }
}

abstract class OrdersListingSubscriptionEventStart
    implements OrdersListingSubscriptionEvent {
  const factory OrdersListingSubscriptionEventStart(
      {final WatchOrdersInput? input}) = _$OrdersListingSubscriptionEventStart;

  @override
  WatchOrdersInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$OrdersListingSubscriptionEventStartCopyWith<
          _$OrdersListingSubscriptionEventStart>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrdersListingSubscriptionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderComplex> orders) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderComplex> orders)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderComplex> orders)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionStateLoading value)
        loading,
    required TResult Function(OrdersListingSubscriptionStateFetched value)
        fetched,
    required TResult Function(OrdersListingSubscriptionStateFailure value)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult? Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult? Function(OrdersListingSubscriptionStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult Function(OrdersListingSubscriptionStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersListingSubscriptionStateCopyWith<$Res> {
  factory $OrdersListingSubscriptionStateCopyWith(
          OrdersListingSubscriptionState value,
          $Res Function(OrdersListingSubscriptionState) then) =
      _$OrdersListingSubscriptionStateCopyWithImpl<$Res,
          OrdersListingSubscriptionState>;
}

/// @nodoc
class _$OrdersListingSubscriptionStateCopyWithImpl<$Res,
        $Val extends OrdersListingSubscriptionState>
    implements $OrdersListingSubscriptionStateCopyWith<$Res> {
  _$OrdersListingSubscriptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OrdersListingSubscriptionStateLoadingCopyWith<$Res> {
  factory _$$OrdersListingSubscriptionStateLoadingCopyWith(
          _$OrdersListingSubscriptionStateLoading value,
          $Res Function(_$OrdersListingSubscriptionStateLoading) then) =
      __$$OrdersListingSubscriptionStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrdersListingSubscriptionStateLoadingCopyWithImpl<$Res>
    extends _$OrdersListingSubscriptionStateCopyWithImpl<$Res,
        _$OrdersListingSubscriptionStateLoading>
    implements _$$OrdersListingSubscriptionStateLoadingCopyWith<$Res> {
  __$$OrdersListingSubscriptionStateLoadingCopyWithImpl(
      _$OrdersListingSubscriptionStateLoading _value,
      $Res Function(_$OrdersListingSubscriptionStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OrdersListingSubscriptionStateLoading
    implements OrdersListingSubscriptionStateLoading {
  const _$OrdersListingSubscriptionStateLoading();

  @override
  String toString() {
    return 'OrdersListingSubscriptionState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListingSubscriptionStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderComplex> orders) fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderComplex> orders)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderComplex> orders)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionStateLoading value)
        loading,
    required TResult Function(OrdersListingSubscriptionStateFetched value)
        fetched,
    required TResult Function(OrdersListingSubscriptionStateFailure value)
        failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult? Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult? Function(OrdersListingSubscriptionStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult Function(OrdersListingSubscriptionStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrdersListingSubscriptionStateLoading
    implements OrdersListingSubscriptionState {
  const factory OrdersListingSubscriptionStateLoading() =
      _$OrdersListingSubscriptionStateLoading;
}

/// @nodoc
abstract class _$$OrdersListingSubscriptionStateFetchedCopyWith<$Res> {
  factory _$$OrdersListingSubscriptionStateFetchedCopyWith(
          _$OrdersListingSubscriptionStateFetched value,
          $Res Function(_$OrdersListingSubscriptionStateFetched) then) =
      __$$OrdersListingSubscriptionStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderComplex> orders});
}

/// @nodoc
class __$$OrdersListingSubscriptionStateFetchedCopyWithImpl<$Res>
    extends _$OrdersListingSubscriptionStateCopyWithImpl<$Res,
        _$OrdersListingSubscriptionStateFetched>
    implements _$$OrdersListingSubscriptionStateFetchedCopyWith<$Res> {
  __$$OrdersListingSubscriptionStateFetchedCopyWithImpl(
      _$OrdersListingSubscriptionStateFetched _value,
      $Res Function(_$OrdersListingSubscriptionStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$OrdersListingSubscriptionStateFetched(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderComplex>,
    ));
  }
}

/// @nodoc

class _$OrdersListingSubscriptionStateFetched
    implements OrdersListingSubscriptionStateFetched {
  const _$OrdersListingSubscriptionStateFetched(
      {required final List<OrderComplex> orders})
      : _orders = orders;

  final List<OrderComplex> _orders;
  @override
  List<OrderComplex> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OrdersListingSubscriptionState.fetched(orders: $orders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListingSubscriptionStateFetched &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersListingSubscriptionStateFetchedCopyWith<
          _$OrdersListingSubscriptionStateFetched>
      get copyWith => __$$OrdersListingSubscriptionStateFetchedCopyWithImpl<
          _$OrdersListingSubscriptionStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderComplex> orders) fetched,
    required TResult Function() failure,
  }) {
    return fetched(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderComplex> orders)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderComplex> orders)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionStateLoading value)
        loading,
    required TResult Function(OrdersListingSubscriptionStateFetched value)
        fetched,
    required TResult Function(OrdersListingSubscriptionStateFailure value)
        failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult? Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult? Function(OrdersListingSubscriptionStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult Function(OrdersListingSubscriptionStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class OrdersListingSubscriptionStateFetched
    implements OrdersListingSubscriptionState {
  const factory OrdersListingSubscriptionStateFetched(
          {required final List<OrderComplex> orders}) =
      _$OrdersListingSubscriptionStateFetched;

  List<OrderComplex> get orders;
  @JsonKey(ignore: true)
  _$$OrdersListingSubscriptionStateFetchedCopyWith<
          _$OrdersListingSubscriptionStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrdersListingSubscriptionStateFailureCopyWith<$Res> {
  factory _$$OrdersListingSubscriptionStateFailureCopyWith(
          _$OrdersListingSubscriptionStateFailure value,
          $Res Function(_$OrdersListingSubscriptionStateFailure) then) =
      __$$OrdersListingSubscriptionStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrdersListingSubscriptionStateFailureCopyWithImpl<$Res>
    extends _$OrdersListingSubscriptionStateCopyWithImpl<$Res,
        _$OrdersListingSubscriptionStateFailure>
    implements _$$OrdersListingSubscriptionStateFailureCopyWith<$Res> {
  __$$OrdersListingSubscriptionStateFailureCopyWithImpl(
      _$OrdersListingSubscriptionStateFailure _value,
      $Res Function(_$OrdersListingSubscriptionStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OrdersListingSubscriptionStateFailure
    implements OrdersListingSubscriptionStateFailure {
  const _$OrdersListingSubscriptionStateFailure();

  @override
  String toString() {
    return 'OrdersListingSubscriptionState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListingSubscriptionStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderComplex> orders) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderComplex> orders)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderComplex> orders)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrdersListingSubscriptionStateLoading value)
        loading,
    required TResult Function(OrdersListingSubscriptionStateFetched value)
        fetched,
    required TResult Function(OrdersListingSubscriptionStateFailure value)
        failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult? Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult? Function(OrdersListingSubscriptionStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrdersListingSubscriptionStateLoading value)? loading,
    TResult Function(OrdersListingSubscriptionStateFetched value)? fetched,
    TResult Function(OrdersListingSubscriptionStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class OrdersListingSubscriptionStateFailure
    implements OrdersListingSubscriptionState {
  const factory OrdersListingSubscriptionStateFailure() =
      _$OrdersListingSubscriptionStateFailure;
}
