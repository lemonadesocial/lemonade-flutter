import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_listing_bloc.freezed.dart';

class TokensListingBloc extends Bloc<TokensListingEvent, TokensListingState> {
  final TokenService tokenService;
  TokensListingBloc(this.tokenService) : super(TokensListingState.loading()) {
    on<TokensListingEventFetch>(_onFetch);
  }

  _onFetch(TokensListingEventFetch event, Emitter emit) async {
    final result = await tokenService.getTokens(input: event.input);
    result.fold((l) {
      emit(TokensListingState.failure());
    }, (tokens) {
      emit(TokensListingState.fetched(
        tokens: tokens,
      ));
    });
  }
}

@freezed
class TokensListingEvent with _$TokensListingEvent {
  const factory TokensListingEvent.fetch({GetTokensInput? input}) = TokensListingEventFetch;
}

@freezed
class TokensListingState with _$TokensListingState {
  const factory TokensListingState.loading() = TokensListingStateLoading;
  const factory TokensListingState.fetched({
    required List<TokenComplex> tokens,
  }) = TokensListingStateFetched;
  const factory TokensListingState.failure() = TokensListingStateFailure;
}
