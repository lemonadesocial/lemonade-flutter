// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_space_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatSpaceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchChatSpaces,
    required TResult Function(Room? space) setActiveSpace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchChatSpaces,
    TResult? Function(Room? space)? setActiveSpace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchChatSpaces,
    TResult Function(Room? space)? setActiveSpace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatSpaceEventFetchChatSpaces value)
        fetchChatSpaces,
    required TResult Function(ChatSpaceEventSetActiveSpace value)
        setActiveSpace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult? Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSpaceEventCopyWith<$Res> {
  factory $ChatSpaceEventCopyWith(
          ChatSpaceEvent value, $Res Function(ChatSpaceEvent) then) =
      _$ChatSpaceEventCopyWithImpl<$Res, ChatSpaceEvent>;
}

/// @nodoc
class _$ChatSpaceEventCopyWithImpl<$Res, $Val extends ChatSpaceEvent>
    implements $ChatSpaceEventCopyWith<$Res> {
  _$ChatSpaceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatSpaceEventFetchChatSpacesCopyWith<$Res> {
  factory _$$ChatSpaceEventFetchChatSpacesCopyWith(
          _$ChatSpaceEventFetchChatSpaces value,
          $Res Function(_$ChatSpaceEventFetchChatSpaces) then) =
      __$$ChatSpaceEventFetchChatSpacesCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatSpaceEventFetchChatSpacesCopyWithImpl<$Res>
    extends _$ChatSpaceEventCopyWithImpl<$Res, _$ChatSpaceEventFetchChatSpaces>
    implements _$$ChatSpaceEventFetchChatSpacesCopyWith<$Res> {
  __$$ChatSpaceEventFetchChatSpacesCopyWithImpl(
      _$ChatSpaceEventFetchChatSpaces _value,
      $Res Function(_$ChatSpaceEventFetchChatSpaces) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatSpaceEventFetchChatSpaces implements ChatSpaceEventFetchChatSpaces {
  const _$ChatSpaceEventFetchChatSpaces();

  @override
  String toString() {
    return 'ChatSpaceEvent.fetchChatSpaces()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSpaceEventFetchChatSpaces);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchChatSpaces,
    required TResult Function(Room? space) setActiveSpace,
  }) {
    return fetchChatSpaces();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchChatSpaces,
    TResult? Function(Room? space)? setActiveSpace,
  }) {
    return fetchChatSpaces?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchChatSpaces,
    TResult Function(Room? space)? setActiveSpace,
    required TResult orElse(),
  }) {
    if (fetchChatSpaces != null) {
      return fetchChatSpaces();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatSpaceEventFetchChatSpaces value)
        fetchChatSpaces,
    required TResult Function(ChatSpaceEventSetActiveSpace value)
        setActiveSpace,
  }) {
    return fetchChatSpaces(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult? Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
  }) {
    return fetchChatSpaces?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
    required TResult orElse(),
  }) {
    if (fetchChatSpaces != null) {
      return fetchChatSpaces(this);
    }
    return orElse();
  }
}

abstract class ChatSpaceEventFetchChatSpaces implements ChatSpaceEvent {
  const factory ChatSpaceEventFetchChatSpaces() =
      _$ChatSpaceEventFetchChatSpaces;
}

/// @nodoc
abstract class _$$ChatSpaceEventSetActiveSpaceCopyWith<$Res> {
  factory _$$ChatSpaceEventSetActiveSpaceCopyWith(
          _$ChatSpaceEventSetActiveSpace value,
          $Res Function(_$ChatSpaceEventSetActiveSpace) then) =
      __$$ChatSpaceEventSetActiveSpaceCopyWithImpl<$Res>;
  @useResult
  $Res call({Room? space});
}

/// @nodoc
class __$$ChatSpaceEventSetActiveSpaceCopyWithImpl<$Res>
    extends _$ChatSpaceEventCopyWithImpl<$Res, _$ChatSpaceEventSetActiveSpace>
    implements _$$ChatSpaceEventSetActiveSpaceCopyWith<$Res> {
  __$$ChatSpaceEventSetActiveSpaceCopyWithImpl(
      _$ChatSpaceEventSetActiveSpace _value,
      $Res Function(_$ChatSpaceEventSetActiveSpace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? space = freezed,
  }) {
    return _then(_$ChatSpaceEventSetActiveSpace(
      space: freezed == space
          ? _value.space
          : space // ignore: cast_nullable_to_non_nullable
              as Room?,
    ));
  }
}

/// @nodoc

class _$ChatSpaceEventSetActiveSpace implements ChatSpaceEventSetActiveSpace {
  const _$ChatSpaceEventSetActiveSpace({this.space});

  @override
  final Room? space;

  @override
  String toString() {
    return 'ChatSpaceEvent.setActiveSpace(space: $space)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSpaceEventSetActiveSpace &&
            (identical(other.space, space) || other.space == space));
  }

  @override
  int get hashCode => Object.hash(runtimeType, space);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSpaceEventSetActiveSpaceCopyWith<_$ChatSpaceEventSetActiveSpace>
      get copyWith => __$$ChatSpaceEventSetActiveSpaceCopyWithImpl<
          _$ChatSpaceEventSetActiveSpace>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchChatSpaces,
    required TResult Function(Room? space) setActiveSpace,
  }) {
    return setActiveSpace(space);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchChatSpaces,
    TResult? Function(Room? space)? setActiveSpace,
  }) {
    return setActiveSpace?.call(space);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchChatSpaces,
    TResult Function(Room? space)? setActiveSpace,
    required TResult orElse(),
  }) {
    if (setActiveSpace != null) {
      return setActiveSpace(space);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatSpaceEventFetchChatSpaces value)
        fetchChatSpaces,
    required TResult Function(ChatSpaceEventSetActiveSpace value)
        setActiveSpace,
  }) {
    return setActiveSpace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult? Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
  }) {
    return setActiveSpace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatSpaceEventFetchChatSpaces value)? fetchChatSpaces,
    TResult Function(ChatSpaceEventSetActiveSpace value)? setActiveSpace,
    required TResult orElse(),
  }) {
    if (setActiveSpace != null) {
      return setActiveSpace(this);
    }
    return orElse();
  }
}

abstract class ChatSpaceEventSetActiveSpace implements ChatSpaceEvent {
  const factory ChatSpaceEventSetActiveSpace({final Room? space}) =
      _$ChatSpaceEventSetActiveSpace;

  Room? get space;
  @JsonKey(ignore: true)
  _$$ChatSpaceEventSetActiveSpaceCopyWith<_$ChatSpaceEventSetActiveSpace>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatSpaceState {
  Room? get activeSpace => throw _privateConstructorUsedError;
  List<Room> get spaces => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatSpaceStateCopyWith<ChatSpaceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSpaceStateCopyWith<$Res> {
  factory $ChatSpaceStateCopyWith(
          ChatSpaceState value, $Res Function(ChatSpaceState) then) =
      _$ChatSpaceStateCopyWithImpl<$Res, ChatSpaceState>;
  @useResult
  $Res call({Room? activeSpace, List<Room> spaces});
}

/// @nodoc
class _$ChatSpaceStateCopyWithImpl<$Res, $Val extends ChatSpaceState>
    implements $ChatSpaceStateCopyWith<$Res> {
  _$ChatSpaceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeSpace = freezed,
    Object? spaces = null,
  }) {
    return _then(_value.copyWith(
      activeSpace: freezed == activeSpace
          ? _value.activeSpace
          : activeSpace // ignore: cast_nullable_to_non_nullable
              as Room?,
      spaces: null == spaces
          ? _value.spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<Room>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatSpaceStateCopyWith<$Res>
    implements $ChatSpaceStateCopyWith<$Res> {
  factory _$$_ChatSpaceStateCopyWith(
          _$_ChatSpaceState value, $Res Function(_$_ChatSpaceState) then) =
      __$$_ChatSpaceStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Room? activeSpace, List<Room> spaces});
}

/// @nodoc
class __$$_ChatSpaceStateCopyWithImpl<$Res>
    extends _$ChatSpaceStateCopyWithImpl<$Res, _$_ChatSpaceState>
    implements _$$_ChatSpaceStateCopyWith<$Res> {
  __$$_ChatSpaceStateCopyWithImpl(
      _$_ChatSpaceState _value, $Res Function(_$_ChatSpaceState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeSpace = freezed,
    Object? spaces = null,
  }) {
    return _then(_$_ChatSpaceState(
      activeSpace: freezed == activeSpace
          ? _value.activeSpace
          : activeSpace // ignore: cast_nullable_to_non_nullable
              as Room?,
      spaces: null == spaces
          ? _value._spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<Room>,
    ));
  }
}

/// @nodoc

class _$_ChatSpaceState implements _ChatSpaceState {
  const _$_ChatSpaceState({this.activeSpace, required final List<Room> spaces})
      : _spaces = spaces;

  @override
  final Room? activeSpace;
  final List<Room> _spaces;
  @override
  List<Room> get spaces {
    if (_spaces is EqualUnmodifiableListView) return _spaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spaces);
  }

  @override
  String toString() {
    return 'ChatSpaceState(activeSpace: $activeSpace, spaces: $spaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatSpaceState &&
            (identical(other.activeSpace, activeSpace) ||
                other.activeSpace == activeSpace) &&
            const DeepCollectionEquality().equals(other._spaces, _spaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, activeSpace, const DeepCollectionEquality().hash(_spaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatSpaceStateCopyWith<_$_ChatSpaceState> get copyWith =>
      __$$_ChatSpaceStateCopyWithImpl<_$_ChatSpaceState>(this, _$identity);
}

abstract class _ChatSpaceState implements ChatSpaceState {
  const factory _ChatSpaceState(
      {final Room? activeSpace,
      required final List<Room> spaces}) = _$_ChatSpaceState;

  @override
  Room? get activeSpace;
  @override
  List<Room> get spaces;
  @override
  @JsonKey(ignore: true)
  _$$_ChatSpaceStateCopyWith<_$_ChatSpaceState> get copyWith =>
      throw _privateConstructorUsedError;
}
