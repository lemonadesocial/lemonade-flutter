import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AddMoreCollectibleCardWidget extends StatelessWidget {
  const AddMoreCollectibleCardWidget({
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
      child: InkWell(
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          SnackBarUtils.showComingSoon();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThemeSvgIcon(
                builder: (colorFilter) => Assets.icons.icGiftOutline.svg(),
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                child: Text(
                  t.event.collectibles.addAnotherCollectble,
                  textAlign: TextAlign.center,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
