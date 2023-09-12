import 'dart:async';

import 'package:app/core/data/poap/poap_repository_impl.dart';
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

part 'poap_claim_transfer_subscription_bloc.freezed.dart';

class PoapClaimTransferSubscriptionBloc extends Bloc<
    PoapClaimTransferSubscriptionEvent, PoapClaimTransferSubscriptionState> {
  PoapClaimTransferSubscriptionBloc()
      : super(PoapClaimTransferSubscriptionStateInitial()) {
    on<PoapClaimTransferSubscriptionEventStart>(_onStartWatchClaimModification);
    on<PoapClaimTransferSubscriptionEventClear>(_onClear);
    on<PoapClaimTransferSubscriptionEventUpdate>(_onUpdate);
  }
  final PoapRepository _poapRepository = PoapRepositoryImpl();
  final _tokenRepository = getIt<TokenRepository>();
  StreamSubscription<Either<Failure, Claim?>>? _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }

  Future<void> _onStartWatchClaimModification(
      PoapClaimTransferSubscriptionEventStart event, Emitter emit) async {
    _streamSubscription =
        _poapRepository.watchClaimModification().listen(_onClaimData);
  }

  Future<void> _onClaimData(Either<Failure, Claim?> result) async {
    if (result.isLeft()) {
      return add(PoapClaimTransferSubscriptionEvent.clear());
    }

    final claim = result.getOrElse(() => null);

    if (claim != null) {
      if (claim.state == ClaimState.CONFIRMED) {
        TokenDetail? token;
        if (claim.chainlinkRequest != null &&
            !claim.chainlinkRequest!.fulfilled!) {
          return add(PoapClaimTransferSubscriptionEvent.clear());
        }

        token = (await _tokenRepository.getToken(
          input: GetTokenDetailInput(
            id: '${claim.to?.toLowerCase()}-0',
            network: claim.network,
          ),
        ))
            .fold((l) => null, (mToken) => mToken);

        if (token == null) {
          return add(PoapClaimTransferSubscriptionEvent.clear());
        }

        add(PoapClaimTransferSubscriptionEvent.update(
          claimModification: claim,
          token: token,
        ));
      } else {
        add(
          PoapClaimTransferSubscriptionEvent.update(
            claimModification: claim,
          ),
        );
      }
    } else {
      add(PoapClaimTransferSubscriptionEvent.clear());
    }
  }

  void _onUpdate(PoapClaimTransferSubscriptionEventUpdate event, Emitter emit) {
    emit(PoapClaimTransferSubscriptionState.hasClaimModification(
      claimModification: event.claimModification,
      token: event.token,
    ));
  }

  void _onClear(PoapClaimTransferSubscriptionEventClear event, Emitter emit) {
    emit(
      PoapClaimTransferSubscriptionState.initial(),
    );
  }
}

@freezed
class PoapClaimTransferSubscriptionEvent
    with _$PoapClaimTransferSubscriptionEvent {
  factory PoapClaimTransferSubscriptionEvent.start() =
      PoapClaimTransferSubscriptionEventStart;
  factory PoapClaimTransferSubscriptionEvent.update({
    required Claim claimModification,
    TokenDetail? token,
  }) = PoapClaimTransferSubscriptionEventUpdate;
  factory PoapClaimTransferSubscriptionEvent.clear() =
      PoapClaimTransferSubscriptionEventClear;
}

@freezed
class PoapClaimTransferSubscriptionState
    with _$PoapClaimTransferSubscriptionState {
  factory PoapClaimTransferSubscriptionState.initial() =
      PoapClaimTransferSubscriptionStateInitial;
  factory PoapClaimTransferSubscriptionState.hasClaimModification({
    required Claim claimModification,
    TokenDetail? token,
  }) = PoapClaimTransferSubscriptionStateHasClaimModication;
}
