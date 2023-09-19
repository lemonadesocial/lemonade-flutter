import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_listing_bloc.freezed.dart';

class TokensListingBloc extends Bloc<TokensListingEvent, TokensListingState> {
  final TokenService tokenService;
  final GetTokensInput defaultInput;
  late final PaginationService<TokenComplex, GetTokensInput> paginationService =
      PaginationService(getDataFuture: _getTokens);

  TokensListingBloc(
    this.tokenService, {
    required this.defaultInput,
  }) : super(const TokensListingState.loading()) {
    on<TokensListingEventFetch>(_onFetch, transformer: droppable());
    on<TokensListingEventFetchComplete>(_onFetchComplete);
  }

  Future<Either<Failure, List<TokenComplex>>> _getTokens(
    int skip,
    endReached, {
    required GetTokensInput input,
  }) {
    return tokenService.getTokens(input: input.copyWith(skip: skip));
  }

  Future<void> _onFetch(TokensListingEventFetch event, Emitter emit) async {
    final result = await paginationService.fetch(defaultInput);

    result.fold((l) {
      emit(const TokensListingState.failure());
    }, (tokenList) async {
      final mediaList = <Media>[];
      await Future.forEach<TokenComplex>(tokenList, (token) async {
        await MediaUtils.getNftMedia(
          token.metadata?.image,
          token.metadata?.animation_url,
        ).then((media) => mediaList.add(media));
      }).whenComplete(
        () => add(TokensListingEvent.fetchComplete(mediaList: mediaList)),
      );
    });
  }

  void _onFetchComplete(TokensListingEventFetchComplete event, Emitter emit) {
    emit(
      TokensListingState.fetched(
        mediaList: event.mediaList,
      ),
    );
  }
}

@freezed
class TokensListingEvent with _$TokensListingEvent {
  const factory TokensListingEvent.fetch({GetTokensInput? input}) =
      TokensListingEventFetch;

  const factory TokensListingEvent.fetchComplete({
    required List<Media> mediaList,
  }) = TokensListingEventFetchComplete;
}

@freezed
class TokensListingState with _$TokensListingState {
  const factory TokensListingState.loading() = TokensListingStateLoading;

  const factory TokensListingState.fetched({
    required List<Media> mediaList,
  }) = TokensListingStateFetched;

  const factory TokensListingState.failure() = TokensListingStateFailure;
}
