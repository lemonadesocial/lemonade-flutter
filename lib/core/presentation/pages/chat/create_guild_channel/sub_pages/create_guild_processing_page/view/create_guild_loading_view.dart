import 'package:app/core/presentation/widgets/animation/circular_loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CreateGuildLoadingView extends StatelessWidget {
  const CreateGuildLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          const CircularLoadingWidget(),
          const Spacer(),
          Column(
            children: [
              Text(
                t.chat.guild.creatingChannel,
                style: Typo.extraLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.clashDisplay,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.chat.guild.creatingChannelDescription,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.large),
            ],
          ),
        ],
      ),
    );
  }
}
