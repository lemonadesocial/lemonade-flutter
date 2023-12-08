import 'package:app/core/service/vault/vault_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_vault_pin_bloc.freezed.dart';

class CheckVaultPinBloc extends Bloc<CheckVaultPinEvent, CheckVaultPinState> {
  final String userId;

  CheckVaultPinBloc({required this.userId})
      : super(CheckVaultPinState.checking()) {
    on<CheckVaultPinEventInitialize>(_onInitialize);
  }

  Future<void> _onInitialize(
    CheckVaultPinEventInitialize event,
    Emitter emit,
  ) async {
    emit(CheckVaultPinState.checking());
    final pinCode = await VaultSecureStorage.getPinCode(userId);
    if (pinCode?.isNotEmpty == true) {
      return emit(CheckVaultPinState.pinRequired(correctPin: pinCode!));
    }
    emit(CheckVaultPinState.noPin());
  }
}

@freezed
class CheckVaultPinEvent with _$CheckVaultPinEvent {
  factory CheckVaultPinEvent.initialize() = CheckVaultPinEventInitialize;
}

@freezed
class CheckVaultPinState with _$CheckVaultPinState {
  factory CheckVaultPinState.checking() = CheckVaultPinStateChecking;
  factory CheckVaultPinState.noPin() = CheckVaultPinStateNoPin;
  factory CheckVaultPinState.pinRequired({
    required String correctPin,
  }) = CheckVaultPinStatePinRequired;
}
