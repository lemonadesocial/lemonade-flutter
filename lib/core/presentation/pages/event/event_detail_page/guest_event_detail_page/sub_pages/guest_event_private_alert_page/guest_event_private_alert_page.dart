import 'package:app/core/presentation/widgets/animation/circular_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GuestEventPrivateAlertPage extends StatelessWidget {
  const GuestEventPrivateAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const LemonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularAnimationWidget(
            icon: Assets.icons.icLockGradient.svg(),
          ),
          const Spacer(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.event.eventPrivate.eventPrivateTitle,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.clashDisplay,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.eventPrivate.eventPrivateErrorDescription,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Spacing.xSmall * 2.5),
                  LinearGradientButton.secondaryButton(
                    onTap: () => AutoRouter.of(context).pop(),
                    label: t.common.gotIt,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
