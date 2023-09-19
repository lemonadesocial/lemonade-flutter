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

part 'poap_claim_subscription_bloc.freezed.dart';

class PoapClaimSubscriptionBloc
    extends Bloc<PoapClaimSubscriptionEvent, PoapClaimSubscriptionState> {
  PoapClaimSubscriptionBloc() : super(PoapClaimSubscriptionStateInitial()) {
    on<PoapClaimSubscriptionEventStart>(_onStartWatchClaimModification);
    on<PoapClaimSubscriptionEventClear>(_onClear);
    on<PoapClaimSubscriptionEventUpdate>(_onUpdate);
  }
  final PoapRepository _poapRepository = getIt<PoapRepository>();
  final _tokenRepository = getIt<TokenRepository>();
  StreamSubscription<Either<Failure, Claim?>>? _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }

  Future<void> _onStartWatchClaimModification(
    PoapClaimSubscriptionEventStart event,
    Emitter emit,
  ) async {
    _streamSubscription =
        _poapRepository.watchClaimModification().listen(_onClaimData);
  }

  Future<void> _onClaimData(Either<Failure, Claim?> result) async {
    if (result.isLeft()) {
      return add(PoapClaimSubscriptionEvent.clear());
    }

    final claim = result.getOrElse(() => null);

    if (claim != null) {
      if (claim.state == ClaimState.CONFIRMED) {
        TokenDetail? token;
        if (claim.chainlinkRequest != null &&
            claim.chainlinkRequest?.fulfilled != true) {
          return add(PoapClaimSubscriptionEvent.clear());
        }

        token = (await _tokenRepository.getToken(
          input: GetTokenDetailInput(
            id: '${claim.to?.toLowerCase()}-0',
            network: claim.network,
          ),
        ))
            .fold((l) => null, (mToken) => mToken);

        if (token == null) {
          return add(PoapClaimSubscriptionEvent.clear());
        }

        final claimedToken = token.copyWith(tokenId: claim.tokenId);

        add(
          PoapClaimSubscriptionEvent.update(
            claimModification: claim,
            token: claimedToken,
          ),
        );
      } else {
        add(
          PoapClaimSubscriptionEvent.update(
            claimModification: claim,
          ),
        );
      }
    } else {
      add(PoapClaimSubscriptionEvent.clear());
    }
  }

  void _onUpdate(PoapClaimSubscriptionEventUpdate event, Emitter emit) {
    emit(
      PoapClaimSubscriptionState.hasClaimModification(
        claimModification: event.claimModification,
        token: event.token,
      ),
    );
  }

  void _onClear(PoapClaimSubscriptionEventClear event, Emitter emit) {
    emit(
      PoapClaimSubscriptionState.initial(),
    );
  }
}

@freezed
class PoapClaimSubscriptionEvent with _$PoapClaimSubscriptionEvent {
  factory PoapClaimSubscriptionEvent.start() = PoapClaimSubscriptionEventStart;
  factory PoapClaimSubscriptionEvent.update({
    required Claim claimModification,
    TokenDetail? token,
  }) = PoapClaimSubscriptionEventUpdate;
  factory PoapClaimSubscriptionEvent.clear() = PoapClaimSubscriptionEventClear;
}

@freezed
class PoapClaimSubscriptionState with _$PoapClaimSubscriptionState {
  factory PoapClaimSubscriptionState.initial() =
      PoapClaimSubscriptionStateInitial;
  factory PoapClaimSubscriptionState.hasClaimModification({
    required Claim claimModification,
    TokenDetail? token,
  }) = PoapClaimSubscriptionStateHasClaimModication;
}
