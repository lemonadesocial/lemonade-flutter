import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateGuildSuccessView extends StatelessWidget {
  const CreateGuildSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(),
        SuccessCircleAnimationWidget(
          successWidget: Assets.icons.icSuccessGrey.svg(),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${t.chat.guild.channelCreated}!',
                style: Typo.extraLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.chat.guild.channelCreatedDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: Spacing.medium),
        Container(
          padding: EdgeInsets.only(
            top: Spacing.smMedium,
            left: Spacing.smMedium,
            right: Spacing.smMedium,
          ),
          child: Row(
            children: [
              Expanded(
                child: LinearGradientButton.primaryButton(
                  onTap: () async {
                    AutoRouter.of(context).replace(const ChatListRoute());
                  },
                  label: t.chat.guild.viewChannel,
                  textColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
