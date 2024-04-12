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
                        t.chat.guild.access,
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
                        t.chat.guild.accessDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    // Add more UI here,
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
