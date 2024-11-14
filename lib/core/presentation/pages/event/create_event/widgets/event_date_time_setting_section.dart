import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/timezone_select_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_datetime_settings_page/event_datetime_settings_page.dart';
import 'package:app/core/presentation/widgets/common/circle_dot_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
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
          padding: EdgeInsets.all(Spacing.small),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: LemonColor.chineseBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LemonRadius.normal),
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
                        builder: (innerContext) => EventDatetimeSettingsPage(
                          event: event,
                          expandedStarts: true,
                          expandedEnds: false,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Spacing.smMedium),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: LemonColor.white06,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    margin: EdgeInsets.only(left: 30.w),
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
                        builder: (innerContext) => EventDatetimeSettingsPage(
                          event: event,
                          expandedStarts: false,
                          expandedEnds: true,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Spacing.smMedium),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: LemonColor.white06,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    margin: EdgeInsets.only(left: 30.w),
                  ),
                  SizedBox(height: Spacing.smMedium),
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
                    child: Row(
                      children: [
                        SizedBox(width: 2.5.w),
                        Assets.icons.icGlobe.svg(),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: BlocBuilder<EventDateTimeSettingsBloc,
                              EventDateTimeSettingsState>(
                            builder: (context, state) {
                              final timezoneText = EventConstants
                                      .timezoneOptions
                                      .toList()
                                      .firstWhere(
                                        (element) =>
                                            element['value'] == state.timezone,
                                        orElse: () => {},
                                      )['text'] ??
                                  '';
                              return Text(
                                timezoneText,
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: ThemeSvgIcon(
                            color: colorScheme.onSurfaceVariant,
                            builder: (filter) => Assets.icons.icArrowRight.svg(
                              colorFilter: filter,
                              width: 18.w,
                              height: 18.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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
                    height: 0,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      date,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: Spacing.smMedium / 2,
                    ),
                    ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icEdit.svg(
                        colorFilter: filter,
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
