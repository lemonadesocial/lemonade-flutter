import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EmptyDottedBorderCardWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonLabel;
  final Function()? onTap;

  const EmptyDottedBorderCardWidget({
    super.key,
    this.title,
    this.description,
    this.buttonLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DottedBorder(
      strokeWidth: 2.w,
      color: colorScheme.outline,
      dashPattern: [8.w],
      borderType: BorderType.RRect,
      radius: Radius.circular(LemonRadius.medium),
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.small,
      ),
      child: Stack(
        children: [
          const _Backdrop(),
          Container(
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: Typo.extraMedium.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.clashDisplay,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: Spacing.smMedium / 2,
                  ),
                ],
                if (description != null) ...[
                  Text(
                    description!,
                    textAlign: TextAlign.center,
                    style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  ),
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
                ],
                if (buttonLabel != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Vibrate.feedback(FeedbackType.light);
                          onTap?.call();
                        },
                        child: LinearGradientButton.primaryButton(
                          height: Sizing.medium,
                          label: buttonLabel ?? '',
                          trailing: ThemeSvgIcon(
                            builder: (filter) => Assets.icons.icSendMessage
                                .svg(colorFilter: filter),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Backdrop extends StatelessWidget {
  const _Backdrop();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Spacing.medium,
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
