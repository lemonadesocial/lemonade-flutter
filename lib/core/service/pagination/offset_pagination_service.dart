import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class OffsetPaginationService<T, I> {

  OffsetPaginationService({this.getDataFuture, this.getDataStream});
  List<T> _items = [];
  bool _reachedEnd = false;
  int? _offset = 0;

  Future<Either<Failure, List<T>>> Function(int? offset, bool reachedEnd,
      {required I input,})? getDataFuture;
  Stream<Either<Failure, List<T>>> Function(int? offset, bool reachedEnd,
      {required I input,})? getDataStream;

  List<T> get items => _items;

  int? get offset => _offset;

  bool get reachedEnd => _reachedEnd;

  Future<Either<Failure, List<T>>> fetch(I input) async {
    return _processGetDataFuture(input);
  }

  Future<Either<Failure, List<T>>> refresh(I input) async {
    _reachedEnd = false;
    _offset = 0;
    return _processGetDataFuture(input);
  }

  Stream<Either<Failure, List<T>>> fetchStream(I input) {
    return _processGetDataStream(input);
  }

  Stream<Either<Failure, List<T>>> refreshStream(I input) {
    _reachedEnd = false;
    _offset = 0;
    return _processGetDataStream(input);
  }

  Future<Either<Failure, List<T>>> _processGetDataFuture(I input) async {
    if (getDataFuture == null) throw Exception('getDataFuture is required');

    if (reachedEnd) {
      return Right(_items);
    }

    final result = await getDataFuture!.call(offset, reachedEnd, input: input);

    return result.fold(
      (failure) {
        return Left(Failure());
      },
      (newItems) => Right(_onReceiveNewItems(newItems)),
    );
  }

  Stream<Either<Failure, List<T>>> _processGetDataStream(I input) {
    if (getDataStream == null) throw Exception('getDataStream is required');

    return getDataStream!
        .call(offset, reachedEnd, input: input)
        .asyncMap((streamEvent) {
      if (reachedEnd) {
        return Right(_items);
      }

      return streamEvent.fold(
        (failure) {
          return Left(Failure());
        },
        (newItems) {
          return Right(_onReceiveNewItems(newItems));
        },
      );
    });
  }

  List<T> _onReceiveNewItems(List<T> newItems) {
    if (newItems.isEmpty) {
      _reachedEnd = true;
    }
    _items = [..._items, ...newItems];
    return _items;
  }

  updateOffset(int? offset) {
    _offset = offset;
  }
}
