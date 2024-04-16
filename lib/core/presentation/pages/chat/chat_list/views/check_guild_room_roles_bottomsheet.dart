import 'package:app/core/application/chat/check_guild_room_roles_bloc/check_guild_room_roles_bloc.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/widgets/guild_role_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckGuildRoomRolesBottomSheet extends StatelessWidget {
  final Function() onEnterChannel;
  final GuildRoom guildRoom;

  const CheckGuildRoomRolesBottomSheet({
    super.key,
    required this.guildRoom,
    required this.onEnterChannel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckGuildRoomRolesBloc(guildRoom: guildRoom)
        ..add(
          CheckGuildRoomRolesEventFetch(),
        ),
      child: const CheckGuildRoomRolesBottomSheetView(),
    );
  }
}

class CheckGuildRoomRolesBottomSheetView extends StatelessWidget {
  const CheckGuildRoomRolesBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

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
                      BlocBuilder<CheckGuildRoomRolesBloc,
                          CheckGuildRoomRolesState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            success: (roles) => ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 300),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: roles.length,
                                itemBuilder: (context, index) {
                                  return GuildRoleItem(
                                    guildRole: roles[index],
                                    onTap: () {
                                      final w3mService =
                                          getIt<WalletConnectService>()
                                              .w3mService;
                                      w3mService.openModal(context);
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: Spacing.xSmall,
                                  );
                                },
                              ),
                            ),
                            loading: () => Center(
                              child: Loading.defaultLoading(context),
                            ),
                            orElse: () => Center(
                              child: Text(t.common.somethingWrong),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
                  onTap: () {},
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
