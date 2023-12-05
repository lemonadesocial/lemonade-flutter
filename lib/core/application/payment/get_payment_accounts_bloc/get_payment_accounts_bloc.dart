import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_accounts_bloc.freezed.dart';

class GetPaymentAccountsBloc
    extends Bloc<GetPaymentAccountsEvent, GetPaymentAccountsState> {
  final _paymentRepository = getIt<PaymentRepository>();
  GetPaymentAccountsBloc() : super(GetPaymentAccountsState.initial()) {
    on<GetPaymentAccountsEventFetch>(_onFetch);
  }

  void _onFetch(GetPaymentAccountsEventFetch event, Emitter emit) async {
    emit(GetPaymentAccountsState.loading());
    final result =
        await _paymentRepository.getPaymentAccounts(input: event.input);
    result.fold(
      (failure) => emit(GetPaymentAccountsState.failure()),
      (paymentAccounts) => emit(
        GetPaymentAccountsState.success(
          paymentAccounts: paymentAccounts,
        ),
      ),
    );
  }
}

@freezed
class GetPaymentAccountsEvent with _$GetPaymentAccountsEvent {
  factory GetPaymentAccountsEvent.fetch({
    required GetPaymentAccountsInput input,
  }) = GetPaymentAccountsEventFetch;
}

@freezed
class GetPaymentAccountsState with _$GetPaymentAccountsState {
  factory GetPaymentAccountsState.initial() = GetPaymentAccountsStateInitial;
  factory GetPaymentAccountsState.loading() = GetPaymentAccountsStateLoading;
  factory GetPaymentAccountsState.success({
    required List<PaymentAccount> paymentAccounts,
  }) = GetPaymentAccountsStateSuccess;
  factory GetPaymentAccountsState.failure() = GetPaymentAccountsStateFailure;
}
