import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_new_card_state.dart';

part 'add_new_card_bloc.freezed.dart';

class AddNewCardBloc extends Cubit<AddNewCardState> {
  AddNewCardBloc(this._paymentRepository) : super(AddNewCardState.initial());

  final PaymentRepository _paymentRepository;

  void onCardHolderNameChange(String? value) {
    emit(state.copyWith(cardHolderName: value));
  }

  void onCardNumberChange(String? value) {
    emit(state.copyWith(cardNumber: value));
  }

  void onValidDateChange(String? value) {
    emit(state.copyWith(validThrough: value));
  }

  void onCvvChange(String? value) {
    emit(state.copyWith(cvv: value));
  }

  Future<void> addNewCard() async {
    emit(state.copyWith(status: AddNewCardBlocStatus.loading));
    final result = await _paymentRepository.createNewCard();
    result.fold(
      (l) => emit(state.copyWith(status: AddNewCardBlocStatus.error)),
      (createSuccess) {
        if (createSuccess) {
          emit(state.copyWith(status: AddNewCardBlocStatus.success));
        } else {
          emit(state.copyWith(status: AddNewCardBlocStatus.error));
        }
      },
    );
  }
}
