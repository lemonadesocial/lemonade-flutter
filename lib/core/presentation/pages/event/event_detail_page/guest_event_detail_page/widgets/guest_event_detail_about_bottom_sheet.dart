import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/html_display/html_display.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailAboutBottomSheet extends StatelessWidget {
  const GuestEventDetailAboutBottomSheet({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonSnapBottomSheet(
      snapSizes: const [0.4, 1],
      maxSnapSize: 1,
      minSnapSize: 0.4,
      defaultSnapSize: 0.4,
      backgroundColor: LemonColor.atomicBlack,
      builder: (scrollController) {
        return SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Spacing.smMedium * 2,
                    left: Spacing.smMedium,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title ?? '',
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      Text(
                        DateFormatUtils.dateWithTimezone(
                          dateTime: event.start ?? DateTime.now(),
                          timezone: event.timezone ?? '',
                          pattern: DateFormatUtils.fullDateFormat,
                        ),
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: Spacing.medium),
              ),
              SliverToBoxAdapter(
                child: GuestEventDetailPhotos(
                  event: event,
                  showTitle: false,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: Spacing.medium),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: HtmlDisplay(htmlContent: event.description ?? ''),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
