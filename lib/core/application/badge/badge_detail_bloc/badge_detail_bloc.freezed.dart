// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BadgeDetailState {
  Badge get badge => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BadgeDetailStateCopyWith<BadgeDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeDetailStateCopyWith<$Res> {
  factory $BadgeDetailStateCopyWith(
          BadgeDetailState value, $Res Function(BadgeDetailState) then) =
      _$BadgeDetailStateCopyWithImpl<$Res, BadgeDetailState>;
  @useResult
  $Res call({Badge badge, dynamic isLoading});
}

/// @nodoc
class _$BadgeDetailStateCopyWithImpl<$Res, $Val extends BadgeDetailState>
    implements $BadgeDetailStateCopyWith<$Res> {
  _$BadgeDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badge = null,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      badge: null == badge
          ? _value.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as Badge,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BadgeDetailStateCopyWith<$Res>
    implements $BadgeDetailStateCopyWith<$Res> {
  factory _$$_BadgeDetailStateCopyWith(
          _$_BadgeDetailState value, $Res Function(_$_BadgeDetailState) then) =
      __$$_BadgeDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Badge badge, dynamic isLoading});
}

/// @nodoc
class __$$_BadgeDetailStateCopyWithImpl<$Res>
    extends _$BadgeDetailStateCopyWithImpl<$Res, _$_BadgeDetailState>
    implements _$$_BadgeDetailStateCopyWith<$Res> {
  __$$_BadgeDetailStateCopyWithImpl(
      _$_BadgeDetailState _value, $Res Function(_$_BadgeDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badge = null,
    Object? isLoading = freezed,
  }) {
    return _then(_$_BadgeDetailState(
      badge: null == badge
          ? _value.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as Badge,
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
    ));
  }
}

/// @nodoc

class _$_BadgeDetailState implements _BadgeDetailState {
  const _$_BadgeDetailState({required this.badge, this.isLoading = false});

  @override
  final Badge badge;
  @override
  @JsonKey()
  final dynamic isLoading;

  @override
  String toString() {
    return 'BadgeDetailState(badge: $badge, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BadgeDetailState &&
            (identical(other.badge, badge) || other.badge == badge) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, badge, const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BadgeDetailStateCopyWith<_$_BadgeDetailState> get copyWith =>
      __$$_BadgeDetailStateCopyWithImpl<_$_BadgeDetailState>(this, _$identity);
}

abstract class _BadgeDetailState implements BadgeDetailState {
  const factory _BadgeDetailState(
      {required final Badge badge,
      final dynamic isLoading}) = _$_BadgeDetailState;

  @override
  Badge get badge;
  @override
  dynamic get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_BadgeDetailStateCopyWith<_$_BadgeDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BadgeDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeDetailEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeDetailEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeDetailEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeDetailEventCopyWith<$Res> {
  factory $BadgeDetailEventCopyWith(
          BadgeDetailEvent value, $Res Function(BadgeDetailEvent) then) =
      _$BadgeDetailEventCopyWithImpl<$Res, BadgeDetailEvent>;
}

/// @nodoc
class _$BadgeDetailEventCopyWithImpl<$Res, $Val extends BadgeDetailEvent>
    implements $BadgeDetailEventCopyWith<$Res> {
  _$BadgeDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgeDetailEventFetchCopyWith<$Res> {
  factory _$$BadgeDetailEventFetchCopyWith(_$BadgeDetailEventFetch value,
          $Res Function(_$BadgeDetailEventFetch) then) =
      __$$BadgeDetailEventFetchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeDetailEventFetchCopyWithImpl<$Res>
    extends _$BadgeDetailEventCopyWithImpl<$Res, _$BadgeDetailEventFetch>
    implements _$$BadgeDetailEventFetchCopyWith<$Res> {
  __$$BadgeDetailEventFetchCopyWithImpl(_$BadgeDetailEventFetch _value,
      $Res Function(_$BadgeDetailEventFetch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeDetailEventFetch implements BadgeDetailEventFetch {
  const _$BadgeDetailEventFetch();

  @override
  String toString() {
    return 'BadgeDetailEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BadgeDetailEventFetch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeDetailEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeDetailEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeDetailEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BadgeDetailEventFetch implements BadgeDetailEvent {
  const factory BadgeDetailEventFetch() = _$BadgeDetailEventFetch;
}
