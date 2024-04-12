import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_channel_access_page.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/i18n/i18n.g.dart';
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
        title: t.chat.guild.communityGated,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: const CustomScrollView(
                  slivers: [],
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
                        AutoRouter.of(context).navigate(
                          const CreateGuildChannelAccessRoute(),
                        );
                      },
                      label: t.common.next,
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
