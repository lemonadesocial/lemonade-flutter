import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../i18n/i18n.g.dart';

@RoutePage()
class OnboardingInterestPage extends StatelessWidget {
  const OnboardingInterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          t.onboarding.pickUsername,
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: Spacing.extraSmall),
        Text(
          t.onboarding.pickUsernameDesc,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
