import 'package:app/core/presentation/widgets/common/circular_loading/circular_loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestEventApplicationFormLoadingView extends StatelessWidget {
  const GuestEventApplicationFormLoadingView({super.key});

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
          const CircularLoading(),
          const Spacer(),
          Column(
            children: [
              Text(
                t.event.applicationForm.updatingProfile,
                style: Typo.extraLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.nohemiVariable,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.event.applicationForm.updatingProfileDescription,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.large)
            ],
          ),
        ],
      ),
    );
  }
}
