import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage<bool>()
class LocationRequestPage extends StatelessWidget {
  final Function()? onPermissionDeniedForever;
  const LocationRequestPage({
    super.key,
    this.onPermissionDeniedForever,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: RippleAnimation(
                    color: LemonColor.rippleDark,
                    size: 300,
                  ),
                ),
                Assets.icons.icLocationSolid.svg(),
              ],
            ),
            SizedBox(height: Spacing.xSmall * 5),
            Text(
              t.common.locationRequest.title,
              style: Typo.extraLarge.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: FontFamily.nohemiVariable,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Spacing.smMedium),
            Text(
              t.common.locationRequest.description,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SafeArea(
              child: LinearGradientButton(
                label: t.common.actions.setLocation,
                textStyle: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nohemiVariable,
                ),
                radius: BorderRadius.circular(LemonRadius.small * 2),
                height: Sizing.small * 2,
                mode: GradientButtonMode.lavenderMode,
                onTap: () async {
                  final result =
                      await getIt<LocationUtils>().checkAndRequestPermission(
                    onPermissionDeniedForever: onPermissionDeniedForever,
                  );
                  context.router.pop<bool>(result);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
