import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/domain/event/input/get_event_payments_input/get_event_payments_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventPaymentRepository {
  Future<Either<Failure, List<EventPayment>>> getEventPayments({
    required GetEventPaymentsInput input,
  });
}
