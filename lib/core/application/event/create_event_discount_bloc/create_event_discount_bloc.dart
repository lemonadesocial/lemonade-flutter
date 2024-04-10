import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_discount_bloc.freezed.dart';

class CreateEventDiscountBloc
    extends Bloc<CreateEventDiscountEvent, CreateEventDiscountState> {
  final EventPaymentTicketDiscount? discount;
  CreateEventDiscountBloc({
    this.discount,
  }) : super(
          _validate(
            CreateEventDiscountState(
              data: CreateEventDiscountData(
                code: discount?.code ?? '',
                ratio: discount?.ratio ?? 0.25,
                ticketLimit: discount?.ticketLimit ?? 25,
                ticketLimitPer: discount?.ticketLimitPer ?? 2,
              ),
              isValid: false,
            ),
          ),
        ) {
    on<_CreateEventDiscountEventOnCodeChanged>(_onCodeChanged);
    on<_CreateEventDiscountEventOnRatioChanged>(_onRatioChanged);
    on<_CreateEventDiscountEventOnTicketLimitChanged>(_onTicketLimitChanged);
    on<_CreateEventDiscountEventOnTicketLimitPerChanged>(
      _onTicketLimitPerChanged,
    );
  }

  void _onCodeChanged(
    _CreateEventDiscountEventOnCodeChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(code: event.code),
        ),
      ),
    );
  }

  void _onRatioChanged(
    _CreateEventDiscountEventOnRatioChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(ratio: event.ratio),
        ),
      ),
    );
  }

  void _onTicketLimitChanged(
    _CreateEventDiscountEventOnTicketLimitChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(ticketLimit: event.ticketLimit),
        ),
      ),
    );
  }

  void _onTicketLimitPerChanged(
    _CreateEventDiscountEventOnTicketLimitPerChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(ticketLimitPer: event.ticketLimitPer),
        ),
      ),
    );
  }
}

CreateEventDiscountState _validate(CreateEventDiscountState state) {
  final data = state.data;
  final hasCode = data.code?.isNotEmpty == true;
  final ratioValid = data.ratio != null && data.ratio! > 0 && data.ratio! <= 1;
  final ticketLimitValid = data.ticketLimit != null && data.ticketLimit! > 0;
  final ticketLimitPerValid =
      data.ticketLimitPer != null && data.ticketLimitPer! > 0;
  final isValid =
      hasCode && ratioValid && ticketLimitValid && ticketLimitPerValid;
  return state.copyWith(
    isValid: isValid,
  );
}

@freezed
class CreateEventDiscountEvent with _$CreateEventDiscountEvent {
  factory CreateEventDiscountEvent.onPopulate({
    EventPaymentTicketDiscount? discount,
  }) = _CreateEventDiscountEventOnPopulate;
  factory CreateEventDiscountEvent.onCodeChanged({
    String? code,
  }) = _CreateEventDiscountEventOnCodeChanged;
  factory CreateEventDiscountEvent.onRatioChanged({
    double? ratio,
  }) = _CreateEventDiscountEventOnRatioChanged;
  factory CreateEventDiscountEvent.onTicketLimitChanged({
    double? ticketLimit,
  }) = _CreateEventDiscountEventOnTicketLimitChanged;
  factory CreateEventDiscountEvent.onTicketLimitPerChanged({
    double? ticketLimitPer,
  }) = _CreateEventDiscountEventOnTicketLimitPerChanged;
}

@freezed
class CreateEventDiscountState with _$CreateEventDiscountState {
  factory CreateEventDiscountState({
    required CreateEventDiscountData data,
    required bool isValid,
  }) = _CreateEventDiscountState;
}

@freezed
class CreateEventDiscountData with _$CreateEventDiscountData {
  factory CreateEventDiscountData({
    String? code,
    double? ratio,
    double? ticketLimit,
    double? ticketLimitPer,
  }) = _CreateEventDiscountData;
}
