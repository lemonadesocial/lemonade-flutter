import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_channel_access_page/widgets/guild_access_info_section.dart';
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
    on<CreateGuildChannelEventSelectGuild>(_onSelectGuild);
    on<CreateGuildChannelEventSelectGuildAccessOption>(
      _onSelectGuildAccessOption,
    );
    on<CreateGuildChannelEventSelectGuildRole>(
      _onSelectGuildRole,
    );
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
  }

  Future<void> _onSelectGuild(
    CreateGuildChannelEventSelectGuild event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
        statusFetchGuildDetail: CreateGuildChannelStatus.loading));
    final result = await _chatRepository.getGuildDetail(event.guildId ?? 0);
    final guildDetail = result.getOrElse(() => null);
    emit(
      state.copyWith(
        guildDetail: guildDetail,
        statusFetchGuildDetail: CreateGuildChannelStatus.success,
      ),
    );
  }

  Future<void> _onSelectGuildAccessOption(
    CreateGuildChannelEventSelectGuildAccessOption event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        selectedGuildAccessOption:
            event.option ?? GuildAccessOptions.allMembers,
      ),
    );
  }

  Future<void> _onSelectGuildRole(
    CreateGuildChannelEventSelectGuildRole event,
    Emitter emit,
  ) async {
    if (event.guildRole == null) {
      return;
    }
    // Check if the selected guildRole id is already in the selectedGuildRole ids
    bool isSelected = (state.selectedGuildRoles ?? [])
        .any((role) => role.id == event.guildRole?.id);

    // If already selected, remove it; otherwise, append it
    List<GuildRole> updatedSelectedRoles =
        List.from(state.selectedGuildRoles ?? []);
    if (isSelected) {
      updatedSelectedRoles
          .removeWhere((role) => role.id == event.guildRole?.id);
    } else {
      if (event.guildRole != null) {
        updatedSelectedRoles.add(event.guildRole!);
      }
    }

    emit(
      state.copyWith(
        selectedGuildRoles: updatedSelectedRoles,
      ),
    );
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
  const factory CreateGuildChannelEvent.selectGuild({
    int? guildId,
  }) = CreateGuildChannelEventSelectGuild;
  const factory CreateGuildChannelEvent.selectGuildAccessOption({
    GuildAccessOptions? option,
  }) = CreateGuildChannelEventSelectGuildAccessOption;
  const factory CreateGuildChannelEvent.selectGuildRole(
      {GuildRole? guildRole}) = CreateGuildChannelEventSelectGuildRole;
}

@freezed
class CreateGuildChannelState with _$CreateGuildChannelState {
  factory CreateGuildChannelState({
    String? channelname,
    String? topic,
    List<GuildBasic>? guilds,
    required bool isValid,
    String? searchTerm,
    Guild? guildDetail,
    @Default(CreateGuildChannelStatus.initial)
    CreateGuildChannelStatus statusFetchGuilds,
    @Default(CreateGuildChannelStatus.initial)
    CreateGuildChannelStatus statusFetchGuildDetail,
    @Default(GuildAccessOptions.allMembers)
    GuildAccessOptions? selectedGuildAccessOption,
    List<GuildRole>? selectedGuildRoles,
  }) = _IssueTicketsBlocState;
}

enum CreateGuildChannelStatus {
  initial,
  loading,
  success,
  error,
}
