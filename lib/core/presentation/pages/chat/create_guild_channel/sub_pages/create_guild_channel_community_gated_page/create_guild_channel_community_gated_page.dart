import 'package:app/core/application/chat/create_guild_channel_bloc/create_guild_channel_bloc.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_channel_community_gated_page/widgets/guild_list_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class CreateGuildChannelCommunityGatedPage extends StatelessWidget {
  const CreateGuildChannelCommunityGatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        onPressBack: () {
          AutoRouter.of(context).pop();
          context.read<CreateGuildChannelBloc>().add(
                const CreateGuildChannelEventSearchGuilds(
                  searchTerm: '',
                ),
              );
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.chat.guild.communityGated,
                    style: Typo.large.copyWith(
                      fontSize: 26,
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.clashDisplay,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: Spacing.superExtraSmall,
                  ),
                  Text(
                    t.chat.guild.communityGatedDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  LemonTextField(
                    leadingIcon: ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icSearch.svg(
                        colorFilter: filter,
                        width: 15.w,
                        height: 15.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    hintText: t.chat.guild.searchGuilds,
                    contentPadding: EdgeInsets.all(Spacing.small),
                    onChange: (value) {
                      context.read<CreateGuildChannelBloc>().add(
                            CreateGuildChannelEventSearchGuilds(
                              searchTerm: value,
                            ),
                          );
                    },
                    radius: Sizing.large,
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
                  vertical: Spacing.superExtraSmall,
                ),
                child: CustomScrollView(
                  slivers: [
                    BlocBuilder<CreateGuildChannelBloc,
                        CreateGuildChannelState>(
                      builder: (context, state) {
                        if (state.statusFetchGuilds ==
                            CreateGuildChannelStatus.loading) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Loading.defaultLoading(context),
                            ),
                          );
                        }
                        final filteredGuilds = (state.guilds ?? [])
                            .where(
                              (guild) =>
                                  (guild.name ?? '').toLowerCase().contains(
                                        (state.searchTerm ?? '').toLowerCase(),
                                      ),
                            )
                            .toList();
                        return SliverList.separated(
                          itemCount: filteredGuilds.length,
                          itemBuilder: (context, index) {
                            final guild = filteredGuilds[index];
                            return GuildListItem(
                              guildBasic: guild,
                              onTap: () {
                                Vibrate.feedback(FeedbackType.light);
                                FocusManager.instance.primaryFocus?.unfocus();
                                context.read<CreateGuildChannelBloc>().add(
                                      CreateGuildChannelEventSelectGuild(
                                        guildId: guild.id,
                                      ),
                                    );
                                AutoRouter.of(context).navigate(
                                  const CreateGuildChannelAccessRoute(),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: Spacing.superExtraSmall,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
