import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_listing_subscription_bloc.freezed.dart';

class OrdersListingSubscriptionBloc extends Bloc<OrdersListingSubscriptionEvent,
    OrdersListingSubscriptionState> {
  final TokenService tokenService;
  late final PaginationService<OrderComplex, WatchOrdersInput>
      paginationService = PaginationService(getDataStream: _watchOrders);

  final WatchOrdersInput defaultInput;

  OrdersListingSubscriptionBloc(
    this.tokenService, {
    required this.defaultInput,
  }) : super(const OrdersListingSubscriptionState.loading()) {
    on<OrdersListingSubscriptionEventStart>(_onStartSubscription);
    on<OrdersListingSubscriptionEventFetchComplete>(_onFetchComplete);
  }

  Stream<Either<Failure, List<OrderComplex>>> _watchOrders(
    int skip,
    bool endReached, {
    required WatchOrdersInput input,
  }) {
    return tokenService.watchOrders(input: input.copyWith(skip: skip));
  }

  Future<void> _onStartSubscription(
    OrdersListingSubscriptionEventStart event,
    Emitter emit,
  ) async {
    final result = paginationService.fetchStream(defaultInput);
    result.listen((streamEvent) {
      return streamEvent.fold(
        (l) => const OrdersListingSubscriptionState.failure(),
        (orders) async {
          final mediaList = <Media>[];
          await Future.forEach<OrderComplex>(orders, (order) async {
            await MediaUtils.getNftMedia(
              order.token.metadata?.image,
              order.token.metadata?.animation_url,
            ).then((media) => mediaList.add(media));
          }).whenComplete(
            () => add(
              OrdersListingSubscriptionEvent.fetchComplete(
                mediaList: mediaList,
              ),
            ),
          );
        },
      );
    });
  }

  void _onFetchComplete(
    OrdersListingSubscriptionEventFetchComplete event,
    Emitter emit,
  ) {
    emit(OrdersListingSubscriptionState.fetched(mediaList: event.mediaList));
  }
}

@freezed
class OrdersListingSubscriptionEvent with _$OrdersListingSubscriptionEvent {
  const factory OrdersListingSubscriptionEvent.start({
    WatchOrdersInput? input,
  }) = OrdersListingSubscriptionEventStart;

  const factory OrdersListingSubscriptionEvent.fetchComplete({
    required List<Media> mediaList,
  }) = OrdersListingSubscriptionEventFetchComplete;
}

@freezed
class OrdersListingSubscriptionState with _$OrdersListingSubscriptionState {
  const factory OrdersListingSubscriptionState.loading() =
      OrdersListingSubscriptionStateLoading;

  const factory OrdersListingSubscriptionState.fetched({
    required List<Media> mediaList,
  }) = OrdersListingSubscriptionStateFetched;

  const factory OrdersListingSubscriptionState.failure() =
      OrdersListingSubscriptionStateFailure;
}
