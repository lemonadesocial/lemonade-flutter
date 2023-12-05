import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_payment_account_bloc.freezed.dart';

class CreatePaymentAccountBloc
    extends Bloc<CreatePaymentAccountEvent, CreatePaymentAccountState> {
  final _paymentRepository = getIt<PaymentRepository>();
  CreatePaymentAccountBloc() : super(CreatePaymentAccountState.idle()) {
    on<StartCreatePaymentAccount>(_onCreate);
  }

  void _onCreate(StartCreatePaymentAccount event, Emitter emit) async {
    emit(CreatePaymentAccountState.loading());
    final result =
        await _paymentRepository.createPaymentAccount(input: event.input);
    result.fold(
      (l) => emit(CreatePaymentAccountState.failure()),
      (paymentAccount) => emit(
        CreatePaymentAccountState.success(
          paymentAccount: paymentAccount,
        ),
      ),
    );
  }
}

@freezed
class CreatePaymentAccountEvent with _$CreatePaymentAccountEvent {
  factory CreatePaymentAccountEvent.create({
    required CreatePaymentAccountInput input,
  }) = StartCreatePaymentAccount;
}

@freezed
class CreatePaymentAccountState with _$CreatePaymentAccountState {
  factory CreatePaymentAccountState.idle() = CreatePaymentAccountStateInitial;
  factory CreatePaymentAccountState.loading() =
      CreatePaymentAccountStateLoading;
  factory CreatePaymentAccountState.success({
    required PaymentAccount paymentAccount,
  }) = CreatePaymentAccountStateSuccess;
  factory CreatePaymentAccountState.failure() =
      CreatePaymentAccountStateFailure;
}
