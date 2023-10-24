import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_bloc.freezed.dart';

part 'payment_state.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc(this._repository) : super(PaymentState.initial());

  final PaymentRepository _repository;

  Future<void> initializeStripePayment() async {
    final result = _repository.getPublishableKey();
  }
}
