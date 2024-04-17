import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_guild_room_roles_bloc.freezed.dart';

class CheckGuildRoomRolesBloc
    extends Bloc<CheckGuildRoomRolesEvent, CheckGuildRoomRolesState> {
  final _chatRepository = getIt<ChatRepository>();

  final GuildRoom guildRoom;

  CheckGuildRoomRolesBloc({required this.guildRoom})
      : super(CheckGuildRoomRolesStateLoading()) {
    on<CheckGuildRoomRolesEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    CheckGuildRoomRolesEventFetch event,
    Emitter emit,
  ) async {
    final userWalletAddress =
        getIt<WalletConnectService>().w3mService.address ?? '';
    emit(CheckGuildRoomRolesState.loading());
    final guild = await _getGuildDetail();
    List<GuildRolePermission> guildRolePermissions = [];
    if (userWalletAddress.isNotEmpty) {
      guildRolePermissions = await _getGuildRolePermissions(userWalletAddress);
    }
    final guildRoleIds = guildRoom.guildRoleIds;
    List<GuildRole> filteredRoles = [];
    if (guild != null) {
      if (guildRoleIds != null) {
        filteredRoles = guild.roles
                ?.where(
                  (role) => guildRoleIds.contains(role.id),
                )
                .toList() ??
            [];
      } else {
        filteredRoles = guild.roles ?? [];
      }
    }
    emit(
      CheckGuildRoomRolesState.success(
        guild: guild,
        guildRoles: filteredRoles,
        guildRolePermissions: guildRolePermissions,
      ),
    );
  }

  Future<Guild?> _getGuildDetail() async {
    final result = await _chatRepository.getGuildDetail(guildRoom.guildId ?? 0);
    if (result.isLeft()) {
      return null;
    }
    return result.getOrElse(() => null);
  }

  Future<List<GuildRolePermission>> _getGuildRolePermissions(
    String? walletAddress,
  ) async {
    final result = await _chatRepository.getGuildRolePermissions(
      guildId: guildRoom.guildId ?? 0,
      walletAddress: walletAddress ?? '',
    );
    if (result.isLeft()) {
      return [];
    }
    return result.getOrElse(() => []);
  }
}

@freezed
class CheckGuildRoomRolesEvent with _$CheckGuildRoomRolesEvent {
  factory CheckGuildRoomRolesEvent.fetch() = CheckGuildRoomRolesEventFetch;
}

@freezed
class CheckGuildRoomRolesState with _$CheckGuildRoomRolesState {
  factory CheckGuildRoomRolesState.loading() = CheckGuildRoomRolesStateLoading;
  factory CheckGuildRoomRolesState.success({
    Guild? guild,
    List<GuildRole>? guildRoles,
    List<GuildRolePermission>? guildRolePermissions,
  }) = CheckGuildRoomRolesStateSuccess;
  factory CheckGuildRoomRolesState.failure() = CheckGuildRoomRolesStateFailure;
}
