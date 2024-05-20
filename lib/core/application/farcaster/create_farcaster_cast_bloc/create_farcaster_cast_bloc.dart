import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_farcaster_cast_bloc.freezed.dart';

class CreateFarcasterCastBloc
    extends Bloc<CreateFarcasterCastEvent, CreateFarcasterCastState> {
  CreateFarcasterCastBloc()
      : super(
          CreateFarcasterCastState(
            payload: CreateFarcasterPayload(message: '', selectedChannel: null),
            isValid: false,
          ),
        ) {
    on<_CreateFarcasterCastEventOnChannelSelected>(_onChannelSelected);
    on<_CreateFarcasterCastEventOnMessageUpdated>(_onMessageUpdated);
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

  CreateFarcasterCastState _validate(CreateFarcasterCastState state) {
    final isValid = state.payload.message.isNotEmpty;
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
class CreateFarcasterPayload with _$CreateFarcasterPayload {
  factory CreateFarcasterPayload({
    required String message,
    FarcasterChannel? selectedChannel,
  }) = _CreateFarcasterPayload;
}
