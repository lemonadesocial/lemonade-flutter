import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/widgets/add_recurring_dates_list_widget.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/widgets/select_subevent_timezone_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/timezone.dart' as tz;

@RoutePage()
class CreateDuplicatedSubEventsPage extends StatefulWidget {
  final Event subEvent;
  const CreateDuplicatedSubEventsPage({
    super.key,
    required this.subEvent,
  });

  @override
  State<CreateDuplicatedSubEventsPage> createState() =>
      _CreateDuplicatedSubEventsPageState();
}

class _CreateDuplicatedSubEventsPageState
    extends State<CreateDuplicatedSubEventsPage> {
  List<DateTime> dates = [];
  late String timezone;
  bool private = false;

  @override
  void initState() {
    super.initState();
    timezone = widget.subEvent.timezone ?? '';
    final now = DateTime.now().toUtc();
    DateTime startDate = tz.TZDateTime.from(now, tz.getLocation(timezone)).add(
      const Duration(days: 1),
    );

    startDate = tz.TZDateTime(
      location,
      startDate.year,
      startDate.month,
      startDate.day,
      startDate.hour,
      startDate.hour,
    );
    dates = [startDate];
  }

  tz.Location get location => tz.getLocation(timezone);

  void _updateDatesByTimezone() {
    setState(() {
      dates = dates
          .map(
            (date) => tz.TZDateTime(
              location,
              date.year,
              date.month,
              date.day,
              date.hour,
              date.minute,
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const LemonAppBar(
                title: '',
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${t.event.sessionDuplication.duplicate} ${widget.subEvent.title ?? ''}',
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          t.event.sessionDuplication
                              .duplicateSessionDescription,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                        _GeneralInfoAndPrivacySettingWidget(
                          subEvent: widget.subEvent,
                          private: private,
                          onPrivacyChanged: (value) {
                            setState(() {
                              private = value;
                            });
                          },
                        ),
                        SizedBox(height: Spacing.medium),
                        AddRecurringDatesListWidget(
                          timezone: timezone,
                          subEvent: widget.subEvent,
                          dates: dates,
                          onDatesChanged: (mDates) {
                            setState(() {
                              dates = mDates;
                            });
                          },
                        ),
                        SizedBox(height: Spacing.medium),
                        SelectSubEventTimezoneWidget(
                          timezone: timezone,
                          onTimezoneChanged: (timezoneValue) {
                            setState(() {
                              timezone = timezoneValue;
                            });
                            _updateDatesByTimezone();
                          },
                        ),
                        SizedBox(height: 124.w),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                left: Spacing.small,
                right: Spacing.small,
                top: Spacing.smMedium,
              ),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: LinearGradientButton.primaryButton(
                  label: t.event.sessionDuplication.duplicateSession,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GeneralInfoAndPrivacySettingWidget extends StatelessWidget {
  final Event subEvent;
  final bool private;
  final Function(bool) onPrivacyChanged;
  const _GeneralInfoAndPrivacySettingWidget({
    required this.subEvent,
    required this.private,
    required this.onPrivacyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.sessionDuplication.sessionOf,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(Spacing.small),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(
                    color: colorScheme.outline,
                  ),
                ),
                child: Row(
                  children: [
                    LemonNetworkImage(
                      width: 18.w,
                      height: 18.w,
                      borderRadius: BorderRadius.circular(4.r),
                      imageUrl: subEvent.subeventParentExpanded != null
                          ? EventUtils.getEventThumbnailUrl(
                              event: subEvent.subeventParentExpanded!,
                            )
                          : '',
                      placeholder: ImagePlaceholder.eventCard(),
                    ),
                    SizedBox(width: Spacing.small),
                    Flexible(
                      child: Text(
                        subEvent.subeventParentExpanded?.title ?? '',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: _PrivacySettingDropdown(
                private: private,
                onChanged: onPrivacyChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PrivacySettingDropdown extends StatelessWidget {
  final bool private;
  final Function(bool) onChanged;
  const _PrivacySettingDropdown({
    required this.private,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconPublic = ThemeSvgIcon(
      color: colorScheme.onSecondary,
      builder: (filter) => Assets.icons.icPublic.svg(
        colorFilter: filter,
        width: 18.w,
        height: 18.w,
      ),
    );
    final iconPrivate = ThemeSvgIcon(
      color: colorScheme.onSecondary,
      builder: (filter) => Assets.icons.icPrivate.svg(
        colorFilter: filter,
        width: 18.w,
        height: 18.w,
      ),
    );
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<bool>(
          value: private,
          onChanged: (value) {
            onChanged.call(value ?? false);
          },
          customButton: Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              color: LemonColor.atomicBlack,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (private) iconPrivate else iconPublic,
                Assets.icons.icDoubleArrowUpDown.svg(
                  color: colorScheme.onSecondary,
                ),
              ],
            ),
          ),
          items: [
            DropdownMenuItem<bool>(
              value: false,
              child: _PrivacyOptionWidget(
                icon: iconPublic,
                title: t.event.sessionDuplication.public,
                description: t.event.sessionDuplication.publicDescription,
              ),
            ),
            DropdownMenuItem<bool>(
              value: true,
              child: _PrivacyOptionWidget(
                icon: iconPrivate,
                title: t.event.sessionDuplication.private,
                description: t.event.sessionDuplication.privateDescription,
              ),
            ),
          ],
          dropdownStyleData: DropdownStyleData(
            width: 235.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              color: LemonColor.atomicBlack,
            ),
            offset: Offset(0, -Spacing.superExtraSmall),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 84.w,
            padding: EdgeInsets.zero,
            overlayColor: const MaterialStatePropertyAll(
              LemonColor.darkBackground,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrivacyOptionWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const _PrivacyOptionWidget({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(Spacing.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: Spacing.xSmall),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  description,
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
