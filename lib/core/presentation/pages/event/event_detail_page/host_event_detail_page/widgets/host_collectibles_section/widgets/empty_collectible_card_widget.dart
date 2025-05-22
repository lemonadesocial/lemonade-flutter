import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:app/app_theme/app_theme.dart';

class EmptyCollectibleCardWidget extends StatelessWidget {
  const EmptyCollectibleCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return DottedBorder(
      strokeWidth: 2.w,
      color: appColors.pageDivider,
      dashPattern: [8.w],
      borderType: BorderType.RRect,
      radius: Radius.circular(LemonRadius.medium),
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.small,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 133.w,
                      height: 133.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: appColors.cardBg,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Spacing.xSmall,
                    ),
                    Container(
                      width: 133.w,
                      height: 133.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: appColors.cardBg,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 134.h,
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  t.event.addCollectibleDescription,
                  textAlign: TextAlign.center,
                  style: appText.md.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
                SizedBox(
                  height: Spacing.xSmall,
                ),
                InkWell(
                  onTap: () {
                    Vibrate.feedback(FeedbackType.light);
                    SnackBarUtils.showComingSoon();
                  },
                  child: SizedBox(
                    width: 145.w,
                    child: LinearGradientButton.primaryButton(
                      height: Sizing.s8,
                      label: t.event.addCollectible,
                      trailing: ThemeSvgIcon(
                        color: appColors.textPrimary,
                        builder: (filter) =>
                            Assets.icons.icSendMessage.svg(colorFilter: filter),
                      ),
                      radius: BorderRadius.circular(LemonRadius.full),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
