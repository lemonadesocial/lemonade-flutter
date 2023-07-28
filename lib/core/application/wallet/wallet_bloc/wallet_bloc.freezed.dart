// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initWalletConnect,
    required TResult Function(
            SupportedWalletApp walletApp, List<Chains>? chains)
        connectWallet,
    required TResult Function() getActiveSessions,
    required TResult Function(String wallet) updateUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initWalletConnect,
    TResult? Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult? Function()? getActiveSessions,
    TResult? Function(String wallet)? updateUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initWalletConnect,
    TResult Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult Function()? getActiveSessions,
    TResult Function(String wallet)? updateUserWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletEventInitWalletConnect value)
        initWalletConnect,
    required TResult Function(WalletEventConnectWallet value) connectWallet,
    required TResult Function(WalletEventGetActiveSessions value)
        getActiveSessions,
    required TResult Function(WalletEventUpdateUserWallet value)
        updateUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult? Function(WalletEventConnectWallet value)? connectWallet,
    TResult? Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult? Function(WalletEventUpdateUserWallet value)? updateUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult Function(WalletEventConnectWallet value)? connectWallet,
    TResult Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult Function(WalletEventUpdateUserWallet value)? updateUserWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
          WalletEvent value, $Res Function(WalletEvent) then) =
      _$WalletEventCopyWithImpl<$Res, WalletEvent>;
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res, $Val extends WalletEvent>
    implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WalletEventInitWalletConnectCopyWith<$Res> {
  factory _$$WalletEventInitWalletConnectCopyWith(
          _$WalletEventInitWalletConnect value,
          $Res Function(_$WalletEventInitWalletConnect) then) =
      __$$WalletEventInitWalletConnectCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WalletEventInitWalletConnectCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WalletEventInitWalletConnect>
    implements _$$WalletEventInitWalletConnectCopyWith<$Res> {
  __$$WalletEventInitWalletConnectCopyWithImpl(
      _$WalletEventInitWalletConnect _value,
      $Res Function(_$WalletEventInitWalletConnect) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WalletEventInitWalletConnect implements WalletEventInitWalletConnect {
  const _$WalletEventInitWalletConnect();

  @override
  String toString() {
    return 'WalletEvent.initWalletConnect()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEventInitWalletConnect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initWalletConnect,
    required TResult Function(
            SupportedWalletApp walletApp, List<Chains>? chains)
        connectWallet,
    required TResult Function() getActiveSessions,
    required TResult Function(String wallet) updateUserWallet,
  }) {
    return initWalletConnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initWalletConnect,
    TResult? Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult? Function()? getActiveSessions,
    TResult? Function(String wallet)? updateUserWallet,
  }) {
    return initWalletConnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initWalletConnect,
    TResult Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult Function()? getActiveSessions,
    TResult Function(String wallet)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (initWalletConnect != null) {
      return initWalletConnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletEventInitWalletConnect value)
        initWalletConnect,
    required TResult Function(WalletEventConnectWallet value) connectWallet,
    required TResult Function(WalletEventGetActiveSessions value)
        getActiveSessions,
    required TResult Function(WalletEventUpdateUserWallet value)
        updateUserWallet,
  }) {
    return initWalletConnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult? Function(WalletEventConnectWallet value)? connectWallet,
    TResult? Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult? Function(WalletEventUpdateUserWallet value)? updateUserWallet,
  }) {
    return initWalletConnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult Function(WalletEventConnectWallet value)? connectWallet,
    TResult Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult Function(WalletEventUpdateUserWallet value)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (initWalletConnect != null) {
      return initWalletConnect(this);
    }
    return orElse();
  }
}

abstract class WalletEventInitWalletConnect implements WalletEvent {
  const factory WalletEventInitWalletConnect() = _$WalletEventInitWalletConnect;
}

/// @nodoc
abstract class _$$WalletEventConnectWalletCopyWith<$Res> {
  factory _$$WalletEventConnectWalletCopyWith(_$WalletEventConnectWallet value,
          $Res Function(_$WalletEventConnectWallet) then) =
      __$$WalletEventConnectWalletCopyWithImpl<$Res>;
  @useResult
  $Res call({SupportedWalletApp walletApp, List<Chains>? chains});
}

/// @nodoc
class __$$WalletEventConnectWalletCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WalletEventConnectWallet>
    implements _$$WalletEventConnectWalletCopyWith<$Res> {
  __$$WalletEventConnectWalletCopyWithImpl(_$WalletEventConnectWallet _value,
      $Res Function(_$WalletEventConnectWallet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletApp = null,
    Object? chains = freezed,
  }) {
    return _then(_$WalletEventConnectWallet(
      walletApp: null == walletApp
          ? _value.walletApp
          : walletApp // ignore: cast_nullable_to_non_nullable
              as SupportedWalletApp,
      chains: freezed == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<Chains>?,
    ));
  }
}

/// @nodoc

class _$WalletEventConnectWallet implements WalletEventConnectWallet {
  const _$WalletEventConnectWallet(
      {required this.walletApp, final List<Chains>? chains})
      : _chains = chains;

  @override
  final SupportedWalletApp walletApp;
  final List<Chains>? _chains;
  @override
  List<Chains>? get chains {
    final value = _chains;
    if (value == null) return null;
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WalletEvent.connectWallet(walletApp: $walletApp, chains: $chains)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEventConnectWallet &&
            (identical(other.walletApp, walletApp) ||
                other.walletApp == walletApp) &&
            const DeepCollectionEquality().equals(other._chains, _chains));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, walletApp, const DeepCollectionEquality().hash(_chains));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletEventConnectWalletCopyWith<_$WalletEventConnectWallet>
      get copyWith =>
          __$$WalletEventConnectWalletCopyWithImpl<_$WalletEventConnectWallet>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initWalletConnect,
    required TResult Function(
            SupportedWalletApp walletApp, List<Chains>? chains)
        connectWallet,
    required TResult Function() getActiveSessions,
    required TResult Function(String wallet) updateUserWallet,
  }) {
    return connectWallet(walletApp, chains);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initWalletConnect,
    TResult? Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult? Function()? getActiveSessions,
    TResult? Function(String wallet)? updateUserWallet,
  }) {
    return connectWallet?.call(walletApp, chains);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initWalletConnect,
    TResult Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult Function()? getActiveSessions,
    TResult Function(String wallet)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (connectWallet != null) {
      return connectWallet(walletApp, chains);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletEventInitWalletConnect value)
        initWalletConnect,
    required TResult Function(WalletEventConnectWallet value) connectWallet,
    required TResult Function(WalletEventGetActiveSessions value)
        getActiveSessions,
    required TResult Function(WalletEventUpdateUserWallet value)
        updateUserWallet,
  }) {
    return connectWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult? Function(WalletEventConnectWallet value)? connectWallet,
    TResult? Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult? Function(WalletEventUpdateUserWallet value)? updateUserWallet,
  }) {
    return connectWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult Function(WalletEventConnectWallet value)? connectWallet,
    TResult Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult Function(WalletEventUpdateUserWallet value)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (connectWallet != null) {
      return connectWallet(this);
    }
    return orElse();
  }
}

abstract class WalletEventConnectWallet implements WalletEvent {
  const factory WalletEventConnectWallet(
      {required final SupportedWalletApp walletApp,
      final List<Chains>? chains}) = _$WalletEventConnectWallet;

  SupportedWalletApp get walletApp;
  List<Chains>? get chains;
  @JsonKey(ignore: true)
  _$$WalletEventConnectWalletCopyWith<_$WalletEventConnectWallet>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletEventGetActiveSessionsCopyWith<$Res> {
  factory _$$WalletEventGetActiveSessionsCopyWith(
          _$WalletEventGetActiveSessions value,
          $Res Function(_$WalletEventGetActiveSessions) then) =
      __$$WalletEventGetActiveSessionsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WalletEventGetActiveSessionsCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WalletEventGetActiveSessions>
    implements _$$WalletEventGetActiveSessionsCopyWith<$Res> {
  __$$WalletEventGetActiveSessionsCopyWithImpl(
      _$WalletEventGetActiveSessions _value,
      $Res Function(_$WalletEventGetActiveSessions) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WalletEventGetActiveSessions implements WalletEventGetActiveSessions {
  const _$WalletEventGetActiveSessions();

  @override
  String toString() {
    return 'WalletEvent.getActiveSessions()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEventGetActiveSessions);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initWalletConnect,
    required TResult Function(
            SupportedWalletApp walletApp, List<Chains>? chains)
        connectWallet,
    required TResult Function() getActiveSessions,
    required TResult Function(String wallet) updateUserWallet,
  }) {
    return getActiveSessions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initWalletConnect,
    TResult? Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult? Function()? getActiveSessions,
    TResult? Function(String wallet)? updateUserWallet,
  }) {
    return getActiveSessions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initWalletConnect,
    TResult Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult Function()? getActiveSessions,
    TResult Function(String wallet)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (getActiveSessions != null) {
      return getActiveSessions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletEventInitWalletConnect value)
        initWalletConnect,
    required TResult Function(WalletEventConnectWallet value) connectWallet,
    required TResult Function(WalletEventGetActiveSessions value)
        getActiveSessions,
    required TResult Function(WalletEventUpdateUserWallet value)
        updateUserWallet,
  }) {
    return getActiveSessions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult? Function(WalletEventConnectWallet value)? connectWallet,
    TResult? Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult? Function(WalletEventUpdateUserWallet value)? updateUserWallet,
  }) {
    return getActiveSessions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult Function(WalletEventConnectWallet value)? connectWallet,
    TResult Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult Function(WalletEventUpdateUserWallet value)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (getActiveSessions != null) {
      return getActiveSessions(this);
    }
    return orElse();
  }
}

abstract class WalletEventGetActiveSessions implements WalletEvent {
  const factory WalletEventGetActiveSessions() = _$WalletEventGetActiveSessions;
}

/// @nodoc
abstract class _$$WalletEventUpdateUserWalletCopyWith<$Res> {
  factory _$$WalletEventUpdateUserWalletCopyWith(
          _$WalletEventUpdateUserWallet value,
          $Res Function(_$WalletEventUpdateUserWallet) then) =
      __$$WalletEventUpdateUserWalletCopyWithImpl<$Res>;
  @useResult
  $Res call({String wallet});
}

/// @nodoc
class __$$WalletEventUpdateUserWalletCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WalletEventUpdateUserWallet>
    implements _$$WalletEventUpdateUserWalletCopyWith<$Res> {
  __$$WalletEventUpdateUserWalletCopyWithImpl(
      _$WalletEventUpdateUserWallet _value,
      $Res Function(_$WalletEventUpdateUserWallet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = null,
  }) {
    return _then(_$WalletEventUpdateUserWallet(
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WalletEventUpdateUserWallet implements WalletEventUpdateUserWallet {
  const _$WalletEventUpdateUserWallet({required this.wallet});

  @override
  final String wallet;

  @override
  String toString() {
    return 'WalletEvent.updateUserWallet(wallet: $wallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEventUpdateUserWallet &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletEventUpdateUserWalletCopyWith<_$WalletEventUpdateUserWallet>
      get copyWith => __$$WalletEventUpdateUserWalletCopyWithImpl<
          _$WalletEventUpdateUserWallet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initWalletConnect,
    required TResult Function(
            SupportedWalletApp walletApp, List<Chains>? chains)
        connectWallet,
    required TResult Function() getActiveSessions,
    required TResult Function(String wallet) updateUserWallet,
  }) {
    return updateUserWallet(wallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initWalletConnect,
    TResult? Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult? Function()? getActiveSessions,
    TResult? Function(String wallet)? updateUserWallet,
  }) {
    return updateUserWallet?.call(wallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initWalletConnect,
    TResult Function(SupportedWalletApp walletApp, List<Chains>? chains)?
        connectWallet,
    TResult Function()? getActiveSessions,
    TResult Function(String wallet)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (updateUserWallet != null) {
      return updateUserWallet(wallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletEventInitWalletConnect value)
        initWalletConnect,
    required TResult Function(WalletEventConnectWallet value) connectWallet,
    required TResult Function(WalletEventGetActiveSessions value)
        getActiveSessions,
    required TResult Function(WalletEventUpdateUserWallet value)
        updateUserWallet,
  }) {
    return updateUserWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult? Function(WalletEventConnectWallet value)? connectWallet,
    TResult? Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult? Function(WalletEventUpdateUserWallet value)? updateUserWallet,
  }) {
    return updateUserWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletEventInitWalletConnect value)? initWalletConnect,
    TResult Function(WalletEventConnectWallet value)? connectWallet,
    TResult Function(WalletEventGetActiveSessions value)? getActiveSessions,
    TResult Function(WalletEventUpdateUserWallet value)? updateUserWallet,
    required TResult orElse(),
  }) {
    if (updateUserWallet != null) {
      return updateUserWallet(this);
    }
    return orElse();
  }
}

abstract class WalletEventUpdateUserWallet implements WalletEvent {
  const factory WalletEventUpdateUserWallet({required final String wallet}) =
      _$WalletEventUpdateUserWallet;

  String get wallet;
  @JsonKey(ignore: true)
  _$$WalletEventUpdateUserWalletCopyWith<_$WalletEventUpdateUserWallet>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletState {
  SessionData? get activeSession => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call({SessionData? activeSession});
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeSession = freezed,
  }) {
    return _then(_value.copyWith(
      activeSession: freezed == activeSession
          ? _value.activeSession
          : activeSession // ignore: cast_nullable_to_non_nullable
              as SessionData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletStateCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$_WalletStateCopyWith(
          _$_WalletState value, $Res Function(_$_WalletState) then) =
      __$$_WalletStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SessionData? activeSession});
}

/// @nodoc
class __$$_WalletStateCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$_WalletState>
    implements _$$_WalletStateCopyWith<$Res> {
  __$$_WalletStateCopyWithImpl(
      _$_WalletState _value, $Res Function(_$_WalletState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeSession = freezed,
  }) {
    return _then(_$_WalletState(
      activeSession: freezed == activeSession
          ? _value.activeSession
          : activeSession // ignore: cast_nullable_to_non_nullable
              as SessionData?,
    ));
  }
}

/// @nodoc

class _$_WalletState implements _WalletState {
  const _$_WalletState({this.activeSession});

  @override
  final SessionData? activeSession;

  @override
  String toString() {
    return 'WalletState(activeSession: $activeSession)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletState &&
            (identical(other.activeSession, activeSession) ||
                other.activeSession == activeSession));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeSession);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletStateCopyWith<_$_WalletState> get copyWith =>
      __$$_WalletStateCopyWithImpl<_$_WalletState>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  const factory _WalletState({final SessionData? activeSession}) =
      _$_WalletState;

  @override
  SessionData? get activeSession;
  @override
  @JsonKey(ignore: true)
  _$$_WalletStateCopyWith<_$_WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
