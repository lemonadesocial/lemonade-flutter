import 'package:app/core/application/chat/create_guild_channel_bloc/create_guild_channel_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class CreateGuildChannelBasePage extends StatelessWidget {
  const CreateGuildChannelBasePage({super.key});

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
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                  vertical: Spacing.superExtraSmall,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        t.chat.guild.createChannel,
                        style: Typo.large.copyWith(
                          fontSize: 26,
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: Spacing.superExtraSmall),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        t.chat.guild.createChannelDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    SliverToBoxAdapter(
                      child: LemonTextField(
                        hintText: t.chat.guild.createChannel,
                        onChange: (value) =>
                            context.read<CreateGuildChannelBloc>().add(
                                  CreateGuildChannelEventChannelNameChanged(
                                    channelName: value,
                                  ),
                                ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: Spacing.xSmall),
                    ),
                    SliverToBoxAdapter(
                      child: LemonTextField(
                        hintText: t.chat.guild.topicOfDiscussion,
                        maxLines: 5,
                        onChange: (value) =>
                            context.read<CreateGuildChannelBloc>().add(
                                  CreateGuildChannelEventTopicChanged(
                                    topic: value,
                                  ),
                                ),
                      ),
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
                  child: BlocBuilder<CreateGuildChannelBloc,
                      CreateGuildChannelState>(
                    builder: (context, state) => Opacity(
                      opacity: state.isValid ? 1 : 0.5,
                      child: LinearGradientButton.primaryButton(
                        onTap: () {
                          if (!state.isValid) return;
                          Vibrate.feedback(FeedbackType.light);
                          FocusManager.instance.primaryFocus?.unfocus();
                          AutoRouter.of(context).navigate(
                            const CreateGuildChannelCommunityGatedRoute(),
                          );
                        },
                        label: t.common.next,
                        textColor: colorScheme.onPrimary,
                      ),
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
