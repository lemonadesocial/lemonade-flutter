// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TokensListingEvent {
  GetTokensInput? get input => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetTokensInput? input) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetTokensInput? input)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetTokensInput? input)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokensListingEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokensListingEventCopyWith<TokensListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensListingEventCopyWith<$Res> {
  factory $TokensListingEventCopyWith(
          TokensListingEvent value, $Res Function(TokensListingEvent) then) =
      _$TokensListingEventCopyWithImpl<$Res, TokensListingEvent>;
  @useResult
  $Res call({GetTokensInput? input});

  $GetTokensInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$TokensListingEventCopyWithImpl<$Res, $Val extends TokensListingEvent>
    implements $TokensListingEventCopyWith<$Res> {
  _$TokensListingEventCopyWithImpl(this._value, this._then);

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
              as GetTokensInput?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetTokensInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $GetTokensInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokensListingEventFetchCopyWith<$Res>
    implements $TokensListingEventCopyWith<$Res> {
  factory _$$TokensListingEventFetchCopyWith(_$TokensListingEventFetch value,
          $Res Function(_$TokensListingEventFetch) then) =
      __$$TokensListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetTokensInput? input});

  @override
  $GetTokensInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$TokensListingEventFetchCopyWithImpl<$Res>
    extends _$TokensListingEventCopyWithImpl<$Res, _$TokensListingEventFetch>
    implements _$$TokensListingEventFetchCopyWith<$Res> {
  __$$TokensListingEventFetchCopyWithImpl(_$TokensListingEventFetch _value,
      $Res Function(_$TokensListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$TokensListingEventFetch(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetTokensInput?,
    ));
  }
}

/// @nodoc

class _$TokensListingEventFetch implements TokensListingEventFetch {
  const _$TokensListingEventFetch({this.input});

  @override
  final GetTokensInput? input;

  @override
  String toString() {
    return 'TokensListingEvent.fetch(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensListingEventFetch &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensListingEventFetchCopyWith<_$TokensListingEventFetch> get copyWith =>
      __$$TokensListingEventFetchCopyWithImpl<_$TokensListingEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetTokensInput? input) fetch,
  }) {
    return fetch(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetTokensInput? input)? fetch,
  }) {
    return fetch?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetTokensInput? input)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokensListingEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class TokensListingEventFetch implements TokensListingEvent {
  const factory TokensListingEventFetch({final GetTokensInput? input}) =
      _$TokensListingEventFetch;

  @override
  GetTokensInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$TokensListingEventFetchCopyWith<_$TokensListingEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TokensListingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TokenComplex> tokens) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TokenComplex> tokens)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TokenComplex> tokens)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokensListingStateLoading value) loading,
    required TResult Function(TokensListingStateFetched value) fetched,
    required TResult Function(TokensListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingStateLoading value)? loading,
    TResult? Function(TokensListingStateFetched value)? fetched,
    TResult? Function(TokensListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingStateLoading value)? loading,
    TResult Function(TokensListingStateFetched value)? fetched,
    TResult Function(TokensListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensListingStateCopyWith<$Res> {
  factory $TokensListingStateCopyWith(
          TokensListingState value, $Res Function(TokensListingState) then) =
      _$TokensListingStateCopyWithImpl<$Res, TokensListingState>;
}

/// @nodoc
class _$TokensListingStateCopyWithImpl<$Res, $Val extends TokensListingState>
    implements $TokensListingStateCopyWith<$Res> {
  _$TokensListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TokensListingStateLoadingCopyWith<$Res> {
  factory _$$TokensListingStateLoadingCopyWith(
          _$TokensListingStateLoading value,
          $Res Function(_$TokensListingStateLoading) then) =
      __$$TokensListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TokensListingStateLoadingCopyWithImpl<$Res>
    extends _$TokensListingStateCopyWithImpl<$Res, _$TokensListingStateLoading>
    implements _$$TokensListingStateLoadingCopyWith<$Res> {
  __$$TokensListingStateLoadingCopyWithImpl(_$TokensListingStateLoading _value,
      $Res Function(_$TokensListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TokensListingStateLoading implements TokensListingStateLoading {
  const _$TokensListingStateLoading();

  @override
  String toString() {
    return 'TokensListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensListingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TokenComplex> tokens) fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TokenComplex> tokens)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TokenComplex> tokens)? fetched,
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
    required TResult Function(TokensListingStateLoading value) loading,
    required TResult Function(TokensListingStateFetched value) fetched,
    required TResult Function(TokensListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingStateLoading value)? loading,
    TResult? Function(TokensListingStateFetched value)? fetched,
    TResult? Function(TokensListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingStateLoading value)? loading,
    TResult Function(TokensListingStateFetched value)? fetched,
    TResult Function(TokensListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TokensListingStateLoading implements TokensListingState {
  const factory TokensListingStateLoading() = _$TokensListingStateLoading;
}

/// @nodoc
abstract class _$$TokensListingStateFetchedCopyWith<$Res> {
  factory _$$TokensListingStateFetchedCopyWith(
          _$TokensListingStateFetched value,
          $Res Function(_$TokensListingStateFetched) then) =
      __$$TokensListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TokenComplex> tokens});
}

/// @nodoc
class __$$TokensListingStateFetchedCopyWithImpl<$Res>
    extends _$TokensListingStateCopyWithImpl<$Res, _$TokensListingStateFetched>
    implements _$$TokensListingStateFetchedCopyWith<$Res> {
  __$$TokensListingStateFetchedCopyWithImpl(_$TokensListingStateFetched _value,
      $Res Function(_$TokensListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
  }) {
    return _then(_$TokensListingStateFetched(
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenComplex>,
    ));
  }
}

/// @nodoc

class _$TokensListingStateFetched implements TokensListingStateFetched {
  const _$TokensListingStateFetched({required final List<TokenComplex> tokens})
      : _tokens = tokens;

  final List<TokenComplex> _tokens;
  @override
  List<TokenComplex> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString() {
    return 'TokensListingState.fetched(tokens: $tokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensListingStateFetched &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensListingStateFetchedCopyWith<_$TokensListingStateFetched>
      get copyWith => __$$TokensListingStateFetchedCopyWithImpl<
          _$TokensListingStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TokenComplex> tokens) fetched,
    required TResult Function() failure,
  }) {
    return fetched(tokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TokenComplex> tokens)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(tokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TokenComplex> tokens)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(tokens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokensListingStateLoading value) loading,
    required TResult Function(TokensListingStateFetched value) fetched,
    required TResult Function(TokensListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingStateLoading value)? loading,
    TResult? Function(TokensListingStateFetched value)? fetched,
    TResult? Function(TokensListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingStateLoading value)? loading,
    TResult Function(TokensListingStateFetched value)? fetched,
    TResult Function(TokensListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class TokensListingStateFetched implements TokensListingState {
  const factory TokensListingStateFetched(
      {required final List<TokenComplex> tokens}) = _$TokensListingStateFetched;

  List<TokenComplex> get tokens;
  @JsonKey(ignore: true)
  _$$TokensListingStateFetchedCopyWith<_$TokensListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TokensListingStateFailureCopyWith<$Res> {
  factory _$$TokensListingStateFailureCopyWith(
          _$TokensListingStateFailure value,
          $Res Function(_$TokensListingStateFailure) then) =
      __$$TokensListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TokensListingStateFailureCopyWithImpl<$Res>
    extends _$TokensListingStateCopyWithImpl<$Res, _$TokensListingStateFailure>
    implements _$$TokensListingStateFailureCopyWith<$Res> {
  __$$TokensListingStateFailureCopyWithImpl(_$TokensListingStateFailure _value,
      $Res Function(_$TokensListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TokensListingStateFailure implements TokensListingStateFailure {
  const _$TokensListingStateFailure();

  @override
  String toString() {
    return 'TokensListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensListingStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TokenComplex> tokens) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TokenComplex> tokens)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TokenComplex> tokens)? fetched,
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
    required TResult Function(TokensListingStateLoading value) loading,
    required TResult Function(TokensListingStateFetched value) fetched,
    required TResult Function(TokensListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokensListingStateLoading value)? loading,
    TResult? Function(TokensListingStateFetched value)? fetched,
    TResult? Function(TokensListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokensListingStateLoading value)? loading,
    TResult Function(TokensListingStateFetched value)? fetched,
    TResult Function(TokensListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class TokensListingStateFailure implements TokensListingState {
  const factory TokensListingStateFailure() = _$TokensListingStateFailure;
}
