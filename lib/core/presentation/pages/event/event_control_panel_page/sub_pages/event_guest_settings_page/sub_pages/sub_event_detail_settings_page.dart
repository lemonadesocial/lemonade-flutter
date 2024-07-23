import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/sub_events_listing_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SubEventDetailSettingsPage extends StatelessWidget {
  final Event? event;
  final SubEventSettings? subEventSettings;
  final Function(SubEventSettings? subEventSettings)? onSubEventSettingsChanged;

  const SubEventDetailSettingsPage({
    super.key,
    this.event,
    this.subEventSettings,
    this.onSubEventSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        title: t.event.subEventSettings.subEventSettings,
        backgroundColor: LemonColor.atomicBlack,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingTileWidget(
                  title: t.event.subEventSettings.requireTicketToCreate,
                  subTitle:
                      t.event.subEventSettings.requireTicketToCreateDescription,
                  onTap: () {},
                  color: LemonColor.chineseBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(LemonRadius.medium),
                    topRight: Radius.circular(LemonRadius.medium),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  trailing: FlutterSwitch(
                    inactiveColor: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.12),
                    activeColor: LemonColor.malachiteGreen,
                    height: 24.w,
                    width: 42.w,
                    onToggle: (value) {
                      final payload = (subEventSettings ??
                              SubEventSettings(
                                ticketRequiredForCreation: false,
                                ticketRequiredForPurchase: false,
                              ))
                          .copyWith(
                        ticketRequiredForCreation: value,
                      );
                      onSubEventSettingsChanged?.call(
                        payload,
                      );
                    },
                    value: subEventSettings?.ticketRequiredForCreation ?? false,
                  ),
                ),
                Divider(
                  color: colorScheme.outline,
                  height: 0,
                  thickness: 0.5.w,
                ),
                SettingTileWidget(
                  title: t.event.subEventSettings.requireTicketToAttend,
                  subTitle:
                      t.event.subEventSettings.requireTicketToAttendDescription,
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
                  trailing: FlutterSwitch(
                    inactiveColor: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.12),
                    activeColor: LemonColor.malachiteGreen,
                    height: 24.w,
                    width: 42.w,
                    onToggle: (value) {
                      final payload = (subEventSettings ??
                              SubEventSettings(
                                ticketRequiredForCreation: false,
                                ticketRequiredForPurchase: false,
                              ))
                          .copyWith(
                        ticketRequiredForPurchase: value,
                      );
                      onSubEventSettingsChanged?.call(
                        payload,
                      );
                    },
                    value: subEventSettings?.ticketRequiredForPurchase ?? false,
                  ),
                  onTap: () {},
                ),
                SizedBox(height: Spacing.medium),
                if (event != null &&
                    (event?.subeventParent == null ||
                        event?.subeventParent?.isEmpty == true))
                  SettingTileWidget(
                    title: t.event.subEventSettings.viewSubEvents,
                    color: LemonColor.chineseBlack,
                    trailing: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        expand: true,
                        builder: ((context) {
                          return SubEventsListingPage(
                            parentEventId: event?.id ?? '',
                            backgroundColor: LemonColor.atomicBlack,
                          );
                        }),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
