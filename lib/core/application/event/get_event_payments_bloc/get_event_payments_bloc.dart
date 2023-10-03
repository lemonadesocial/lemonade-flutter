import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/domain/event/input/get_event_payments_input/get_event_payments_input.dart';
import 'package:app/core/domain/event/repository/event_payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_payments_bloc.freezed.dart';

class GetEventPaymentsBloc
    extends Bloc<GetEventPaymentsEvent, GetEventPaymentsState> {
  final _eventPaymentRepository = getIt<EventPaymentRepository>();

  GetEventPaymentsBloc() : super(GetEventPaymentsState.loading()) {
    on<GetEventPaymentsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(GetEventPaymentsEventFetch event, Emitter emit) async {
    final result = await _eventPaymentRepository.getEventPayments(
      input: event.input,
    );
    result.fold(
      (l) => emit(GetEventPaymentsState.failure()),
      (data) => emit(
        GetEventPaymentsState.success(eventPayments: data),
      ),
    );
  }
}

@freezed
class GetEventPaymentsEvent with _$GetEventPaymentsEvent {
  factory GetEventPaymentsEvent.fetch({
    required GetEventPaymentsInput input,
  }) = GetEventPaymentsEventFetch;
}

@freezed
class GetEventPaymentsState with _$GetEventPaymentsState {
  factory GetEventPaymentsState.loading() = GetEventPaymentsStateLoading;
  factory GetEventPaymentsState.success({
    required List<EventPayment> eventPayments,
  }) = GetEventPaymentsStateSuccess;
  factory GetEventPaymentsState.failure() = GetEventPaymentsStateFailure;
}
