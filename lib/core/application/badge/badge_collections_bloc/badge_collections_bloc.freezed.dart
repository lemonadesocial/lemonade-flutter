// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_collections_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BadgeCollectionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeList collection) select,
    required TResult Function(BadgeList collection) deselect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeList collection)? select,
    TResult? Function(BadgeList collection)? deselect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeList collection)? select,
    TResult Function(BadgeList collection)? deselect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeCollectionsEventFetch value) fetch,
    required TResult Function(BadgeCollectionsEventSelect value) select,
    required TResult Function(BadgeCollectionsEventDeselect value) deselect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsEventFetch value)? fetch,
    TResult? Function(BadgeCollectionsEventSelect value)? select,
    TResult? Function(BadgeCollectionsEventDeselect value)? deselect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsEventFetch value)? fetch,
    TResult Function(BadgeCollectionsEventSelect value)? select,
    TResult Function(BadgeCollectionsEventDeselect value)? deselect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCollectionsEventCopyWith<$Res> {
  factory $BadgeCollectionsEventCopyWith(BadgeCollectionsEvent value,
          $Res Function(BadgeCollectionsEvent) then) =
      _$BadgeCollectionsEventCopyWithImpl<$Res, BadgeCollectionsEvent>;
}

/// @nodoc
class _$BadgeCollectionsEventCopyWithImpl<$Res,
        $Val extends BadgeCollectionsEvent>
    implements $BadgeCollectionsEventCopyWith<$Res> {
  _$BadgeCollectionsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgeCollectionsEventFetchCopyWith<$Res> {
  factory _$$BadgeCollectionsEventFetchCopyWith(
          _$BadgeCollectionsEventFetch value,
          $Res Function(_$BadgeCollectionsEventFetch) then) =
      __$$BadgeCollectionsEventFetchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeCollectionsEventFetchCopyWithImpl<$Res>
    extends _$BadgeCollectionsEventCopyWithImpl<$Res,
        _$BadgeCollectionsEventFetch>
    implements _$$BadgeCollectionsEventFetchCopyWith<$Res> {
  __$$BadgeCollectionsEventFetchCopyWithImpl(
      _$BadgeCollectionsEventFetch _value,
      $Res Function(_$BadgeCollectionsEventFetch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeCollectionsEventFetch implements BadgeCollectionsEventFetch {
  _$BadgeCollectionsEventFetch();

  @override
  String toString() {
    return 'BadgeCollectionsEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsEventFetch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeList collection) select,
    required TResult Function(BadgeList collection) deselect,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeList collection)? select,
    TResult? Function(BadgeList collection)? deselect,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeList collection)? select,
    TResult Function(BadgeList collection)? deselect,
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
    required TResult Function(BadgeCollectionsEventFetch value) fetch,
    required TResult Function(BadgeCollectionsEventSelect value) select,
    required TResult Function(BadgeCollectionsEventDeselect value) deselect,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsEventFetch value)? fetch,
    TResult? Function(BadgeCollectionsEventSelect value)? select,
    TResult? Function(BadgeCollectionsEventDeselect value)? deselect,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsEventFetch value)? fetch,
    TResult Function(BadgeCollectionsEventSelect value)? select,
    TResult Function(BadgeCollectionsEventDeselect value)? deselect,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsEventFetch implements BadgeCollectionsEvent {
  factory BadgeCollectionsEventFetch() = _$BadgeCollectionsEventFetch;
}

/// @nodoc
abstract class _$$BadgeCollectionsEventSelectCopyWith<$Res> {
  factory _$$BadgeCollectionsEventSelectCopyWith(
          _$BadgeCollectionsEventSelect value,
          $Res Function(_$BadgeCollectionsEventSelect) then) =
      __$$BadgeCollectionsEventSelectCopyWithImpl<$Res>;
  @useResult
  $Res call({BadgeList collection});
}

/// @nodoc
class __$$BadgeCollectionsEventSelectCopyWithImpl<$Res>
    extends _$BadgeCollectionsEventCopyWithImpl<$Res,
        _$BadgeCollectionsEventSelect>
    implements _$$BadgeCollectionsEventSelectCopyWith<$Res> {
  __$$BadgeCollectionsEventSelectCopyWithImpl(
      _$BadgeCollectionsEventSelect _value,
      $Res Function(_$BadgeCollectionsEventSelect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
  }) {
    return _then(_$BadgeCollectionsEventSelect(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as BadgeList,
    ));
  }
}

/// @nodoc

class _$BadgeCollectionsEventSelect implements BadgeCollectionsEventSelect {
  _$BadgeCollectionsEventSelect({required this.collection});

  @override
  final BadgeList collection;

  @override
  String toString() {
    return 'BadgeCollectionsEvent.select(collection: $collection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsEventSelect &&
            (identical(other.collection, collection) ||
                other.collection == collection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, collection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeCollectionsEventSelectCopyWith<_$BadgeCollectionsEventSelect>
      get copyWith => __$$BadgeCollectionsEventSelectCopyWithImpl<
          _$BadgeCollectionsEventSelect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeList collection) select,
    required TResult Function(BadgeList collection) deselect,
  }) {
    return select(collection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeList collection)? select,
    TResult? Function(BadgeList collection)? deselect,
  }) {
    return select?.call(collection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeList collection)? select,
    TResult Function(BadgeList collection)? deselect,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(collection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeCollectionsEventFetch value) fetch,
    required TResult Function(BadgeCollectionsEventSelect value) select,
    required TResult Function(BadgeCollectionsEventDeselect value) deselect,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsEventFetch value)? fetch,
    TResult? Function(BadgeCollectionsEventSelect value)? select,
    TResult? Function(BadgeCollectionsEventDeselect value)? deselect,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsEventFetch value)? fetch,
    TResult Function(BadgeCollectionsEventSelect value)? select,
    TResult Function(BadgeCollectionsEventDeselect value)? deselect,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsEventSelect implements BadgeCollectionsEvent {
  factory BadgeCollectionsEventSelect({required final BadgeList collection}) =
      _$BadgeCollectionsEventSelect;

  BadgeList get collection;
  @JsonKey(ignore: true)
  _$$BadgeCollectionsEventSelectCopyWith<_$BadgeCollectionsEventSelect>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgeCollectionsEventDeselectCopyWith<$Res> {
  factory _$$BadgeCollectionsEventDeselectCopyWith(
          _$BadgeCollectionsEventDeselect value,
          $Res Function(_$BadgeCollectionsEventDeselect) then) =
      __$$BadgeCollectionsEventDeselectCopyWithImpl<$Res>;
  @useResult
  $Res call({BadgeList collection});
}

/// @nodoc
class __$$BadgeCollectionsEventDeselectCopyWithImpl<$Res>
    extends _$BadgeCollectionsEventCopyWithImpl<$Res,
        _$BadgeCollectionsEventDeselect>
    implements _$$BadgeCollectionsEventDeselectCopyWith<$Res> {
  __$$BadgeCollectionsEventDeselectCopyWithImpl(
      _$BadgeCollectionsEventDeselect _value,
      $Res Function(_$BadgeCollectionsEventDeselect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
  }) {
    return _then(_$BadgeCollectionsEventDeselect(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as BadgeList,
    ));
  }
}

/// @nodoc

class _$BadgeCollectionsEventDeselect implements BadgeCollectionsEventDeselect {
  _$BadgeCollectionsEventDeselect({required this.collection});

  @override
  final BadgeList collection;

  @override
  String toString() {
    return 'BadgeCollectionsEvent.deselect(collection: $collection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsEventDeselect &&
            (identical(other.collection, collection) ||
                other.collection == collection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, collection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeCollectionsEventDeselectCopyWith<_$BadgeCollectionsEventDeselect>
      get copyWith => __$$BadgeCollectionsEventDeselectCopyWithImpl<
          _$BadgeCollectionsEventDeselect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeList collection) select,
    required TResult Function(BadgeList collection) deselect,
  }) {
    return deselect(collection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeList collection)? select,
    TResult? Function(BadgeList collection)? deselect,
  }) {
    return deselect?.call(collection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeList collection)? select,
    TResult Function(BadgeList collection)? deselect,
    required TResult orElse(),
  }) {
    if (deselect != null) {
      return deselect(collection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeCollectionsEventFetch value) fetch,
    required TResult Function(BadgeCollectionsEventSelect value) select,
    required TResult Function(BadgeCollectionsEventDeselect value) deselect,
  }) {
    return deselect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsEventFetch value)? fetch,
    TResult? Function(BadgeCollectionsEventSelect value)? select,
    TResult? Function(BadgeCollectionsEventDeselect value)? deselect,
  }) {
    return deselect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsEventFetch value)? fetch,
    TResult Function(BadgeCollectionsEventSelect value)? select,
    TResult Function(BadgeCollectionsEventDeselect value)? deselect,
    required TResult orElse(),
  }) {
    if (deselect != null) {
      return deselect(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsEventDeselect implements BadgeCollectionsEvent {
  factory BadgeCollectionsEventDeselect({required final BadgeList collection}) =
      _$BadgeCollectionsEventDeselect;

  BadgeList get collection;
  @JsonKey(ignore: true)
  _$$BadgeCollectionsEventDeselectCopyWith<_$BadgeCollectionsEventDeselect>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BadgeCollectionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)
        fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeCollectionsStateInitial value) initial,
    required TResult Function(BadgeCollectionsStateFetched value) fetched,
    required TResult Function(BadgeCollectionsStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsStateInitial value)? initial,
    TResult? Function(BadgeCollectionsStateFetched value)? fetched,
    TResult? Function(BadgeCollectionsStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsStateInitial value)? initial,
    TResult Function(BadgeCollectionsStateFetched value)? fetched,
    TResult Function(BadgeCollectionsStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCollectionsStateCopyWith<$Res> {
  factory $BadgeCollectionsStateCopyWith(BadgeCollectionsState value,
          $Res Function(BadgeCollectionsState) then) =
      _$BadgeCollectionsStateCopyWithImpl<$Res, BadgeCollectionsState>;
}

/// @nodoc
class _$BadgeCollectionsStateCopyWithImpl<$Res,
        $Val extends BadgeCollectionsState>
    implements $BadgeCollectionsStateCopyWith<$Res> {
  _$BadgeCollectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgeCollectionsStateInitialCopyWith<$Res> {
  factory _$$BadgeCollectionsStateInitialCopyWith(
          _$BadgeCollectionsStateInitial value,
          $Res Function(_$BadgeCollectionsStateInitial) then) =
      __$$BadgeCollectionsStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeCollectionsStateInitialCopyWithImpl<$Res>
    extends _$BadgeCollectionsStateCopyWithImpl<$Res,
        _$BadgeCollectionsStateInitial>
    implements _$$BadgeCollectionsStateInitialCopyWith<$Res> {
  __$$BadgeCollectionsStateInitialCopyWithImpl(
      _$BadgeCollectionsStateInitial _value,
      $Res Function(_$BadgeCollectionsStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeCollectionsStateInitial implements BadgeCollectionsStateInitial {
  _$BadgeCollectionsStateInitial();

  @override
  String toString() {
    return 'BadgeCollectionsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)
        fetched,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult Function()? failure,
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
    required TResult Function(BadgeCollectionsStateInitial value) initial,
    required TResult Function(BadgeCollectionsStateFetched value) fetched,
    required TResult Function(BadgeCollectionsStateFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsStateInitial value)? initial,
    TResult? Function(BadgeCollectionsStateFetched value)? fetched,
    TResult? Function(BadgeCollectionsStateFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsStateInitial value)? initial,
    TResult Function(BadgeCollectionsStateFetched value)? fetched,
    TResult Function(BadgeCollectionsStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsStateInitial implements BadgeCollectionsState {
  factory BadgeCollectionsStateInitial() = _$BadgeCollectionsStateInitial;
}

/// @nodoc
abstract class _$$BadgeCollectionsStateFetchedCopyWith<$Res> {
  factory _$$BadgeCollectionsStateFetchedCopyWith(
          _$BadgeCollectionsStateFetched value,
          $Res Function(_$BadgeCollectionsStateFetched) then) =
      __$$BadgeCollectionsStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BadgeList> collections, List<BadgeList> selectedCollections});
}

/// @nodoc
class __$$BadgeCollectionsStateFetchedCopyWithImpl<$Res>
    extends _$BadgeCollectionsStateCopyWithImpl<$Res,
        _$BadgeCollectionsStateFetched>
    implements _$$BadgeCollectionsStateFetchedCopyWith<$Res> {
  __$$BadgeCollectionsStateFetchedCopyWithImpl(
      _$BadgeCollectionsStateFetched _value,
      $Res Function(_$BadgeCollectionsStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collections = null,
    Object? selectedCollections = null,
  }) {
    return _then(_$BadgeCollectionsStateFetched(
      collections: null == collections
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<BadgeList>,
      selectedCollections: null == selectedCollections
          ? _value._selectedCollections
          : selectedCollections // ignore: cast_nullable_to_non_nullable
              as List<BadgeList>,
    ));
  }
}

/// @nodoc

class _$BadgeCollectionsStateFetched implements BadgeCollectionsStateFetched {
  _$BadgeCollectionsStateFetched(
      {required final List<BadgeList> collections,
      required final List<BadgeList> selectedCollections})
      : _collections = collections,
        _selectedCollections = selectedCollections;

  final List<BadgeList> _collections;
  @override
  List<BadgeList> get collections {
    if (_collections is EqualUnmodifiableListView) return _collections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collections);
  }

  final List<BadgeList> _selectedCollections;
  @override
  List<BadgeList> get selectedCollections {
    if (_selectedCollections is EqualUnmodifiableListView)
      return _selectedCollections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCollections);
  }

  @override
  String toString() {
    return 'BadgeCollectionsState.fetched(collections: $collections, selectedCollections: $selectedCollections)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsStateFetched &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections) &&
            const DeepCollectionEquality()
                .equals(other._selectedCollections, _selectedCollections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_collections),
      const DeepCollectionEquality().hash(_selectedCollections));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeCollectionsStateFetchedCopyWith<_$BadgeCollectionsStateFetched>
      get copyWith => __$$BadgeCollectionsStateFetchedCopyWithImpl<
          _$BadgeCollectionsStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)
        fetched,
    required TResult Function() failure,
  }) {
    return fetched(collections, selectedCollections);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(collections, selectedCollections);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(collections, selectedCollections);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeCollectionsStateInitial value) initial,
    required TResult Function(BadgeCollectionsStateFetched value) fetched,
    required TResult Function(BadgeCollectionsStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsStateInitial value)? initial,
    TResult? Function(BadgeCollectionsStateFetched value)? fetched,
    TResult? Function(BadgeCollectionsStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsStateInitial value)? initial,
    TResult Function(BadgeCollectionsStateFetched value)? fetched,
    TResult Function(BadgeCollectionsStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsStateFetched implements BadgeCollectionsState {
  factory BadgeCollectionsStateFetched(
          {required final List<BadgeList> collections,
          required final List<BadgeList> selectedCollections}) =
      _$BadgeCollectionsStateFetched;

  List<BadgeList> get collections;
  List<BadgeList> get selectedCollections;
  @JsonKey(ignore: true)
  _$$BadgeCollectionsStateFetchedCopyWith<_$BadgeCollectionsStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgeCollectionsStateFailureCopyWith<$Res> {
  factory _$$BadgeCollectionsStateFailureCopyWith(
          _$BadgeCollectionsStateFailure value,
          $Res Function(_$BadgeCollectionsStateFailure) then) =
      __$$BadgeCollectionsStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeCollectionsStateFailureCopyWithImpl<$Res>
    extends _$BadgeCollectionsStateCopyWithImpl<$Res,
        _$BadgeCollectionsStateFailure>
    implements _$$BadgeCollectionsStateFailureCopyWith<$Res> {
  __$$BadgeCollectionsStateFailureCopyWithImpl(
      _$BadgeCollectionsStateFailure _value,
      $Res Function(_$BadgeCollectionsStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeCollectionsStateFailure implements BadgeCollectionsStateFailure {
  _$BadgeCollectionsStateFailure();

  @override
  String toString() {
    return 'BadgeCollectionsState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCollectionsStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)
        fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<BadgeList> collections, List<BadgeList> selectedCollections)?
        fetched,
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
    required TResult Function(BadgeCollectionsStateInitial value) initial,
    required TResult Function(BadgeCollectionsStateFetched value) fetched,
    required TResult Function(BadgeCollectionsStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeCollectionsStateInitial value)? initial,
    TResult? Function(BadgeCollectionsStateFetched value)? fetched,
    TResult? Function(BadgeCollectionsStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeCollectionsStateInitial value)? initial,
    TResult Function(BadgeCollectionsStateFetched value)? fetched,
    TResult Function(BadgeCollectionsStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BadgeCollectionsStateFailure implements BadgeCollectionsState {
  factory BadgeCollectionsStateFailure() = _$BadgeCollectionsStateFailure;
}
