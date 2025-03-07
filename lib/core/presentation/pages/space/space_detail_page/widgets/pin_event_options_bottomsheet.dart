import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum PinEventOptions {
  newEvent,
  existingEvent,
  externalEvent;

  SvgGenImage get icon {
    switch (this) {
      case PinEventOptions.newEvent:
        return Assets.icons.icCreate;
      case PinEventOptions.existingEvent:
        return Assets.icons.icHouseParty;
      case PinEventOptions.externalEvent:
        return Assets.icons.icGlobe;
    }
  }

  String get contentKey {
    switch (this) {
      case PinEventOptions.newEvent:
        return t.space.pinEventOptions.newEvent;
      case PinEventOptions.existingEvent:
        return t.space.pinEventOptions.existingEvent;
      case PinEventOptions.externalEvent:
        return t.space.pinEventOptions.externalEvent;
    }
  }
}

class PinEventOptionsBottomsheet extends StatelessWidget {
  static Future<PinEventOptions?> show(BuildContext context) {
    return showCupertinoModalBottomSheet<PinEventOptions>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => const PinEventOptionsBottomsheet(),
    );
  }

  const PinEventOptionsBottomsheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: BottomSheetGrabber(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.space.submitEvent,
                style: Typo.extraLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.space.submitEventDescription,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: Spacing.medium),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final option = PinEventOptions.values[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Spacing.small),
                      decoration: BoxDecoration(
                        color: LemonColor.chineseBlack,
                        borderRadius: BorderRadius.circular(LemonRadius.small),
                      ),
                      child: Row(
                        children: [
                          ThemeSvgIcon(
                            builder: (filter) => option.icon.svg(
                              colorFilter: filter,
                              width: 18.w,
                              height: 18.w,
                            ),
                            color: colorScheme.onSecondary,
                          ),
                          SizedBox(width: Spacing.smMedium),
                          Text(
                            option.contentKey,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.small),
                itemCount: PinEventOptions.values.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
