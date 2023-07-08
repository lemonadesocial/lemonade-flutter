
import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_listing_subscription_bloc.freezed.dart';

class OrdersListingSubscriptionBloc extends Bloc<OrdersListingSubscriptionEvent, OrdersListingSubscriptionState> {
  final TokenService tokenService;
  OrdersListingSubscriptionBloc(this.tokenService) : super(OrdersListingSubscriptionState.loading()) {
    on<OrdersListingSubscriptionEventStart>(_onStartSubscription);
  }

  _onStartSubscription(OrdersListingSubscriptionEventStart event, Emitter emit) async {
    await emit.forEach(tokenService.watchOrders(input: event.input), onData: (streamEvent) {
      return streamEvent.fold(
        (l) {
          return OrdersListingSubscriptionState.failure();
        },
        (queryResult) {
          return OrdersListingSubscriptionState.fetched(orders: queryResult.parsedData ?? []);
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
