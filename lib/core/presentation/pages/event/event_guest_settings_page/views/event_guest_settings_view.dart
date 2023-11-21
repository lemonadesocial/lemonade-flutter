import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum EventPrivacy { public, private }

class EventGuestSettingsView extends StatelessWidget {
  const EventGuestSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: colorScheme.onPrimaryContainer,
          title: t.event.eventCreation.guestSettings,
        ),
        backgroundColor: colorScheme.onPrimaryContainer,
        body: _buildContent(colorScheme),
      ),
    );
  }

  _buildContent(ColorScheme colorScheme) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
          ),
          width: double.maxFinite,
          child: SegmentedButton(
            segments: [
              ButtonSegment(
                value: EventPrivacy.public.name,
                label: const Text("Public"),
                icon: const Icon(Icons.visibility_off_outlined),
              ),
              ButtonSegment(
                value: EventPrivacy.private.name,
                label: const Text("Private"),
                icon: const Icon(Icons.visibility_outlined),
              )
            ],
            selected: {EventPrivacy.public.name},
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
          ),
          child: Column(
            children: [
              SizedBox(height: Spacing.small),
              SettingTileWidget(
                title: "Auto Approve",
                subTitle: "All request to join instantly approved",
                onTap: () => {},
                trailing: FlutterSwitch(
                  inactiveColor: colorScheme.onPrimary.withOpacity(0.12),
                  inactiveToggleColor: colorScheme.onPrimary.withOpacity(0.18),
                  activeColor: LemonColor.switchActive,
                  activeToggleColor: colorScheme.onPrimary,
                  height: 24.h,
                  width: 42.w,
                  value: true,
                  onToggle: (value) => {},
                ),
              ),
              SizedBox(height: Spacing.small),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(LemonRadius.normal),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    SettingTileWidget(
                      color: Colors.transparent,
                      title: "Guest unlock limit",
                      subTitle:
                          "number of friends and matches a guest can unlock this experience for",
                      onTap: () => {},
                      trailing: SizedBox(
                        width: 60.w,
                        child: LemonTextField(
                          initialText: "2",
                          contentPadding: EdgeInsets.all(Spacing.small),
                          onChange: (value) => {},
                        ),
                      ),
                    ),
                    Container(height: 1, color: LemonColor.white09),
                    SettingTileWidget(
                      color: Colors.transparent,
                      title: "No unlock limit",
                      onTap: () => {},
                      trailing: FlutterSwitch(
                        inactiveColor: colorScheme.onPrimary.withOpacity(0.12),
                        inactiveToggleColor:
                            colorScheme.onPrimary.withOpacity(0.18),
                        activeColor: LemonColor.switchActive,
                        activeToggleColor: colorScheme.onPrimary,
                        height: 24.h,
                        width: 42.w,
                        value: true,
                        onToggle: (value) => {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.small),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(LemonRadius.normal),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    SettingTileWidget(
                      color: Colors.transparent,
                      title: "Total guest limit",
                      subTitle:
                          "total number of people who can attend this experience",
                      onTap: () => {},
                      trailing: SizedBox(
                        width: 60.w,
                        child: LemonTextField(
                          initialText: "100",
                          contentPadding: EdgeInsets.all(Spacing.small),
                          onChange: (value) => {},
                        ),
                      ),
                    ),
                    Container(height: 1, color: LemonColor.white09),
                    SettingTileWidget(
                      color: Colors.transparent,
                      title: "No guest limit",
                      onTap: () => {},
                      trailing: FlutterSwitch(
                        inactiveColor: colorScheme.onPrimary.withOpacity(0.12),
                        inactiveToggleColor:
                            colorScheme.onPrimary.withOpacity(0.18),
                        activeColor: LemonColor.switchActive,
                        activeToggleColor: colorScheme.onPrimary,
                        height: 24.h,
                        width: 42.w,
                        value: true,
                        onToggle: (value) => {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.small),
            ],
          ),
        )
      ],
    );
  }
}
