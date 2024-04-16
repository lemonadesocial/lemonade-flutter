import 'package:app/core/application/chat/check_guild_room_roles_bloc/check_guild_room_roles_bloc.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_detail_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_role_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuildRolesList extends StatelessWidget {
  const GuildRolesList({super.key, required this.guildRoom});

  final GuildRoom guildRoom;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        BlocBuilder<CheckGuildRoomRolesBloc, CheckGuildRoomRolesState>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (guild, guildRoles, guildRolePermissions) {
                // If didn't select any roles
                if (guildRoom.guildRoleIds == null) {
                  if (guild != null) {
                    return _buildGuildDetailItem(
                      guild: guild,
                      context: context,
                    );
                  }
                  return const SizedBox();
                } else {
                  return _buildGuildRolesList(
                    guildRoles,
                    guildRolePermissions,
                    guild,
                    colorScheme,
                    context,
                  );
                }
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                  child: Loading.defaultLoading(context),
                ),
              ),
              orElse: () => Center(
                child: Text(t.common.somethingWrong),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGuildDetailItem({
    required BuildContext context,
    required Guild guild,
  }) {
    return Column(
      children: [
        SizedBox(height: Spacing.medium),
        GuildDetailItem(
          guild: guild,
          onTap: () {
            AutoRouter.of(context).navigate(
              WebviewRoute(
                uri: Uri.parse(
                  GuildUtils.getFullGuildUrl(guild.urlName ?? ''),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGuildRolesList(
    List<GuildRole>? guildRoles,
    List<GuildRolePermission>? guildRolePermissions,
    Guild? guild,
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    final percentageProgress =
        _calculatePercentageProgress(guildRolePermissions);
    return Column(
      children: [
        SizedBox(height: Spacing.medium),
        LinearProgressIndicator(
          value: percentageProgress,
          color: LemonColor.paleViolet,
          backgroundColor: colorScheme.surface,
          minHeight: 3,
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        SizedBox(height: Spacing.medium),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: guildRoles?.length ?? 0,
            itemBuilder: (context, index) {
              final completed = guildRolePermissions?.any(
                (item) =>
                    item.roleId == guildRoles![index].id && item.access == true,
              );
              return GuildRoleItem(
                guildRole: guildRoles![index],
                onTap: () => _handleGuildRoleTap(context, guild),
                completed: completed,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: Spacing.xSmall);
            },
          ),
        ),
      ],
    );
  }

  double _calculatePercentageProgress(
    List<GuildRolePermission>? guildRolePermissions,
  ) {
    return guildRolePermissions!.any((item) => item.access == true)
        ? guildRolePermissions.where((item) => item.access == true).length /
            guildRolePermissions.length
        : 0.01;
  }

  void _handleGuildRoleTap(BuildContext context, Guild? guild) {
    final userWalletAddress =
        getIt<WalletConnectService>().w3mService.address ?? '';
    if (userWalletAddress.isEmpty) {
      final w3mService = getIt<WalletConnectService>().w3mService;
      w3mService.openModal(context);
    } else {
      AutoRouter.of(context).navigate(
        WebviewRoute(
          uri: Uri.parse(
            GuildUtils.getFullGuildUrl(guild?.urlName ?? ''),
          ),
        ),
      );
    }
  }
}
