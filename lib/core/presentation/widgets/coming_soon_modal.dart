import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:url_launcher/url_launcher.dart';

class ComingSoonModal extends StatelessWidget {
  final Function onClose;

  const ComingSoonModal({super.key, required this.onClose});

  void onTapClose() {
    Vibrate.feedback(FeedbackType.light);
    onClose();
  }

  void openLink() async {
    const url = 'https://lemonade.social';
    if (await canLaunch(url)) {
      Vibrate.feedback(FeedbackType.light);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Column buildRichText(ColorScheme colorScheme) {
    // Tricky add Column because wanna display entire url inline instead of put everything into RichText
    return Column(
      children: [
        Text(
          t.common.currentlyAvailableOn,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'https://lemonade.social',
                style: Typo.medium.copyWith(
                  color: LemonColor.paleViolet,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    openLink();
                  },
              ),
              TextSpan(
                text: t.common.comingSoonToIOSAndAndroid,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 60.h,
                left: 48.w,
                right: 48.w,
                bottom: 42.h,
              ),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                border: Border.all(
                  color: LemonColor.white06,
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: ShapeDecoration(
                      color: LemonColor.chineseBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Assets.images.icComingSoon.provider(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 42.h,
                  ),
                  Text(
                    t.common.comingSoon,
                    textAlign: TextAlign.center,
                    style: Typo.large.copyWith(
                      color: colorScheme.onPrimary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  buildRichText(colorScheme)
                ],
              ),
            ),
            Positioned(
              top: Spacing.xSmall,
              right: Spacing.xSmall,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onTapClose();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: ThemeSvgIcon(
                    color: Theme.of(context).colorScheme.onSurface,
                    builder: (filter) => Assets.icons.icClose.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
