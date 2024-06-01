import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_farcaster_cast_bloc.freezed.dart';

class CreateFarcasterCastBloc
    extends Bloc<CreateFarcasterCastEvent, CreateFarcasterCastState> {
  CreateFarcasterCastBloc()
      : super(
          CreateFarcasterCastState(
            payload: CreateFarcasterPayload(
              message: '',
              messageWithoutMentions: '',
              selectedChannel: null,
              mentions: [],
            ),
            isValid: false,
          ),
        ) {
    on<_CreateFarcasterCastEventOnChannelSelected>(_onChannelSelected);
    on<_CreateFarcasterCastEventOnMessageUpdated>(_onMessageUpdated);
    on<_CreateFarcasterCastEventOnMentionsUpdated>(_onMentionsUpdated);
    on<_CreateFarcasterCastEventOnMessageWithoutMentionsUpdated>(
      _onMessageWithoutMentionsUpdated,
    );
  }

  void _onChannelSelected(
    _CreateFarcasterCastEventOnChannelSelected event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          payload: state.payload.copyWith(selectedChannel: event.channel),
        ),
      ),
    );
  }

  void _onMessageUpdated(
    _CreateFarcasterCastEventOnMessageUpdated event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          payload: state.payload.copyWith(message: event.message),
        ),
      ),
    );
  }

  void _onMentionsUpdated(
    _CreateFarcasterCastEventOnMentionsUpdated event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(
        payload: state.payload.copyWith(mentions: event.mentions),
      ),
    );
  }

  void _onMessageWithoutMentionsUpdated(
    _CreateFarcasterCastEventOnMessageWithoutMentionsUpdated event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(
        payload: state.payload
            .copyWith(messageWithoutMentions: event.messageWithoutMentions),
      ),
    );
  }

  CreateFarcasterCastState _validate(CreateFarcasterCastState state) {
    final isValid = state.payload.message.trim().isNotEmpty;
    return state.copyWith(isValid: isValid);
  }
}

@freezed
class CreateFarcasterCastEvent with _$CreateFarcasterCastEvent {
  factory CreateFarcasterCastEvent.selectChannel({
    FarcasterChannel? channel,
  }) = _CreateFarcasterCastEventOnChannelSelected;
  factory CreateFarcasterCastEvent.updateMessage({
    required String message,
  }) = _CreateFarcasterCastEventOnMessageUpdated;
  factory CreateFarcasterCastEvent.updateMessageWithoutMentions({
    required String messageWithoutMentions,
  }) = _CreateFarcasterCastEventOnMessageWithoutMentionsUpdated;
  factory CreateFarcasterCastEvent.updateMentions({
    required List<FarcasterMention> mentions,
  }) = _CreateFarcasterCastEventOnMentionsUpdated;
  factory CreateFarcasterCastEvent.submit() =
      _CreateFarcasterCastEventOnSubmitted;
}

@freezed
class CreateFarcasterCastState with _$CreateFarcasterCastState {
  factory CreateFarcasterCastState({
    required CreateFarcasterPayload payload,
    required bool isValid,
  }) = _CreateFarcasterCastState;
}

@freezed
class FarcasterMention with _$FarcasterMention {
  factory FarcasterMention({
    required int position,
    required int fid,
  }) = _FarcasterMention;
}

@freezed
class CreateFarcasterPayload with _$CreateFarcasterPayload {
  factory CreateFarcasterPayload({
    required String message,
    required String messageWithoutMentions,
    FarcasterChannel? selectedChannel,
    required List<FarcasterMention> mentions,
  }) = _CreateFarcasterPayload;
}
