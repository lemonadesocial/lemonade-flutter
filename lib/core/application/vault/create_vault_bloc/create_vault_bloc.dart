import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_vault_bloc.freezed.dart';

class CreateVaultBloc extends Bloc<CreateVaultEvent, CreateVaultState> {
  CreateVaultBloc()
      : super(
          CreateVaultState(
            isValid: false,
            data: CreateVaultData(),
          ),
        ) {
    on<CreateVaultEventOnVaultNameChanged>(_onVaultNameChanged);
    on<CreateVaultEventOnVaultChainSelected>(_onChainSelected);
    on<CreateVaultEventOnVaultOnOwnersChanged>(_onOwnersChanged);
    on<CreateVaultEventOnVaultOnThresholdChanged>(_onThresholdChanged);
  }

  void _onVaultNameChanged(
    CreateVaultEventOnVaultNameChanged event,
    Emitter emit,
  ) {
    final data = state.data.copyWith(
      vaultName: event.vaultName,
    );
    emit(
      state.copyWith(
        data: data,
        isValid: _validateVaultData(data),
      ),
    );
  }

  void _onChainSelected(
    CreateVaultEventOnVaultChainSelected event,
    Emitter emit,
  ) {
    final data = state.data.copyWith(
      selectedChain: event.selectedChain,
    );
    emit(
      state.copyWith(
        data: data,
        isValid: _validateVaultData(data),
      ),
    );
  }

  void _onOwnersChanged(
    CreateVaultEventOnVaultOnOwnersChanged event,
    Emitter emit,
  ) {
    final data = state.data.copyWith(
      owners: event.owners,
    );
    emit(
      state.copyWith(
        data: data,
        isValid: _validateVaultData(data),
      ),
    );
  }

  void _onThresholdChanged(
    CreateVaultEventOnVaultOnThresholdChanged event,
    Emitter emit,
  ) {
    final data = state.data.copyWith(
      threshold: event.threshold,
    );
    emit(
      state.copyWith(
        data: data,
        isValid: _validateVaultData(data),
      ),
    );
  }

  bool _validateVaultData(CreateVaultData data) {
    return (data.vaultName?.trim().isNotEmpty == true &&
        data.selectedChain != null &&
        data.owners?.isNotEmpty != null &&
        data.threshold != null);
  }
}

@freezed
class CreateVaultEvent with _$CreateVaultEvent {
  factory CreateVaultEvent.onVaultNameChanged({
    required String vaultName,
  }) = CreateVaultEventOnVaultNameChanged;
  factory CreateVaultEvent.onChainSelected({
    required Chain selectedChain,
  }) = CreateVaultEventOnVaultChainSelected;
  factory CreateVaultEvent.onOwnersChanged({
    required List<String> owners,
  }) = CreateVaultEventOnVaultOnOwnersChanged;
  factory CreateVaultEvent.onThresholdChanged({
    required int threshold,
  }) = CreateVaultEventOnVaultOnThresholdChanged;
}

@freezed
class CreateVaultState with _$CreateVaultState {
  factory CreateVaultState({
    required bool isValid,
    required CreateVaultData data,
  }) = _CreateVaultState;
}

@freezed
class CreateVaultData with _$CreateVaultData {
  factory CreateVaultData({
    String? vaultName,
    Chain? selectedChain,
    List<String>? owners,
    int? threshold,
  }) = _CreateVaultData;
}
