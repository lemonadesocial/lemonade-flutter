import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_listing_bloc.freezed.dart';

class TokensListingBloc extends Bloc<TokensListingEvent, TokensListingState> {
  final TokenService tokenService;
  final GetTokensInput? defaultInput;
  late final PaginationService<TokenComplex, GetTokensInput> paginationService =
      PaginationService(getDataFuture: _getTokens);

  TokensListingBloc(
    this.tokenService, {
    this.defaultInput,
  }) : super(TokensListingState.loading()) {
    on<TokensListingEventFetch>(_onFetch, transformer: droppable());
  }

  Future<Either<Failure, List<TokenComplex>>> _getTokens(int skip, endReached, {GetTokensInput? input}) async {
    return await tokenService.getTokens(input: input?.copyWith(skip: skip));
  }

  _onFetch(TokensListingEventFetch event, Emitter emit) async {
    final result = await paginationService.fetch(defaultInput ?? event.input);

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
