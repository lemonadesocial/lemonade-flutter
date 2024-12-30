import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/checkin_guest_list_page/checkin_guest_list_page.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/scan_qr_checkin_rewards_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

extension ScanTargetIcon on ScanTarget {
  SvgGenImage get icon => switch (this) {
        ScanTarget.tickets => Assets.icons.icTicket,
        ScanTarget.rewards => Assets.icons.icReward,
      };
}

class ScannerActions extends StatelessWidget {
  final MobileScannerController controller;
  final ScanTarget selectedScanTarget;
  final Function(ScanTarget) onScanTargetChanged;
  final Event event;

  const ScannerActions({
    super.key,
    required this.controller,
    required this.selectedScanTarget,
    required this.onScanTargetChanged,
    required this.event,
  });

  List<ScanTarget> get _availableScanTargets {
    final hasRewards = event.rewards?.isNotEmpty ?? false;
    return ScanTarget.values.where((target) {
      return target == ScanTarget.tickets ||
          (target == ScanTarget.rewards && hasRewards);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      topRadius: Radius.circular(30.r),
                      builder: (context) => const CheckInGuestListPage(
                        initialTab: EventGuestsTabs.reservations,
                      ),
                    );
                  },
                  child: Container(
                    height: Sizing.large,
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    decoration: BoxDecoration(
                      color: colorScheme.outline,
                      borderRadius: BorderRadius.circular(24.w),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Sizing.mSmall,
                          height: Sizing.mSmall,
                          child: Center(
                            child: Assets.icons.icGuestList.svg(
                              width: Sizing.mSmall,
                              height: Sizing.mSmall,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacing.smMedium / 2),
                        Text(
                          t.event.eventApproval.tabs.guestList,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                ScanTargetDropdown(
                  selectedValue: selectedScanTarget,
                  onItemPressed: onScanTargetChanged,
                  availableTargets: _availableScanTargets,
                ),
              ],
            ),
            InkWell(
              onTap: controller.switchCamera,
              child: Container(
                width: Sizing.large,
                height: Sizing.large,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flip_camera_android,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanTargetDropdown extends StatelessWidget {
  final ScanTarget selectedValue;
  final Function(ScanTarget value)? onItemPressed;
  final List<ScanTarget> availableTargets;

  const ScanTargetDropdown({
    super.key,
    required this.selectedValue,
    this.onItemPressed,
    required this.availableTargets,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool showDropdown = availableTargets.length > 1;

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedValue,
        onChanged: showDropdown
            ? (ScanTarget? value) {
                if (value != null) {
                  onItemPressed?.call(value);
                }
              }
            : null,
        customButton: Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          height: Sizing.large,
          decoration: BoxDecoration(
            color: colorScheme.outline,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => selectedValue.icon.svg(
                  colorFilter: filter,
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                ),
              ),
              SizedBox(width: 9.w),
              Text(
                selectedValue.label,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              if (showDropdown) ...[
                SizedBox(width: 9.w),
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icArrowDown.svg(
                    colorFilter: filter,
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
              ],
            ],
          ),
        ),
        items: availableTargets.map((type) {
          return DropdownMenuItem(
            value: type,
            child: _ActionItem(
              label: type.label,
              icon: type.icon,
            ),
          );
        }).toList(),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250.w,
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.normal),
            color: LemonColor.atomicBlack,
          ),
          offset: Offset(0, -Spacing.superExtraSmall),
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String label;
  final SvgGenImage icon;

  const _ActionItem({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => icon.svg(
            colorFilter: filter,
            width: Sizing.mSmall,
            height: Sizing.mSmall,
          ),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            label,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
