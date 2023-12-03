import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/domain/ai/ai_repository.dart';
import 'package:app/core/domain/ai/input/get_ai_config_input/get_ai_config_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ai_config_bloc.freezed.dart';

class GetAIConfigBloc extends Bloc<GetAIConfigEvent, GetAIConfigState> {
  GetAIConfigBloc() : super(const GetAIConfigStateLoading()) {
    on<GetAIConfigEventFetch>(_onFetch);
  }

  final AIRepository aiRepository = getIt<AIRepository>();

  Future<void> _onFetch(GetAIConfigEventFetch event, Emitter emit) async {
    final result = await aiRepository.getAIConfig(
      input: GetAIConfigInput(
        id: event.id,
      ),
    );
    result.fold(
      (failure) => emit(const GetAIConfigState.failure()),
      (config) => emit(
        GetAIConfigState.fetched(config: config),
      ),
    );
  }
}

@freezed
class GetAIConfigEvent with _$GetAIConfigEvent {
  const factory GetAIConfigEvent.fetch({
    required String id,
  }) = GetAIConfigEventFetch;
}

@freezed
class GetAIConfigState with _$GetAIConfigState {
  const factory GetAIConfigState.fetched({
    required Config config,
  }) = GetAIConfigStateFetched;
  const factory GetAIConfigState.loading() = GetAIConfigStateLoading;
  const factory GetAIConfigState.failure() = GetAIConfigStateFailure;
}
