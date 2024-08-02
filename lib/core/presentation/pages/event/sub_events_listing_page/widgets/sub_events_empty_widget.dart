import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventsEmptyWidget extends StatelessWidget {
  const SubEventsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.icons.icCalendarGradient.svg(),
        SizedBox(height: Spacing.medium),
        Text(
          t.event.subEvent.sessionsEmptyTitle,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          t.event.subEvent.sessionEmptyDescription,
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Spacing.medium),
        SizedBox(
          width: 115.w,
          child: LemonOutlineButton(
            radius: BorderRadius.circular(LemonRadius.button),
            backgroundColor: LemonColor.chineseBlack,
            borderColor: Colors.transparent,
            label: t.event.subEvent.createSession,
            textStyle: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
