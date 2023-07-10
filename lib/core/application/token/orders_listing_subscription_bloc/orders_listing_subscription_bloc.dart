import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_listing_subscription_bloc.freezed.dart';

class OrdersListingSubscriptionBloc extends Bloc<OrdersListingSubscriptionEvent, OrdersListingSubscriptionState> {
  final TokenService tokenService;
  late final PaginationService<OrderComplex, WatchOrdersInput> paginationService =
      PaginationService(getDataStream: _watchOrders);

  final WatchOrdersInput defaultInput;

  OrdersListingSubscriptionBloc(
    this.tokenService, {
    required this.defaultInput,
  }) : super(OrdersListingSubscriptionState.loading()) {
    on<OrdersListingSubscriptionEventStart>(_onStartSubscription);
  }

  Stream<Either<Failure, List<OrderComplex>>> _watchOrders(
    int skip,
    bool endReached, {
    required WatchOrdersInput input,
  }) {
    return tokenService.watchOrders(input: input.copyWith(skip: skip));
  }

  _onStartSubscription(OrdersListingSubscriptionEventStart event, Emitter emit) async {
    await emit.forEach(paginationService.fetchStream(defaultInput), onData: (streamEvent) {
      return streamEvent.fold(
        (l) {
          return OrdersListingSubscriptionState.failure();
        },
        (orders) {
          return OrdersListingSubscriptionState.fetched(orders: orders);
        },
      );
    });
  }
}

@freezed
class OrdersListingSubscriptionEvent with _$OrdersListingSubscriptionEvent {
  const factory OrdersListingSubscriptionEvent.start({WatchOrdersInput? input}) = OrdersListingSubscriptionEventStart;
}

@freezed
class OrdersListingSubscriptionState with _$OrdersListingSubscriptionState {
  const factory OrdersListingSubscriptionState.loading() = OrdersListingSubscriptionStateLoading;
  const factory OrdersListingSubscriptionState.fetched({
    required List<OrderComplex> orders,
  }) = OrdersListingSubscriptionStateFetched;
  const factory OrdersListingSubscriptionState.failure() = OrdersListingSubscriptionStateFailure;
}
