import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoBackConfirmationPopup extends StatelessWidget {
  const GoBackConfirmationPopup({
    super.key,
    required this.onConfirmed,
  });
  final Function() onConfirmed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            t.common.areYouSure,
                            style: Typo.extraMedium.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.smMedium),
                      InkWell(
                        onTap: () {
                          AutoRouter.of(context).pop();
                        },
                        child: ThemeSvgIcon(
                          color: colorScheme.outlineVariant,
                          builder: (filter) => Assets.icons.icClose.svg(
                            colorFilter: filter,
                            width: Sizing.small,
                            height: Sizing.small,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    t.common.goBackConfirmationDescription,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.medium),
            LinearGradientButton(
              onTap: () {
                onConfirmed();
                AutoRouter.of(context).pop();
              },
              label: t.common.actions.leave,
              textStyle: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: LemonColor.white87,
              ),
              mode: GradientButtonMode.lavenderMode,
              height: 42.h,
              radius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
          ],
        ),
      ),
    );
  }
}
