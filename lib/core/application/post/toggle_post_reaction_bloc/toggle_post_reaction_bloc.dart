import 'package:app/core/domain/post/input/post_reaction_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_post_reaction_bloc.freezed.dart';

class TogglePostReactionBloc
    extends Bloc<TogglePostReactionEvent, TogglePostReactionState> {
  final bool defaultHasReaction;
  final int defaultReactions;

  final postRepository = getIt<PostRepository>();

  TogglePostReactionBloc({
    required this.defaultHasReaction,
    required this.defaultReactions,
  }) : super(
          TogglePostReactionState(
            hasReaction: defaultHasReaction,
            // TODO: will remove this logic when BE fix
            reactions: defaultHasReaction && defaultReactions == 0
                ? 1
                : defaultReactions,
            isLoading: false,
          ),
        ) {
    on<TogglePostReactionEventToggle>(_onTogglePostReaction);
  }

  Future<void> _onTogglePostReaction(
    TogglePostReactionEventToggle event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await postRepository.togglePostReaction(input: event.input);
    result.fold((l) => emit(state.copyWith(isLoading: false)), (success) {
      final newHasReaction = !state.hasReaction;
      final newReactions =
          (state.reactions + (newHasReaction ? 1 : -1)).toInt();
      emit(
        state.copyWith(
          isLoading: false,
          hasReaction: success ? !state.hasReaction : defaultHasReaction,
          reactions: newReactions,
        ),
      );
    });
  }
}

@freezed
class TogglePostReactionEvent with _$TogglePostReactionEvent {
  factory TogglePostReactionEvent.toggle({
    required PostReactionInput input,
  }) = TogglePostReactionEventToggle;
}

@freezed
class TogglePostReactionState with _$TogglePostReactionState {
  factory TogglePostReactionState({
    required int reactions,
    required bool hasReaction,
    required bool isLoading,
  }) = _TogglePostReactionState;
}
