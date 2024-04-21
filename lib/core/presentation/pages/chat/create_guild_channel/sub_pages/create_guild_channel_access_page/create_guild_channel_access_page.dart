import 'package:app/core/application/chat/create_guild_channel_bloc/create_guild_channel_bloc.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_channel_access_page/widgets/guild_access_info_section.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_channel_access_page/widgets/guild_access_roles_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class CreateGuildChannelAccessPage extends StatelessWidget {
  const CreateGuildChannelAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: const LemonAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
                vertical: Spacing.superExtraSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.chat.guild.access,
                    style: Typo.large.copyWith(
                      fontSize: 26,
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: Spacing.superExtraSmall,
                  ),
                  Text(
                    t.chat.guild.accessDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  BlocBuilder<CreateGuildChannelBloc, CreateGuildChannelState>(
                    builder: (context, state) {
                      return GuildAccessInfoSection(
                        guildDetail: state.guildDetail,
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                ),
                child: CustomScrollView(
                  slivers: [
                    BlocBuilder<CreateGuildChannelBloc,
                        CreateGuildChannelState>(
                      builder: (context, state) {
                        return GuildAccessRolesList(
                          guildDetail: state.guildDetail,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(Spacing.smMedium),
                child: SafeArea(
                  child: Opacity(
                    opacity: 1,
                    child: LinearGradientButton.primaryButton(
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      label: t.chat.guild.createChannel,
                      textColor: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
