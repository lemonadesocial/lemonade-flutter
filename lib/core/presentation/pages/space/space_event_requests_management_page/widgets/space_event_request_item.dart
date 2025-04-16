import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SpaceEventRequestItem extends StatelessWidget {
  const SpaceEventRequestItem({
    super.key,
    required this.request,
    this.onApprove,
    this.onDecline,
  });

  final SpaceEventRequest request;
  final Function(SpaceEventRequest)? onApprove;
  final Function(SpaceEventRequest)? onDecline;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = request.eventExpanded;
    if (event == null) {
      return const SizedBox.shrink();
    }
    final dateFormat = DateFormat('EEE, dd MMM');
    final timeFormat = DateFormat('h:mm a');
    final eventDate = event.start != null
        ? '${dateFormat.format(event.start!)} • ${timeFormat.format(event.start!)}'
        : '--';
    final isVirtual = event.virtual ?? false;
    final location =
        isVirtual ? t.event.virtual : EventUtils.getAddress(event: event);
    final guestCount = (event.guests ?? 0).toInt();
    final attendeeCount = '$guestCount ${t.common.guest(n: guestCount)}';

    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title ?? '',
                            style: Typo.mediumPlus.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder(
                            future: request.createdBy?.isNotEmpty == true
                                ? getIt<UserRepository>().getUserProfile(
                                    GetProfileInput(
                                      id: request.createdBy,
                                    ),
                                  )
                                : Future.value(null),
                            builder: (context, snapshot) {
                              final user = snapshot.data?.fold(
                                (l) => null,
                                (user) => user,
                              );
                              return Text(
                                '${t.space.submittedBy} ${user?.displayName ?? user?.name ?? '--'}',
                                style: Typo.small.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.extraSmall),
                      // Event info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date
                          Row(
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (colorFilter) =>
                                    Assets.icons.icCalendar.svg(
                                  colorFilter: colorFilter,
                                ),
                              ),
                              SizedBox(width: Spacing.extraSmall),
                              Expanded(
                                child: Text(
                                  eventDate,
                                  style: Typo.small
                                      .copyWith(color: colorScheme.onSecondary),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.superExtraSmall),
                          // Location
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (colorFilter) => isVirtual
                                    ? Assets.icons.icLive.svg(
                                        colorFilter: colorFilter,
                                        width: 16.w,
                                        height: 16.w,
                                      )
                                    : Assets.icons.icLocationPin.svg(
                                        colorFilter: colorFilter,
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                              ),
                              SizedBox(width: Spacing.extraSmall),
                              Expanded(
                                child: Text(
                                  location,
                                  style: Typo.small.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.superExtraSmall),
                          // Attendees
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (colorFilter) =>
                                    Assets.icons.icGuests.svg(
                                  colorFilter: colorFilter,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                              SizedBox(width: Spacing.extraSmall),
                              Expanded(
                                child: Text(
                                  attendeeCount,
                                  style: Typo.small.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Spacing.small),
                LemonNetworkImage(
                  width: 90.w,
                  height: 90.w,
                  imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                  fit: BoxFit.cover,
                  placeholder: ImagePlaceholder.eventCard(),
                  borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outlineVariant,
          ),
          if (request.state == Enum$SpaceEventRequestState.approved ||
              request.state == Enum$SpaceEventRequestState.declined)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.small,
              ),
              child: Row(
                children: [
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) =>
                        request.state == Enum$SpaceEventRequestState.approved
                            ? Assets.icons.icDone.svg(
                                width: 16.w,
                                height: 16.w,
                                colorFilter: colorFilter,
                              )
                            : Assets.icons.icClose.svg(
                                width: 16.w,
                                height: 16.w,
                                colorFilter: colorFilter,
                              ),
                  ),
                  SizedBox(width: Spacing.extraSmall),
                  FutureBuilder(
                    future: request.decidedBy?.isNotEmpty == true
                        ? getIt<UserRepository>().getUserProfile(
                            GetProfileInput(
                              id: request.decidedBy,
                            ),
                          )
                        : Future.value(null),
                    builder: (context, snapshot) {
                      final user = snapshot.data?.fold(
                        (l) => null,
                        (user) => user,
                      );
                      final actionText =
                          request.state == Enum$SpaceEventRequestState.approved
                              ? t.space.approvedBy
                              : t.space.declinedBy;
                      final name = user?.displayName ?? user?.name ?? '--';
                      return Text(
                        '$actionText $name',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          if (request.state == Enum$SpaceEventRequestState.pending)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.small,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: LemonOutlineButton(
                      label: t.space.approve,
                      leading: ThemeSvgIcon(
                        color: LemonColor.malachiteGreen,
                        builder: (colorFilter) => Assets.icons.icDone.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                      onTap:
                          onApprove != null ? () => onApprove!(request) : null,
                      textStyle: Typo.small.copyWith(
                        color: LemonColor.malachiteGreen,
                      ),
                      backgroundColor:
                          LemonColor.malachiteGreen.withOpacity(0.18),
                    ),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  Expanded(
                    child: LemonOutlineButton(
                      label: t.space.decline,
                      leading: ThemeSvgIcon(
                        color: LemonColor.coralReef,
                        builder: (colorFilter) => Assets.icons.icClose.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                      onTap:
                          onDecline != null ? () => onDecline!(request) : null,
                      textStyle: Typo.small.copyWith(
                        color: LemonColor.coralReef,
                      ),
                      backgroundColor: LemonColor.coralReef.withOpacity(0.18),
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
