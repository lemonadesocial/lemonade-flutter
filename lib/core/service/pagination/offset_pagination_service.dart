import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class OffsetPaginationService<T, I> {
  List<T> _items = [];
  int _offset = 0;

  Future<Either<Failure, List<T>>> Function(int offset)? getDataFuture;
  Stream<Either<Failure, List<T>>> Function(int offset)? getDataStream;

  OffsetPaginationService({this.getDataFuture, this.getDataStream});

  List<T> get items => _items;

  int get offset => _offset;

  Future<Either<Failure, List<T>>> fetch(I input) async {
    _items.clear();
    _offset = 0;
    return _processGetDataFuture(input);
  }

  Future<Either<Failure, List<T>>> refresh(I input) async {
    _items.clear();
    _offset = 0;
    return _processGetDataFuture(input);
  }

  Stream<Either<Failure, List<T>>> fetchStream(I input) {
    _items.clear();
    _offset = 0;
    return _processGetDataStream(input);
  }

  Stream<Either<Failure, List<T>>> refreshStream(I input) {
    _items.clear();
    _offset = 0;
    return _processGetDataStream(input);
  }

  Future<Either<Failure, List<T>>> _processGetDataFuture(I input) async {
    if (getDataFuture == null) throw Exception("getDataFuture is required");

    final result = await getDataFuture!.call(_offset);

    return result.fold(
      (failure) {
        return Left(Failure());
      },
      (newItems) => Right(_onReceiveNewItems(newItems)),
    );
  }

  Stream<Either<Failure, List<T>>> _processGetDataStream(I input) {
    if (getDataStream == null) throw Exception("getDataStream is required");

    return getDataStream!.call(_offset).asyncMap((streamEvent) {
      return streamEvent.fold(
        (failure) {
          return Left(Failure());
        },
        (newItems) => Right(_onReceiveNewItems(newItems)),
      );
    });
  }

  List<T> _onReceiveNewItems(List<T> newItems) {
    _items.addAll(newItems);
    _offset = _items.length;
    return _items;
  }
}