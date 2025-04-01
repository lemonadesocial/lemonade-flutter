import 'package:app/core/application/chat/check_guild_room_roles_bloc/check_guild_room_roles_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_detail_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_role_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reown_appkit/modal/widgets/buttons/connect_button.dart';

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
                    return Column(
                      children: [
                        SizedBox(height: Spacing.medium),
                        BlocBuilder<WalletBloc, WalletState>(
                          builder: (context, walletState) {
                            final connectButtonState = walletState.state;
                            final isConnected = connectButtonState ==
                                ConnectButtonState.connected;
                            return GuildDetailItem(
                              guild: guild,
                              onTap: () {
                                _handleGuildRoleTap(context, guild);
                              },
                              actionLabel: isConnected
                                  ? t.common.actions.join
                                  : StringUtils.capitalize(
                                      t.common.actions.connect,
                                    ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                } else {
                  final percentageProgress = guildRolePermissions != null &&
                          guildRolePermissions
                              .any((item) => item.access == true)
                      ? guildRolePermissions
                              .where((item) => item.access == true)
                              .length /
                          guildRolePermissions.length
                      : 0.01;
                  return Column(
                    children: [
                      SizedBox(height: Spacing.medium),
                      LinearProgressIndicator(
                        value: percentageProgress,
                        color: LemonColor.paleViolet,
                        backgroundColor: colorScheme.surface,
                        minHeight: 3,
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      SizedBox(height: Spacing.medium),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300.w),
                        child: ListView.separated(
                          shrinkWrap:
                              guildRoles != null && guildRoles.length < 6,
                          itemCount: guildRoles?.length ?? 0,
                          itemBuilder: (context, index) {
                            final completed = guildRolePermissions?.any(
                              (item) =>
                                  item.roleId == guildRoles![index].id &&
                                  item.access == true,
                            );
                            return guildRoles != null
                                ? BlocBuilder<WalletBloc, WalletState>(
                                    builder: (context, walletState) {
                                      final connectButtonState =
                                          walletState.state;
                                      final isConnected = connectButtonState ==
                                          ConnectButtonState.connected;
                                      return GuildRoleItem(
                                        guildRole: guildRoles[index],
                                        onTap: () =>
                                            _handleGuildRoleTap(context, guild),
                                        completed: completed,
                                        actionLabel: isConnected
                                            ? t.common.actions.join
                                            : StringUtils.capitalize(
                                                t.common.actions.connect,
                                              ),
                                      );
                                    },
                                  )
                                : const SizedBox();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: Spacing.xSmall);
                          },
                        ),
                      ),
                    ],
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

  void _handleGuildRoleTap(BuildContext context, Guild? guild) {
    // final userWalletAddress =
    //     getIt<WalletConnectService>().w3mService.session?.address ?? '';
    // TODO: FIX WALLET MIGRATION
    final userWalletAddress = '';
    if (userWalletAddress.isEmpty) {
      final w3mService = getIt<WalletConnectService>().w3mService;
      w3mService.openModalView();
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
