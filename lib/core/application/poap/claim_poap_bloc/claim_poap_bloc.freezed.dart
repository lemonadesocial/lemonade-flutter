// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_poap_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClaimPoapEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool fromServer) checkHasClaimed,
    required TResult Function(ClaimInput input) claim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool fromServer)? checkHasClaimed,
    TResult? Function(ClaimInput input)? claim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool fromServer)? checkHasClaimed,
    TResult Function(ClaimInput input)? claim,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClaimPoapEventCheckHasClaimed value)
        checkHasClaimed,
    required TResult Function(ClaimPoapEventClaim value) claim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult? Function(ClaimPoapEventClaim value)? claim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult Function(ClaimPoapEventClaim value)? claim,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimPoapEventCopyWith<$Res> {
  factory $ClaimPoapEventCopyWith(
          ClaimPoapEvent value, $Res Function(ClaimPoapEvent) then) =
      _$ClaimPoapEventCopyWithImpl<$Res, ClaimPoapEvent>;
}

/// @nodoc
class _$ClaimPoapEventCopyWithImpl<$Res, $Val extends ClaimPoapEvent>
    implements $ClaimPoapEventCopyWith<$Res> {
  _$ClaimPoapEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ClaimPoapEventCheckHasClaimedCopyWith<$Res> {
  factory _$$ClaimPoapEventCheckHasClaimedCopyWith(
          _$ClaimPoapEventCheckHasClaimed value,
          $Res Function(_$ClaimPoapEventCheckHasClaimed) then) =
      __$$ClaimPoapEventCheckHasClaimedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool fromServer});
}

/// @nodoc
class __$$ClaimPoapEventCheckHasClaimedCopyWithImpl<$Res>
    extends _$ClaimPoapEventCopyWithImpl<$Res, _$ClaimPoapEventCheckHasClaimed>
    implements _$$ClaimPoapEventCheckHasClaimedCopyWith<$Res> {
  __$$ClaimPoapEventCheckHasClaimedCopyWithImpl(
      _$ClaimPoapEventCheckHasClaimed _value,
      $Res Function(_$ClaimPoapEventCheckHasClaimed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromServer = null,
  }) {
    return _then(_$ClaimPoapEventCheckHasClaimed(
      fromServer: null == fromServer
          ? _value.fromServer
          : fromServer // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ClaimPoapEventCheckHasClaimed implements ClaimPoapEventCheckHasClaimed {
  const _$ClaimPoapEventCheckHasClaimed({this.fromServer = false});

  @override
  @JsonKey()
  final bool fromServer;

  @override
  String toString() {
    return 'ClaimPoapEvent.checkHasClaimed(fromServer: $fromServer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimPoapEventCheckHasClaimed &&
            (identical(other.fromServer, fromServer) ||
                other.fromServer == fromServer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromServer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimPoapEventCheckHasClaimedCopyWith<_$ClaimPoapEventCheckHasClaimed>
      get copyWith => __$$ClaimPoapEventCheckHasClaimedCopyWithImpl<
          _$ClaimPoapEventCheckHasClaimed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool fromServer) checkHasClaimed,
    required TResult Function(ClaimInput input) claim,
  }) {
    return checkHasClaimed(fromServer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool fromServer)? checkHasClaimed,
    TResult? Function(ClaimInput input)? claim,
  }) {
    return checkHasClaimed?.call(fromServer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool fromServer)? checkHasClaimed,
    TResult Function(ClaimInput input)? claim,
    required TResult orElse(),
  }) {
    if (checkHasClaimed != null) {
      return checkHasClaimed(fromServer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClaimPoapEventCheckHasClaimed value)
        checkHasClaimed,
    required TResult Function(ClaimPoapEventClaim value) claim,
  }) {
    return checkHasClaimed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult? Function(ClaimPoapEventClaim value)? claim,
  }) {
    return checkHasClaimed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult Function(ClaimPoapEventClaim value)? claim,
    required TResult orElse(),
  }) {
    if (checkHasClaimed != null) {
      return checkHasClaimed(this);
    }
    return orElse();
  }
}

abstract class ClaimPoapEventCheckHasClaimed implements ClaimPoapEvent {
  const factory ClaimPoapEventCheckHasClaimed({final bool fromServer}) =
      _$ClaimPoapEventCheckHasClaimed;

  bool get fromServer;
  @JsonKey(ignore: true)
  _$$ClaimPoapEventCheckHasClaimedCopyWith<_$ClaimPoapEventCheckHasClaimed>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClaimPoapEventClaimCopyWith<$Res> {
  factory _$$ClaimPoapEventClaimCopyWith(_$ClaimPoapEventClaim value,
          $Res Function(_$ClaimPoapEventClaim) then) =
      __$$ClaimPoapEventClaimCopyWithImpl<$Res>;
  @useResult
  $Res call({ClaimInput input});

  $ClaimInputCopyWith<$Res> get input;
}

/// @nodoc
class __$$ClaimPoapEventClaimCopyWithImpl<$Res>
    extends _$ClaimPoapEventCopyWithImpl<$Res, _$ClaimPoapEventClaim>
    implements _$$ClaimPoapEventClaimCopyWith<$Res> {
  __$$ClaimPoapEventClaimCopyWithImpl(
      _$ClaimPoapEventClaim _value, $Res Function(_$ClaimPoapEventClaim) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = null,
  }) {
    return _then(_$ClaimPoapEventClaim(
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as ClaimInput,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ClaimInputCopyWith<$Res> get input {
    return $ClaimInputCopyWith<$Res>(_value.input, (value) {
      return _then(_value.copyWith(input: value));
    });
  }
}

/// @nodoc

class _$ClaimPoapEventClaim implements ClaimPoapEventClaim {
  const _$ClaimPoapEventClaim({required this.input});

  @override
  final ClaimInput input;

  @override
  String toString() {
    return 'ClaimPoapEvent.claim(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimPoapEventClaim &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimPoapEventClaimCopyWith<_$ClaimPoapEventClaim> get copyWith =>
      __$$ClaimPoapEventClaimCopyWithImpl<_$ClaimPoapEventClaim>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool fromServer) checkHasClaimed,
    required TResult Function(ClaimInput input) claim,
  }) {
    return claim(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool fromServer)? checkHasClaimed,
    TResult? Function(ClaimInput input)? claim,
  }) {
    return claim?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool fromServer)? checkHasClaimed,
    TResult Function(ClaimInput input)? claim,
    required TResult orElse(),
  }) {
    if (claim != null) {
      return claim(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClaimPoapEventCheckHasClaimed value)
        checkHasClaimed,
    required TResult Function(ClaimPoapEventClaim value) claim,
  }) {
    return claim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult? Function(ClaimPoapEventClaim value)? claim,
  }) {
    return claim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClaimPoapEventCheckHasClaimed value)? checkHasClaimed,
    TResult Function(ClaimPoapEventClaim value)? claim,
    required TResult orElse(),
  }) {
    if (claim != null) {
      return claim(this);
    }
    return orElse();
  }
}

abstract class ClaimPoapEventClaim implements ClaimPoapEvent {
  const factory ClaimPoapEventClaim({required final ClaimInput input}) =
      _$ClaimPoapEventClaim;

  ClaimInput get input;
  @JsonKey(ignore: true)
  _$$ClaimPoapEventClaimCopyWith<_$ClaimPoapEventClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClaimPoapState {
  bool get claimed => throw _privateConstructorUsedError;
  bool get claiming => throw _privateConstructorUsedError;
  Claim? get claim => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClaimPoapStateCopyWith<ClaimPoapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimPoapStateCopyWith<$Res> {
  factory $ClaimPoapStateCopyWith(
          ClaimPoapState value, $Res Function(ClaimPoapState) then) =
      _$ClaimPoapStateCopyWithImpl<$Res, ClaimPoapState>;
  @useResult
  $Res call({bool claimed, bool claiming, Claim? claim, Failure? failure});
}

/// @nodoc
class _$ClaimPoapStateCopyWithImpl<$Res, $Val extends ClaimPoapState>
    implements $ClaimPoapStateCopyWith<$Res> {
  _$ClaimPoapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimed = null,
    Object? claiming = null,
    Object? claim = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      claimed: null == claimed
          ? _value.claimed
          : claimed // ignore: cast_nullable_to_non_nullable
              as bool,
      claiming: null == claiming
          ? _value.claiming
          : claiming // ignore: cast_nullable_to_non_nullable
              as bool,
      claim: freezed == claim
          ? _value.claim
          : claim // ignore: cast_nullable_to_non_nullable
              as Claim?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClaimPoapStateCopyWith<$Res>
    implements $ClaimPoapStateCopyWith<$Res> {
  factory _$$_ClaimPoapStateCopyWith(
          _$_ClaimPoapState value, $Res Function(_$_ClaimPoapState) then) =
      __$$_ClaimPoapStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool claimed, bool claiming, Claim? claim, Failure? failure});
}

/// @nodoc
class __$$_ClaimPoapStateCopyWithImpl<$Res>
    extends _$ClaimPoapStateCopyWithImpl<$Res, _$_ClaimPoapState>
    implements _$$_ClaimPoapStateCopyWith<$Res> {
  __$$_ClaimPoapStateCopyWithImpl(
      _$_ClaimPoapState _value, $Res Function(_$_ClaimPoapState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimed = null,
    Object? claiming = null,
    Object? claim = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$_ClaimPoapState(
      claimed: null == claimed
          ? _value.claimed
          : claimed // ignore: cast_nullable_to_non_nullable
              as bool,
      claiming: null == claiming
          ? _value.claiming
          : claiming // ignore: cast_nullable_to_non_nullable
              as bool,
      claim: freezed == claim
          ? _value.claim
          : claim // ignore: cast_nullable_to_non_nullable
              as Claim?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$_ClaimPoapState implements _ClaimPoapState {
  const _$_ClaimPoapState(
      {this.claimed = false, this.claiming = false, this.claim, this.failure});

  @override
  @JsonKey()
  final bool claimed;
  @override
  @JsonKey()
  final bool claiming;
  @override
  final Claim? claim;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'ClaimPoapState(claimed: $claimed, claiming: $claiming, claim: $claim, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClaimPoapState &&
            (identical(other.claimed, claimed) || other.claimed == claimed) &&
            (identical(other.claiming, claiming) ||
                other.claiming == claiming) &&
            (identical(other.claim, claim) || other.claim == claim) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, claimed, claiming, claim, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClaimPoapStateCopyWith<_$_ClaimPoapState> get copyWith =>
      __$$_ClaimPoapStateCopyWithImpl<_$_ClaimPoapState>(this, _$identity);
}

abstract class _ClaimPoapState implements ClaimPoapState {
  const factory _ClaimPoapState(
      {final bool claimed,
      final bool claiming,
      final Claim? claim,
      final Failure? failure}) = _$_ClaimPoapState;

  @override
  bool get claimed;
  @override
  bool get claiming;
  @override
  Claim? get claim;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$_ClaimPoapStateCopyWith<_$_ClaimPoapState> get copyWith =>
      throw _privateConstructorUsedError;
}
