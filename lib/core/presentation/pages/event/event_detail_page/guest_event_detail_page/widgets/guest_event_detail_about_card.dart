import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailAboutCard extends StatelessWidget {
  const GuestEventDetailAboutCard({
    super.key,
    required this.event,
  });

  final Event event;

  String get photoUrl {
    if (event.newNewPhotosExpanded == null ||
        event.newNewPhotosExpanded!.isEmpty) {
      return '';
    }

    return ImageUtils.generateUrl(
      file: event.newNewPhotosExpanded?.firstOrNull,
      imageConfig: ImageConfig.eventPhoto,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.medium,
              vertical: Spacing.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.event.aboutTheEvent,
                            style: Typo.extraMedium.copyWith(
                              fontFamily: FontFamily.nohemiVariable,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3.w),
                          Text(
                            '${event.title ?? ''}  •  ${EventUtils.formatDateWithTimezone(
                              dateTime: event.start ?? DateTime.now(),
                              timezone: event.timezone ?? '',
                              format: DateTimeFormat.dateOnly,
                            )}',
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Spacing.extraSmall),
                    InkWell(
                      onTap: () {
                        BottomSheetUtils.showSnapBottomSheet(
                          context,
                          builder: (context) =>
                              GuestEventDetailAboutBottomSheet(event: event),
                        );
                      },
                      child: Container(
                        width: Sizing.medium,
                        height: Sizing.medium,
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.normal),
                        ),
                        child: Center(
                          child: ThemeSvgIcon(
                            color: colorScheme.onSurfaceVariant,
                            builder: (filter) => Assets.icons.icArrowDown.svg(
                              colorFilter: filter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                Text(
                  StringUtils.removeMarkdownSyntax(event.description ?? ''),
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
