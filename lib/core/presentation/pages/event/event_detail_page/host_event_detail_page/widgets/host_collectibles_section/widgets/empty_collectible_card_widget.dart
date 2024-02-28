import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EmptyCollectibleCardWidget extends StatelessWidget {
  const EmptyCollectibleCardWidget({
    super.key,
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
                        color: colorScheme.onPrimary.withOpacity(0.06),
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
                        color: colorScheme.onPrimary.withOpacity(0.06),
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
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
                SizedBox(
                  height: Spacing.xSmall,
                ),
                InkWell(
                  onTap: () {
                    Vibrate.feedback(FeedbackType.light);
                    showComingSoonDialog(context);
                  },
                  child: LinearGradientButton(
                    width: 134.w,
                    label: t.event.addCollectible,
                    trailing: ThemeSvgIcon(
                      builder: (filter) =>
                          Assets.icons.icSendMessage.svg(colorFilter: filter),
                    ),
                    mode: GradientButtonMode.lavenderMode,
                    radius: BorderRadius.circular(LemonRadius.normal),
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.xSmall,
                      vertical: 9.h,
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
