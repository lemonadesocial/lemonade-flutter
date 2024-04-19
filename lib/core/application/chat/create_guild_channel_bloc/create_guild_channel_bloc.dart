import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_guild_channel_bloc.freezed.dart';

class CreateGuildChannelBloc
    extends Bloc<CreateGuildChannelEvent, CreateGuildChannelState> {
  final _chatRepository = getIt<ChatRepository>();

  CreateGuildChannelBloc() : super(CreateGuildChannelState(isValid: false)) {
    on<CreateGuildChannelEventChannelNameChanged>(_onChannelNameChanged);
    on<CreateGuildChannelEventTopicChanged>(_onTopicChanged);
  }

  Future<void> _onChannelNameChanged(
    CreateGuildChannelEventChannelNameChanged event,
    Emitter emit,
  ) async {
    final newState = state.copyWith(
      channelname: event.channelName,
    );
    emit(
      _validate(newState),
    );
  }

  Future<void> _onTopicChanged(
    CreateGuildChannelEventTopicChanged event,
    Emitter emit,
  ) async {
    final newState = state.copyWith(
      topic: event.topic,
    );
    emit(
      _validate(newState),
    );
  }

  CreateGuildChannelState _validate(CreateGuildChannelState state) {
    final hasChannelName = state.channelname?.isNotEmpty ?? false;
    return state.copyWith(isValid: hasChannelName);
  }
}

@freezed
class CreateGuildChannelEvent with _$CreateGuildChannelEvent {
  factory CreateGuildChannelEvent.channelNameChanged({
    String? channelName,
  }) = CreateGuildChannelEventChannelNameChanged;
  factory CreateGuildChannelEvent.topicChanged({
    String? topic,
  }) = CreateGuildChannelEventTopicChanged;
}

@freezed
class CreateGuildChannelState with _$CreateGuildChannelState {
  factory CreateGuildChannelState({
    String? channelname,
    String? topic,
    required bool isValid,
  }) = _IssueTicketsBlocState;
}
