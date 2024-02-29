import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_event_tickets_pricing_bloc.freezed.dart';

class CalculateEventTicketPricingBloc extends Bloc<
    CalculateEventTicketPricingEvent, CalculateEventTicketPricingState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  EventTicketsPricingInfo? _currentPricingInfo;
  String? promoCode;

  CalculateEventTicketPricingBloc()
      : super(CalculateEventTicketPricingState.idle()) {
    on<StartCalculateTicketsPricing>(_onCalculatePricing);
  }

  Future<void> _onCalculatePricing(
    StartCalculateTicketsPricing event,
    Emitter emit,
  ) async {
    emit(CalculateEventTicketPricingState.loading());
    final result = await eventTicketRepository.calculateTicketsPricing(
      input: event.input,
    );

    result.fold((l) {
      emit(
        CalculateEventTicketPricingState.failure(
          pricingInfo: _currentPricingInfo,
          isFree: false,
        ),
      );
    }, (pricingInfo) {
      _currentPricingInfo = pricingInfo.copyWith(
        promoCode: event.input.discount,
      );
      final isFree = _currentPricingInfo?.total != null
          ? BigInt.parse(_currentPricingInfo!.total!) == BigInt.zero
          : false;
      emit(
        CalculateEventTicketPricingState.success(
          pricingInfo: _currentPricingInfo!,
          isFree: isFree,
        ),
      );
    });
  }
}

@freezed
class CalculateEventTicketPricingEvent with _$CalculateEventTicketPricingEvent {
  factory CalculateEventTicketPricingEvent.calculate({
    required CalculateTicketsPricingInput input,
  }) = StartCalculateTicketsPricing;
}

@freezed
class CalculateEventTicketPricingState with _$CalculateEventTicketPricingState {
  factory CalculateEventTicketPricingState.idle() =
      CalculateTicketsPricingStateIdle;
  factory CalculateEventTicketPricingState.loading() =
      CalculateTicketsPricingStateLoading;
  factory CalculateEventTicketPricingState.success({
    required EventTicketsPricingInfo pricingInfo,
    required bool isFree,
  }) = CalculateTicketsPricingStateSuccess;
  factory CalculateEventTicketPricingState.failure({
    EventTicketsPricingInfo? pricingInfo,
    required bool isFree,
  }) = CalculateTicketsPricingStateFailure;
}
