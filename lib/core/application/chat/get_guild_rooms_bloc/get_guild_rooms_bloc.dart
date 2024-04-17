import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_guild_rooms_bloc.freezed.dart';

class GetGuildRoomsBloc extends Bloc<GetGuildRoomsEvent, GetGuildRoomsState> {
  final _chatRepository = getIt<ChatRepository>();

  GetGuildRoomsBloc() : super(GetGuildRoomsStateLoading()) {
    on<GetGuildRoomsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    GetGuildRoomsEventFetch event,
    Emitter emit,
  ) async {
    emit(GetGuildRoomsState.loading());
    final result = await _chatRepository.getGuildRooms();
    result.fold(
      (failure) => emit(GetGuildRoomsState.failure()),
      (data) => emit(
        GetGuildRoomsState.success(
          guildRooms: data,
        ),
      ),
    );
  }
}

@freezed
class GetGuildRoomsEvent with _$GetGuildRoomsEvent {
  factory GetGuildRoomsEvent.fetch() = GetGuildRoomsEventFetch;
}

@freezed
class GetGuildRoomsState with _$GetGuildRoomsState {
  factory GetGuildRoomsState.loading() = GetGuildRoomsStateLoading;
  factory GetGuildRoomsState.success({
    required List<GuildRoom> guildRooms,
  }) = GetGuildRoomsStateSuccess;
  factory GetGuildRoomsState.failure() = GetGuildRoomsStateFailure;
}
