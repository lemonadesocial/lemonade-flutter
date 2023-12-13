import 'package:app/core/service/vault/owner_key/owner_key.dart';
import 'package:app/core/service/vault/private_key/private_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';

part 'create_vault_owner_key_bloc.freezed.dart';

class CreateVaultOwnerKeyBloc
    extends Bloc<CreateVaultOwnerKeyEvent, CreateVaultOwnerKeyState> {
  CreateVaultOwnerKeyBloc() : super(CreateVaultOwnerKeyState.initial()) {
    on<CreateVaultOwnerKeyEventGenerate>(_onGenerate);
    on<CreateVaultOwnerKeyEventImport>(_onImport);
    on<CreateVaultOwnerKeyEventReset>(_onReset);
  }

  Future<void> _onGenerate(
      CreateVaultOwnerKeyEventGenerate event, Emitter emit) async {
    if (state is _CreateVaultOwnerKeyStateGenerated) {
      return;
    }

    try {
      final seedPhrase = bip39.generateMnemonic();
      final privateKey = PrivateKey.fromMnemonic(seedPhrase, 0);
      final address = privateKey.credential.address;
      emit(
        CreateVaultOwnerKeyState.generated(
          seedPhrase: seedPhrase,
          address: address,
        ),
      );

      await OwnerKey.save(
        // we dont have ui to setup onwer key name yet so default will be address
        name: address.hexEip55,
        // right now only support type device generated
        type: OwnerKeyType.deviceGenerated,
        privateKey: privateKey,
        address: address,
        backup: 1,
      );
    } catch (error) {
      emit(CreateVaultOwnerKeyState.failure());
    }
  }

  Future<void> _onImport(
    CreateVaultOwnerKeyEventImport event,
    Emitter emit,
  ) async {
    try {
      final privateKey = PrivateKey.fromMnemonic(event.seedPhrase, 0);
      final address = privateKey.credential.address;

      await OwnerKey.save(
        // we dont have ui to setup onwer key name yet so default will be address
        name: address.hexEip55,
        // right now only support type device generated
        type: OwnerKeyType.deviceGenerated,
        privateKey: privateKey,
        address: address,
        backup: 1,
      );
    } finally {}
  }

  Future<void> _onReset(
    CreateVaultOwnerKeyEventReset event,
    Emitter emit,
  ) async {
    emit(
      CreateVaultOwnerKeyState.initial(),
    );
  }
}

@freezed
class CreateVaultOwnerKeyEvent with _$CreateVaultOwnerKeyEvent {
  factory CreateVaultOwnerKeyEvent.generate() =
      CreateVaultOwnerKeyEventGenerate;
  factory CreateVaultOwnerKeyEvent.import({
    required String seedPhrase,
  }) = CreateVaultOwnerKeyEventImport;
  factory CreateVaultOwnerKeyEvent.reset() = CreateVaultOwnerKeyEventReset;
}

@freezed
class CreateVaultOwnerKeyState with _$CreateVaultOwnerKeyState {
  factory CreateVaultOwnerKeyState.initial() = _CreateVaultOwnerKeyStateInitial;
  factory CreateVaultOwnerKeyState.generated({
    required String seedPhrase,
    required EthereumAddress address,
  }) = _CreateVaultOwnerKeyStateGenerated;
  factory CreateVaultOwnerKeyState.failure() = _CreateVaultOwnerKeyStateFailure;
}
