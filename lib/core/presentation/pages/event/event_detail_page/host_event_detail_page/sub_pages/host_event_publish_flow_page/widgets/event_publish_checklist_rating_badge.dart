import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/helper/event_publish_helper.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/host_event_publish_flow_page.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPublishChecklistRatingBadge extends StatelessWidget {
  final EventPublishRating rating;
  final int score;
  const EventPublishChecklistRatingBadge({
    super.key,
    required this.rating,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonOutlineButton(
      radius: BorderRadius.circular(LemonRadius.normal),
      leading: Container(
        width: Sizing.xSmall,
        height: Sizing.xSmall,
        decoration: BoxDecoration(
          color: EventPublishHelper.colorByRating[rating]!.withOpacity(0.3),
          borderRadius: BorderRadius.circular(
            Sizing.xSmall,
          ),
        ),
        child: Center(
          child: Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: EventPublishHelper.colorByRating[rating],
              borderRadius: BorderRadius.circular(
                6.w,
              ),
            ),
          ),
        ),
      ),
      label: "${StringUtils.capitalize(rating.name)}  •  $score/8",
      textStyle: Typo.small.copyWith(
        color: colorScheme.onSecondary,
      ),
    );
  }
}
