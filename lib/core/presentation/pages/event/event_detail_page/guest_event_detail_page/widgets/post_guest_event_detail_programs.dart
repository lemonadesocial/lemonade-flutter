import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_session.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_expand_button.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostGuestEventDetailPrograms extends StatelessWidget {
  final Event event;
  const PostGuestEventDetailPrograms({
    super.key,
    required this.event,
  });

  Map<DateTime, List<EventSession>> get eventProgramsGroupByDate {
    return (event.sessions ?? [])
        .where((element) => element.start != null)
        .groupListsBy(
          (element) => DateTime(
            element.start!.toLocal().year,
            element.start!.toLocal().month,
            element.start!.toLocal().day,
          ).withoutTime,
        );
  }

  DateTime? get dateToDisplay {
    DateTime? dateToDisplay;
    final now = DateTime.now().withoutTime;
    dateToDisplay = eventProgramsGroupByDate.keys.firstWhereOrNull(
      (date) => date.isAfter(now) || date.isAtSameMomentAs(now),
    );
    dateToDisplay ??= eventProgramsGroupByDate.keys.first;

    return dateToDisplay;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.event.program.eventProgram,
                style: Typo.extraMedium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const GuestEventDetailExpandButton(),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          if (dateToDisplay != null) ...[
            Text(
              EventUtils.formatDateWithTimezone(
                dateTime: dateToDisplay ?? DateTime.now(),
                timezone: event.timezone ?? '',
                format: DateTimeFormat.dateOnly,
              ),
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            Builder(
              builder: (context) {
                final programs = (eventProgramsGroupByDate[dateToDisplay] ?? [])
                    .take(2)
                    .toList();
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: programs.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Spacing.xSmall);
                  },
                  itemBuilder: (context, index) {
                    return _ProgramItem(eventSession: programs[index]);
                  },
                );
              },
            ),
            SizedBox(height: Spacing.xSmall),
            InkWell(
              onTap: () {
                AutoRouter.of(context).push(const EventProgramRoute());
              },
              child: Container(
                padding: EdgeInsets.all(Spacing.small),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(
                    color: colorScheme.outline,
                    width: 0.5.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.common.actions.viewAll,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgramItem extends StatelessWidget {
  final EventSession eventSession;
  const _ProgramItem({
    required this.eventSession,
  });

  Widget _buildSpeakersAvatar(ColorScheme colorScheme) {
    final speakers = [
      ...(eventSession.speakerUsersExpanded ?? []),
    ];
    return SizedBox(
      width: (1 + 1 / 2 * (speakers.length - 1)) * Sizing.small,
      height: 20.w,
      child: Stack(
        children: speakers.asMap().entries.map((entry) {
          final file = (entry.value?.newPhotosExpanded?.isNotEmpty == true)
              ? entry.value?.newPhotosExpanded!.first
              : null;
          return Positioned(
            right: entry.key * 12,
            child: Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border.all(
                  color: LemonColor.atomicBlack,
                ),
                borderRadius: BorderRadius.circular(Sizing.small),
              ),
              child: LemonNetworkImage(
                imageUrl: ImageUtils.generateUrl(file: file),
                width: 12.w,
                height: 12.w,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.w),
                ),
                placeholder: ImagePlaceholder.avatarPlaceholder(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outline,
          width: 0.5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${DateFormatUtils.timeOnly(eventSession.start)} - ${DateFormatUtils.timeOnly(eventSession.end)}',
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            eventSession.title ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (eventSession.speakerUsersExpanded?.isNotEmpty == true) ...[
            SizedBox(height: Spacing.xSmall),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icMic.svg(
                        colorFilter: filter,
                      ),
                    ),
                    SizedBox(width: Spacing.extraSmall),
                    Text(
                      ' ${eventSession.speakerUsersExpanded?.length ?? 0} ${t.event.speakers.speakersCountInfo(n: eventSession.speakerUsersExpanded?.length ?? 0)}',
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                _buildSpeakersAvatar(colorScheme),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
