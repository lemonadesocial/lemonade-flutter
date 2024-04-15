import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_role_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckGuildRoomRolesBottomSheet extends StatefulWidget {
  final Function() onEnterChannel;
  final GuildRoom guildRoom;

  const CheckGuildRoomRolesBottomSheet({
    super.key,
    required this.onEnterChannel,
    required this.guildRoom,
  });

  @override
  State<CheckGuildRoomRolesBottomSheet> createState() =>
      _CheckGuildRoomRolesBottomSheetState();
}

class _CheckGuildRoomRolesBottomSheetState
    extends State<CheckGuildRoomRolesBottomSheet> {
  Guild? guild;

  @override
  void initState() {
    super.initState();
    () async {
      final guildResponse = await GuildUtils.getGuildDetail(
        widget.guildRoom.guildId ?? 0,
      );
      setState(() {
        guild = guildResponse;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final guildRoleIds = widget.guildRoom.guildRoleIds;
    List<GuildRole> filteredRoles = [];
    if (guild != null) {
      if (guildRoleIds != null) {
        filteredRoles = guild!.roles!
            .where(
              (role) => guildRoleIds.contains(role.id),
            )
            .toList();
      } else {
        filteredRoles = guild!.roles!;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Spacing.xSmall,
                right: Spacing.xSmall,
                top: Spacing.large,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.chat.guild.citizenOnlyAccess,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.chat.guild.citizenOnlyAccessDescription,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: Spacing.medium,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: filteredRoles.length,
                          itemBuilder: (context, index) {
                            return GuildRoleItem(
                              guildRole: filteredRoles[index],
                              onTap: () {
                                final w3mService =
                                    getIt<WalletConnectService>().w3mService;
                                w3mService.openModal(context);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: Spacing.xSmall,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // FutureBuilder<List<GuildRolePermission>>(
                  //   future: GuildUtils.checkUserAccessToAGuild(
                  //     widget.guildRoom.guildId ?? 0,
                  //     getIt<WalletConnectService>().w3mService.address ?? '',
                  //   ),
                  //   builder: (context, snapshot) {
                  //     final guildRolePermissions = snapshot.data;
                  //     List<GuildRole> filteredRoles = guild.roles != null
                  //         ? guildRoleIds != null
                  //             ? guild.roles!
                  //                 .where(
                  //                   (role) => guildRoleIds.contains(role.id),
                  //                 )
                  //                 .toList()
                  //             : guild.roles!
                  //         : [];
                  //       ],
                  // );
                  // },
                  // ),
                ],
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: Spacing.smMedium,
                horizontal: Spacing.xSmall,
              ),
              child: Opacity(
                opacity: 1,
                child: LinearGradientButton.primaryButton(
                  onTap: () {
                    widget.onEnterChannel();
                  },
                  label: t.chat.guild.enterChannel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
