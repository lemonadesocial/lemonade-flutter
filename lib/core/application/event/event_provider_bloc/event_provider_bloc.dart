import 'package:app/core/domain/event/entities/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventProviderBloc extends Bloc<EventProviderEvent, EventProviderState> {
  final Event event;

  EventProviderBloc({
    required this.event,
  }) : super(EventProviderState(event: event));
}

class EventProviderEvent {}

class EventProviderState {
  EventProviderState({
    required this.event,
  });

  final Event event;
}
