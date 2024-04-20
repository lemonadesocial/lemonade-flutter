import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
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
    on<CreateGuildChannelEventGetAllGuilds>(_onGetAllGuilds);
    on<CreateGuildChannelEventSearchGuilds>(_onSearchGuilds);
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

  Future<void> _onGetAllGuilds(
    CreateGuildChannelEventGetAllGuilds event,
    Emitter emit,
  ) async {
    emit(state.copyWith(statusFetchGuilds: CreateGuildChannelStatus.loading));
    final result = await _chatRepository.getAllGuilds();
    final allGuilds = result.getOrElse(() => []);
    emit(
      state.copyWith(
        guilds: allGuilds,
        statusFetchGuilds: CreateGuildChannelStatus.success,
      ),
    );
  }

  Future<void> _onSearchGuilds(
    CreateGuildChannelEventSearchGuilds event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(searchTerm: event.searchTerm),
    );
    // emit(state.copyWith(statusFetchGuilds: CreateGuildChannelStatus.loading));

    // List<GuildBasic> filteredGuilds;
    // if (event.searchTerm!.isEmpty) {
    //   filteredGuilds = state.guilds ?? [];
    // } else {
    //   filteredGuilds = (state.guilds ?? [])
    //       .where(
    //         (guild) => (guild.name ?? '').toLowerCase().contains(
    //               (event.searchTerm ?? '').toLowerCase(),
    //             ),
    //       )
    //       .toList();
    // }
    // emit(
    //   state.copyWith(
    //     guilds: filteredGuilds,
    //     statusFetchGuilds: CreateGuildChannelStatus.success,
    //   ),
    // );
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
  const factory CreateGuildChannelEvent.getAllGuilds() =
      CreateGuildChannelEventGetAllGuilds;

  const factory CreateGuildChannelEvent.searchGuilds({
    String? searchTerm,
  }) = CreateGuildChannelEventSearchGuilds;
}

@freezed
class CreateGuildChannelState with _$CreateGuildChannelState {
  factory CreateGuildChannelState({
    String? channelname,
    String? topic,
    List<GuildBasic>? guilds,
    required bool isValid,
    @Default(CreateGuildChannelStatus.initial)
    CreateGuildChannelStatus statusFetchGuilds,
    String? searchTerm,
  }) = _IssueTicketsBlocState;
}

enum CreateGuildChannelStatus {
  initial,
  loading,
  success,
  error,
}
