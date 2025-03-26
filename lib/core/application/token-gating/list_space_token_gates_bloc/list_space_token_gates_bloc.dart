import 'package:app/core/domain/token-gating/entities/space_token_gate.dart';
import 'package:app/core/domain/token-gating/token_gating_repository.dart';
import 'package:app/core/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_space_token_gates_bloc.freezed.dart';

class ListSpaceTokenGatesBloc
    extends Bloc<ListSpaceTokenGatesEvent, ListSpaceTokenGatesState> {
  final TokenGatingRepository repository;

  ListSpaceTokenGatesBloc(this.repository) : super(const _Initial()) {
    on<_Fetch>(_onFetch);
  }

  Future<void> _onFetch(
    _Fetch event,
    Emitter<ListSpaceTokenGatesState> emit,
  ) async {
    if (event.refresh != true) {
      emit(const _Loading());
    }

    final result = await repository.listSpaceTokenGates(spaceId: event.spaceId);
    emit(
      result.fold(
        (failure) => _Failure(failure),
        (tokenGates) => _Fetched(tokenGates),
      ),
    );
  }
}

@freezed
class ListSpaceTokenGatesEvent with _$ListSpaceTokenGatesEvent {
  const factory ListSpaceTokenGatesEvent.fetch({
    required String spaceId,
    bool? refresh,
  }) = _Fetch;
}

@freezed
class ListSpaceTokenGatesState with _$ListSpaceTokenGatesState {
  const factory ListSpaceTokenGatesState.initial() = _Initial;
  const factory ListSpaceTokenGatesState.loading() = _Loading;
  const factory ListSpaceTokenGatesState.fetched(
    List<SpaceTokenGate> tokenGates,
  ) = _Fetched;
  const factory ListSpaceTokenGatesState.failure(Failure failure) = _Failure;
}
