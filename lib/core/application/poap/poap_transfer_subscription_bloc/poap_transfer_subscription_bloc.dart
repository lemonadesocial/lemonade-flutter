import 'dart:async';

import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poap_transfer_subscription_bloc.freezed.dart';

class PoapTransferSubscriptionBloc
    extends Bloc<PoapTransferSubscriptionEvent, PoapTransferSubscriptionState> {
  PoapTransferSubscriptionBloc()
      : super(PoapTransferSubscriptionStateInitial()) {
    on<PoapTransferSubscriptionEventStart>(_onStartWatchTransferModification);
    on<PoapTransferSubscriptionEventClear>(_onClear);
    on<PoapTransferSubscriptionEventUpdate>(_onUpdate);
  }
  final PoapRepository _poapRepository = getIt<PoapRepository>();
  final _tokenRepository = getIt<TokenRepository>();
  StreamSubscription<Either<Failure, Transfer?>>? _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }

  Future<void> _onStartWatchTransferModification(
    PoapTransferSubscriptionEventStart event,
    Emitter emit,
  ) async {
    _streamSubscription =
        _poapRepository.watchTransferModification().listen(_onTransferData);
  }

  Future<void> _onTransferData(Either<Failure, Transfer?> result) async {
    if (result.isLeft()) {
      return add(PoapTransferSubscriptionEvent.clear());
    }

    final transferModification = result.getOrElse(() => null);

    if (transferModification != null) {
      if (transferModification.state == TransferState.CONFIRMED) {
        TokenDetail? token;

        token = (await _tokenRepository.getToken(
          input: GetTokenDetailInput(
            id: '${transferModification.to?.toLowerCase()}-0',
            network: transferModification.network,
          ),
        ))
            .fold((l) => null, (mToken) => mToken);

        if (token == null) {
          return add(PoapTransferSubscriptionEvent.clear());
        }

        add(
          PoapTransferSubscriptionEvent.update(
            transferModification: transferModification,
            token: token,
          ),
        );
      } else {
        add(
          PoapTransferSubscriptionEvent.update(
            transferModification: transferModification,
          ),
        );
      }
    } else {
      add(PoapTransferSubscriptionEvent.clear());
    }
  }

  void _onUpdate(PoapTransferSubscriptionEventUpdate event, Emitter emit) {
    emit(
      PoapTransferSubscriptionState.hasTransferModification(
        transferModification: event.transferModification,
        token: event.token,
      ),
    );
  }

  void _onClear(PoapTransferSubscriptionEventClear event, Emitter emit) {
    emit(
      PoapTransferSubscriptionState.initial(),
    );
  }
}

@freezed
class PoapTransferSubscriptionEvent with _$PoapTransferSubscriptionEvent {
  factory PoapTransferSubscriptionEvent.start() =
      PoapTransferSubscriptionEventStart;
  factory PoapTransferSubscriptionEvent.update({
    required Transfer transferModification,
    TokenDetail? token,
  }) = PoapTransferSubscriptionEventUpdate;
  factory PoapTransferSubscriptionEvent.clear() =
      PoapTransferSubscriptionEventClear;
}

@freezed
class PoapTransferSubscriptionState with _$PoapTransferSubscriptionState {
  factory PoapTransferSubscriptionState.initial() =
      PoapTransferSubscriptionStateInitial;
  factory PoapTransferSubscriptionState.hasTransferModification({
    required Transfer transferModification,
    TokenDetail? token,
  }) = PoapTransferSubscriptionStateHasTranferModification;
}
