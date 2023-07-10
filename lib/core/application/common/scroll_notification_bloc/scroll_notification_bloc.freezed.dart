// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scroll_notification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScrollNotificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() scroll,
    required TResult Function() reachEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? scroll,
    TResult? Function()? reachEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? scroll,
    TResult Function()? reachEnd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationEventScroll value) scroll,
    required TResult Function(ScrollNotificationEventReachEnd value) reachEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationEventScroll value)? scroll,
    TResult? Function(ScrollNotificationEventReachEnd value)? reachEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationEventScroll value)? scroll,
    TResult Function(ScrollNotificationEventReachEnd value)? reachEnd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrollNotificationEventCopyWith<$Res> {
  factory $ScrollNotificationEventCopyWith(ScrollNotificationEvent value,
          $Res Function(ScrollNotificationEvent) then) =
      _$ScrollNotificationEventCopyWithImpl<$Res, ScrollNotificationEvent>;
}

/// @nodoc
class _$ScrollNotificationEventCopyWithImpl<$Res,
        $Val extends ScrollNotificationEvent>
    implements $ScrollNotificationEventCopyWith<$Res> {
  _$ScrollNotificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ScrollNotificationEventScrollCopyWith<$Res> {
  factory _$$ScrollNotificationEventScrollCopyWith(
          _$ScrollNotificationEventScroll value,
          $Res Function(_$ScrollNotificationEventScroll) then) =
      __$$ScrollNotificationEventScrollCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScrollNotificationEventScrollCopyWithImpl<$Res>
    extends _$ScrollNotificationEventCopyWithImpl<$Res,
        _$ScrollNotificationEventScroll>
    implements _$$ScrollNotificationEventScrollCopyWith<$Res> {
  __$$ScrollNotificationEventScrollCopyWithImpl(
      _$ScrollNotificationEventScroll _value,
      $Res Function(_$ScrollNotificationEventScroll) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ScrollNotificationEventScroll implements ScrollNotificationEventScroll {
  const _$ScrollNotificationEventScroll();

  @override
  String toString() {
    return 'ScrollNotificationEvent.scroll()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollNotificationEventScroll);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() scroll,
    required TResult Function() reachEnd,
  }) {
    return scroll();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? scroll,
    TResult? Function()? reachEnd,
  }) {
    return scroll?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? scroll,
    TResult Function()? reachEnd,
    required TResult orElse(),
  }) {
    if (scroll != null) {
      return scroll();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationEventScroll value) scroll,
    required TResult Function(ScrollNotificationEventReachEnd value) reachEnd,
  }) {
    return scroll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationEventScroll value)? scroll,
    TResult? Function(ScrollNotificationEventReachEnd value)? reachEnd,
  }) {
    return scroll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationEventScroll value)? scroll,
    TResult Function(ScrollNotificationEventReachEnd value)? reachEnd,
    required TResult orElse(),
  }) {
    if (scroll != null) {
      return scroll(this);
    }
    return orElse();
  }
}

abstract class ScrollNotificationEventScroll
    implements ScrollNotificationEvent {
  const factory ScrollNotificationEventScroll() =
      _$ScrollNotificationEventScroll;
}

/// @nodoc
abstract class _$$ScrollNotificationEventReachEndCopyWith<$Res> {
  factory _$$ScrollNotificationEventReachEndCopyWith(
          _$ScrollNotificationEventReachEnd value,
          $Res Function(_$ScrollNotificationEventReachEnd) then) =
      __$$ScrollNotificationEventReachEndCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScrollNotificationEventReachEndCopyWithImpl<$Res>
    extends _$ScrollNotificationEventCopyWithImpl<$Res,
        _$ScrollNotificationEventReachEnd>
    implements _$$ScrollNotificationEventReachEndCopyWith<$Res> {
  __$$ScrollNotificationEventReachEndCopyWithImpl(
      _$ScrollNotificationEventReachEnd _value,
      $Res Function(_$ScrollNotificationEventReachEnd) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ScrollNotificationEventReachEnd
    implements ScrollNotificationEventReachEnd {
  const _$ScrollNotificationEventReachEnd();

  @override
  String toString() {
    return 'ScrollNotificationEvent.reachEnd()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollNotificationEventReachEnd);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() scroll,
    required TResult Function() reachEnd,
  }) {
    return reachEnd();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? scroll,
    TResult? Function()? reachEnd,
  }) {
    return reachEnd?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? scroll,
    TResult Function()? reachEnd,
    required TResult orElse(),
  }) {
    if (reachEnd != null) {
      return reachEnd();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationEventScroll value) scroll,
    required TResult Function(ScrollNotificationEventReachEnd value) reachEnd,
  }) {
    return reachEnd(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationEventScroll value)? scroll,
    TResult? Function(ScrollNotificationEventReachEnd value)? reachEnd,
  }) {
    return reachEnd?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationEventScroll value)? scroll,
    TResult Function(ScrollNotificationEventReachEnd value)? reachEnd,
    required TResult orElse(),
  }) {
    if (reachEnd != null) {
      return reachEnd(this);
    }
    return orElse();
  }
}

abstract class ScrollNotificationEventReachEnd
    implements ScrollNotificationEvent {
  const factory ScrollNotificationEventReachEnd() =
      _$ScrollNotificationEventReachEnd;
}

/// @nodoc
mixin _$ScrollNotificationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() endReached,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? endReached,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? endReached,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationStateInitial value) initial,
    required TResult Function(ScrollNotificationStateEndReached value)
        endReached,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationStateInitial value)? initial,
    TResult? Function(ScrollNotificationStateEndReached value)? endReached,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationStateInitial value)? initial,
    TResult Function(ScrollNotificationStateEndReached value)? endReached,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrollNotificationStateCopyWith<$Res> {
  factory $ScrollNotificationStateCopyWith(ScrollNotificationState value,
          $Res Function(ScrollNotificationState) then) =
      _$ScrollNotificationStateCopyWithImpl<$Res, ScrollNotificationState>;
}

/// @nodoc
class _$ScrollNotificationStateCopyWithImpl<$Res,
        $Val extends ScrollNotificationState>
    implements $ScrollNotificationStateCopyWith<$Res> {
  _$ScrollNotificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ScrollNotificationStateInitialCopyWith<$Res> {
  factory _$$ScrollNotificationStateInitialCopyWith(
          _$ScrollNotificationStateInitial value,
          $Res Function(_$ScrollNotificationStateInitial) then) =
      __$$ScrollNotificationStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScrollNotificationStateInitialCopyWithImpl<$Res>
    extends _$ScrollNotificationStateCopyWithImpl<$Res,
        _$ScrollNotificationStateInitial>
    implements _$$ScrollNotificationStateInitialCopyWith<$Res> {
  __$$ScrollNotificationStateInitialCopyWithImpl(
      _$ScrollNotificationStateInitial _value,
      $Res Function(_$ScrollNotificationStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ScrollNotificationStateInitial
    implements ScrollNotificationStateInitial {
  const _$ScrollNotificationStateInitial();

  @override
  String toString() {
    return 'ScrollNotificationState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollNotificationStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() endReached,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? endReached,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? endReached,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationStateInitial value) initial,
    required TResult Function(ScrollNotificationStateEndReached value)
        endReached,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationStateInitial value)? initial,
    TResult? Function(ScrollNotificationStateEndReached value)? endReached,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationStateInitial value)? initial,
    TResult Function(ScrollNotificationStateEndReached value)? endReached,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ScrollNotificationStateInitial
    implements ScrollNotificationState {
  const factory ScrollNotificationStateInitial() =
      _$ScrollNotificationStateInitial;
}

/// @nodoc
abstract class _$$ScrollNotificationStateEndReachedCopyWith<$Res> {
  factory _$$ScrollNotificationStateEndReachedCopyWith(
          _$ScrollNotificationStateEndReached value,
          $Res Function(_$ScrollNotificationStateEndReached) then) =
      __$$ScrollNotificationStateEndReachedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScrollNotificationStateEndReachedCopyWithImpl<$Res>
    extends _$ScrollNotificationStateCopyWithImpl<$Res,
        _$ScrollNotificationStateEndReached>
    implements _$$ScrollNotificationStateEndReachedCopyWith<$Res> {
  __$$ScrollNotificationStateEndReachedCopyWithImpl(
      _$ScrollNotificationStateEndReached _value,
      $Res Function(_$ScrollNotificationStateEndReached) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ScrollNotificationStateEndReached
    implements ScrollNotificationStateEndReached {
  const _$ScrollNotificationStateEndReached();

  @override
  String toString() {
    return 'ScrollNotificationState.endReached()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollNotificationStateEndReached);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() endReached,
  }) {
    return endReached();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? endReached,
  }) {
    return endReached?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? endReached,
    required TResult orElse(),
  }) {
    if (endReached != null) {
      return endReached();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollNotificationStateInitial value) initial,
    required TResult Function(ScrollNotificationStateEndReached value)
        endReached,
  }) {
    return endReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScrollNotificationStateInitial value)? initial,
    TResult? Function(ScrollNotificationStateEndReached value)? endReached,
  }) {
    return endReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollNotificationStateInitial value)? initial,
    TResult Function(ScrollNotificationStateEndReached value)? endReached,
    required TResult orElse(),
  }) {
    if (endReached != null) {
      return endReached(this);
    }
    return orElse();
  }
}

abstract class ScrollNotificationStateEndReached
    implements ScrollNotificationState {
  const factory ScrollNotificationStateEndReached() =
      _$ScrollNotificationStateEndReached;
}
