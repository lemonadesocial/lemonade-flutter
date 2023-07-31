// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchRooms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchRooms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchRooms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListEventFetchRooms value) fetchRooms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListEventFetchRooms value)? fetchRooms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListEventFetchRooms value)? fetchRooms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListEventCopyWith<$Res> {
  factory $ChatListEventCopyWith(
          ChatListEvent value, $Res Function(ChatListEvent) then) =
      _$ChatListEventCopyWithImpl<$Res, ChatListEvent>;
}

/// @nodoc
class _$ChatListEventCopyWithImpl<$Res, $Val extends ChatListEvent>
    implements $ChatListEventCopyWith<$Res> {
  _$ChatListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatListEventFetchRoomsCopyWith<$Res> {
  factory _$$ChatListEventFetchRoomsCopyWith(_$ChatListEventFetchRooms value,
          $Res Function(_$ChatListEventFetchRooms) then) =
      __$$ChatListEventFetchRoomsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatListEventFetchRoomsCopyWithImpl<$Res>
    extends _$ChatListEventCopyWithImpl<$Res, _$ChatListEventFetchRooms>
    implements _$$ChatListEventFetchRoomsCopyWith<$Res> {
  __$$ChatListEventFetchRoomsCopyWithImpl(_$ChatListEventFetchRooms _value,
      $Res Function(_$ChatListEventFetchRooms) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatListEventFetchRooms implements ChatListEventFetchRooms {
  const _$ChatListEventFetchRooms();

  @override
  String toString() {
    return 'ChatListEvent.fetchRooms()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListEventFetchRooms);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchRooms,
  }) {
    return fetchRooms();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchRooms,
  }) {
    return fetchRooms?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchRooms,
    required TResult orElse(),
  }) {
    if (fetchRooms != null) {
      return fetchRooms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListEventFetchRooms value) fetchRooms,
  }) {
    return fetchRooms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListEventFetchRooms value)? fetchRooms,
  }) {
    return fetchRooms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListEventFetchRooms value)? fetchRooms,
    required TResult orElse(),
  }) {
    if (fetchRooms != null) {
      return fetchRooms(this);
    }
    return orElse();
  }
}

abstract class ChatListEventFetchRooms implements ChatListEvent {
  const factory ChatListEventFetchRooms() = _$ChatListEventFetchRooms;
}

/// @nodoc
mixin _$ChatListState {
  List<Room> get channelRooms => throw _privateConstructorUsedError;
  List<Room> get dmRooms => throw _privateConstructorUsedError;
  List<Room> get unreadDmRooms => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatListStateCopyWith<ChatListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListStateCopyWith<$Res> {
  factory $ChatListStateCopyWith(
          ChatListState value, $Res Function(ChatListState) then) =
      _$ChatListStateCopyWithImpl<$Res, ChatListState>;
  @useResult
  $Res call(
      {List<Room> channelRooms, List<Room> dmRooms, List<Room> unreadDmRooms});
}

/// @nodoc
class _$ChatListStateCopyWithImpl<$Res, $Val extends ChatListState>
    implements $ChatListStateCopyWith<$Res> {
  _$ChatListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelRooms = null,
    Object? dmRooms = null,
    Object? unreadDmRooms = null,
  }) {
    return _then(_value.copyWith(
      channelRooms: null == channelRooms
          ? _value.channelRooms
          : channelRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      dmRooms: null == dmRooms
          ? _value.dmRooms
          : dmRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      unreadDmRooms: null == unreadDmRooms
          ? _value.unreadDmRooms
          : unreadDmRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatListStateCopyWith<$Res>
    implements $ChatListStateCopyWith<$Res> {
  factory _$$_ChatListStateCopyWith(
          _$_ChatListState value, $Res Function(_$_ChatListState) then) =
      __$$_ChatListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Room> channelRooms, List<Room> dmRooms, List<Room> unreadDmRooms});
}

/// @nodoc
class __$$_ChatListStateCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$_ChatListState>
    implements _$$_ChatListStateCopyWith<$Res> {
  __$$_ChatListStateCopyWithImpl(
      _$_ChatListState _value, $Res Function(_$_ChatListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelRooms = null,
    Object? dmRooms = null,
    Object? unreadDmRooms = null,
  }) {
    return _then(_$_ChatListState(
      channelRooms: null == channelRooms
          ? _value._channelRooms
          : channelRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      dmRooms: null == dmRooms
          ? _value._dmRooms
          : dmRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      unreadDmRooms: null == unreadDmRooms
          ? _value._unreadDmRooms
          : unreadDmRooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
    ));
  }
}

/// @nodoc

class _$_ChatListState implements _ChatListState {
  const _$_ChatListState(
      {required final List<Room> channelRooms,
      required final List<Room> dmRooms,
      required final List<Room> unreadDmRooms})
      : _channelRooms = channelRooms,
        _dmRooms = dmRooms,
        _unreadDmRooms = unreadDmRooms;

  final List<Room> _channelRooms;
  @override
  List<Room> get channelRooms {
    if (_channelRooms is EqualUnmodifiableListView) return _channelRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channelRooms);
  }

  final List<Room> _dmRooms;
  @override
  List<Room> get dmRooms {
    if (_dmRooms is EqualUnmodifiableListView) return _dmRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dmRooms);
  }

  final List<Room> _unreadDmRooms;
  @override
  List<Room> get unreadDmRooms {
    if (_unreadDmRooms is EqualUnmodifiableListView) return _unreadDmRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unreadDmRooms);
  }

  @override
  String toString() {
    return 'ChatListState(channelRooms: $channelRooms, dmRooms: $dmRooms, unreadDmRooms: $unreadDmRooms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatListState &&
            const DeepCollectionEquality()
                .equals(other._channelRooms, _channelRooms) &&
            const DeepCollectionEquality().equals(other._dmRooms, _dmRooms) &&
            const DeepCollectionEquality()
                .equals(other._unreadDmRooms, _unreadDmRooms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_channelRooms),
      const DeepCollectionEquality().hash(_dmRooms),
      const DeepCollectionEquality().hash(_unreadDmRooms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatListStateCopyWith<_$_ChatListState> get copyWith =>
      __$$_ChatListStateCopyWithImpl<_$_ChatListState>(this, _$identity);
}

abstract class _ChatListState implements ChatListState {
  const factory _ChatListState(
      {required final List<Room> channelRooms,
      required final List<Room> dmRooms,
      required final List<Room> unreadDmRooms}) = _$_ChatListState;

  @override
  List<Room> get channelRooms;
  @override
  List<Room> get dmRooms;
  @override
  List<Room> get unreadDmRooms;
  @override
  @JsonKey(ignore: true)
  _$$_ChatListStateCopyWith<_$_ChatListState> get copyWith =>
      throw _privateConstructorUsedError;
}
