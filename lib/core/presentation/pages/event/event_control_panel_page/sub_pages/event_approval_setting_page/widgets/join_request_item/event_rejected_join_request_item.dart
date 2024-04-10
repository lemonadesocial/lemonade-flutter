import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventRejectedJoinRequestItem extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final void Function()? onRefetch;

  const EventRejectedJoinRequestItem({
    super.key,
    required this.eventJoinRequest,
    this.onRefetch,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          EventJoinRequestDetailRoute(
            eventJoinRequest: eventJoinRequest,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(
                LemonRadius.extraSmall,
              ),
            ),
            child: Row(
              children: [
                JoinRequestUserAvatar(
                  user: eventJoinRequest.userExpanded,
                ),
                const Spacer(),
                EventJoinRequestTicketInfoBuilder(
                  eventJoinRequest: eventJoinRequest,
                  builder: ({
                    required totalTicketCount,
                    required displayedTotalCost,
                    required isLoading,
                  }) {
                    return DottedBorder(
                      dashPattern: [5.w],
                      color: colorScheme.outline,
                      borderType: BorderType.RRect,
                      strokeWidth: 2.w,
                      padding: EdgeInsets.all(Spacing.xSmall),
                      radius: Radius.circular(LemonRadius.button),
                      child: Row(
                        children: [
                          ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (colorFilter) => Assets.icons.icTicket.svg(
                              colorFilter: colorFilter,
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                            ),
                          ),
                          SizedBox(width: Spacing.superExtraSmall),
                          Text(
                            '$totalTicketCount',
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
