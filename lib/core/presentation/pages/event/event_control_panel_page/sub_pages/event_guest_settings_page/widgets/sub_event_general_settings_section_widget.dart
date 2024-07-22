import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_guest_settings_page/sub_pages/sub_event_detail_settings_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SubEventGeneralSettingsSectionWidget extends StatelessWidget {
  final bool subEventEnabled;
  final SubEventSettings? subEventSettings;
  final Function(bool value) onSubEventEnabledChanged;
  final Function(SubEventSettings? subEventSettings)? onSubEventSettingsChanged;

  const SubEventGeneralSettingsSectionWidget({
    super.key,
    required this.subEventEnabled,
    this.subEventSettings,
    required this.onSubEventEnabledChanged,
    required this.onSubEventSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.subEvent.subEvents,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.small),
        SettingTileWidget(
          title: t.event.subEventSettings.allowSubEvent,
          subTitle: t.event.subEventSettings.allowSubEventDescription,
          onTap: () {},
          color: LemonColor.chineseBlack,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(LemonRadius.medium),
            topRight: Radius.circular(LemonRadius.medium),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          trailing: FlutterSwitch(
            inactiveColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            activeColor: LemonColor.malachiteGreen,
            height: 24.w,
            width: 42.w,
            onToggle: (value) {
              onSubEventEnabledChanged(value);
            },
            value: subEventEnabled,
          ),
        ),
        Divider(
          color: colorScheme.outline,
          height: 0,
          thickness: 0.5.w,
        ),
        SettingTileWidget(
          title: t.event.subEventSettings.subEventSettings,
          titleStyle: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(LemonRadius.medium),
            bottomRight: Radius.circular(LemonRadius.medium),
            topLeft: Radius.zero,
            topRight: Radius.zero,
          ),
          color: LemonColor.chineseBlack,
          trailing: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowRight.svg(
              colorFilter: filter,
            ),
          ),
          onTap: () {
            showCupertinoModalBottomSheet(
              context: context,
              expand: true,
              builder: (context) {
                return BlocBuilder<EventGuestSettingsBloc,
                    EventGuestSettingState>(
                  builder: (context, state) {
                    return SubEventDetailSettingsPage(
                      subEventSettings: state.subEventSettings,
                      onSubEventSettingsChanged: onSubEventSettingsChanged,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
