import 'package:flutter_bloc/flutter_bloc.dart';

class EventBuyAdditionalTicketsBloc extends Bloc<EventBuyAdditionalTicketsEvent,
    EventBuyAdditionalTicketsState> {
  late final bool _isBuyMore;
  EventBuyAdditionalTicketsBloc({
    bool? isBuyMore,
  })  : _isBuyMore = isBuyMore ?? false,
        super(
          EventBuyAdditionalTicketsState(),
        );

  bool get isBuyMore => _isBuyMore;
}

class EventBuyAdditionalTicketsEvent {}

class EventBuyAdditionalTicketsState {}
