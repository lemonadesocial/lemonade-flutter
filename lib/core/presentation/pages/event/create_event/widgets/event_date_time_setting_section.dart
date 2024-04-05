import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/timezone_select_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_datetime_settings_page/event_datetime_settings_page.dart';
import 'package:app/core/presentation/widgets/common/circle_dot_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

class EventDateTimeSettingSection extends StatelessWidget {
  const EventDateTimeSettingSection({super.key, this.event});
  final Event? event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: LemonColor.atomicBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.small),
                topRight: Radius.circular(LemonRadius.small),
                bottomLeft: Radius.circular(LemonRadius.extraSmall),
                bottomRight: Radius.circular(LemonRadius.extraSmall),
              ),
            ),
          ),
          child: BlocBuilder<EventDateTimeSettingsBloc,
              EventDateTimeSettingsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DateTimeRowItem(
                    color: LemonColor.malachiteGreen,
                    text: t.event.datetimeSettings.starts,
                    date: date_utils.DateUtils.formatForDateSetting(
                      state.start.value != null
                          ? state.start.value!
                          : DateTime.now(),
                    ),
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        backgroundColor: LemonColor.atomicBlack,
                        context: context,
                        enableDrag: false,
                        builder: (innerContext) =>
                            const EventDatetimeSettingsPage(
                          expandedStarts: true,
                          expandedEnds: false,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Spacing.smMedium),
                  _DateTimeRowItem(
                    color: LemonColor.coralReef,
                    text: t.event.datetimeSettings.ends,
                    date: date_utils.DateUtils.formatForDateSetting(
                      state.end.value != null
                          ? state.end.value!
                          : DateTime.now(),
                    ),
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        backgroundColor: LemonColor.atomicBlack,
                        context: context,
                        enableDrag: false,
                        builder: (innerContext) =>
                            const EventDatetimeSettingsPage(
                          expandedStarts: false,
                          expandedEnds: true,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: Spacing.superExtraSmall,
        ),
        InkWell(
          onTap: () {
            showCupertinoModalBottomSheet(
              bounce: true,
              backgroundColor: LemonColor.atomicBlack,
              context: context,
              enableDrag: false,
              builder: (newContext) {
                return TimezoneSelectBottomSheet(
                  event: event,
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(Spacing.xSmall),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: LemonColor.atomicBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(LemonRadius.extraSmall),
                  topRight: Radius.circular(LemonRadius.extraSmall),
                  bottomLeft: Radius.circular(LemonRadius.small),
                  bottomRight: Radius.circular(LemonRadius.small),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Assets.icons.icGlobe.svg(),
                        SizedBox(
                          width: Spacing.smMedium / 2,
                        ),
                        Text(
                          t.event.timezoneSetting.timezone,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Spacing.superExtraSmall,
                    ),
                    BlocBuilder<EventDateTimeSettingsBloc,
                        EventDateTimeSettingsState>(
                      builder: (context, state) {
                        final timezoneText =
                            EventConstants.timezoneOptions.toList().firstWhere(
                                      (element) =>
                                          element['value'] == state.timezone,
                                      orElse: () => {},
                                    )['text'] ??
                                '';
                        return Row(
                          children: [
                            Text(
                              timezoneText,
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Assets.icons.icArrowUpDown.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateTimeRowItem extends StatelessWidget {
  const _DateTimeRowItem({
    required this.color,
    required this.text,
    required this.date,
    required this.onTap,
  });
  final Color color;
  final String text;
  final String date;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleDot(color: color),
          SizedBox(width: 15.w),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                Text(
                  date,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
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
