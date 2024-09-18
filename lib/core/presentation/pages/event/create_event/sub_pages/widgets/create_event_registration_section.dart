import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/guest_limit_select_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateEventRegistrationSection extends StatelessWidget {
  const CreateEventRegistrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = context.watch<CreateEventBloc>().state;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.registration,
            style: Typo.medium.copyWith(
              color: colorScheme.onSurface.withOpacity(0.54),
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<bool>(
                    value: state.private ?? false,
                    onChanged: (value) {
                      context.read<CreateEventBloc>().add(
                            CreateEventEvent.createEventPrivateChanged(
                              private: value ?? false,
                            ),
                          );
                    },
                    customButton: _buildSettingRow(
                      context,
                      icon: Assets.icons.icPublic,
                      title: t.event.visibility,
                      value: state.private == true
                          ? t.event.private
                          : t.event.public,
                      trailingIcon: Assets.icons.icArrowUpDown,
                    ),
                    items: [
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text(t.event.public),
                      ),
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text(t.event.private),
                      ),
                    ],
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(LemonRadius.small),
                        color: colorScheme.secondaryContainer,
                      ),
                      offset: Offset(0, -Spacing.superExtraSmall),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      overlayColor: MaterialStatePropertyAll(
                        LemonColor.darkBackground,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icOutlineVerified,
                  title: t.event.requireApproval,
                  isSwitch: true,
                  switchValue: state.approvalRequired ?? false,
                  onToggleSwitch: (value) {
                    context.read<CreateEventBloc>().add(
                          CreateEventEvent.createEventApprovalRequiredChanged(
                            approvalRequired: value,
                          ),
                        );
                  },
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icArrowUpToLine,
                  title: t.event.guestSettings.guestLimit,
                  value: state.guestLimit ?? t.event.guestSettings.unlimited,
                  trailingIcon: Assets.icons.icEdit,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      bounce: true,
                      backgroundColor: LemonColor.atomicBlack,
                      context: context,
                      enableDrag: false,
                      builder: (newContext) {
                        return GuestLimitSelectBottomSheet(
                          title: t.event.guestSettings.guestLimit,
                          description:
                              t.event.guestSettings.guestLimitDescription,
                          initialValue: int.tryParse(state.guestLimit ?? '100'),
                          onRemove: () {
                            AutoRouter.of(context).pop();
                          },
                          onSetLimit: (value) {
                            AutoRouter.of(context).pop();
                            context.read<CreateEventBloc>().add(
                                  CreateEventEvent.createEventGuestLimitChanged(
                                    guestLimit: value.toString(),
                                  ),
                                );
                          },
                        );
                      },
                    );
                  },
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icPersonAddOutline,
                  title: t.event.guestSettings.inviteLimitPerGuest,
                  value: state.guestLimitPer ?? t.event.guestSettings.unlimited,
                  trailingIcon: Assets.icons.icEdit,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      bounce: true,
                      backgroundColor: LemonColor.atomicBlack,
                      context: context,
                      enableDrag: false,
                      builder: (newContext) {
                        return GuestLimitSelectBottomSheet(
                          title: t.event.guestSettings.inviteLimitPerGuest,
                          description:
                              t.event.guestSettings.inviteLimitDescription,
                          initialValue:
                              int.tryParse(state.guestLimitPer ?? '5'),
                          onRemove: () {
                            AutoRouter.of(context).pop();
                          },
                          onSetLimit: (value) {
                            AutoRouter.of(context).pop();
                            context.read<CreateEventBloc>().add(
                                  CreateEventEvent
                                      .createEventGuestLimitPerChanged(
                                    guestLimitPer: value.toString(),
                                  ),
                                );
                          },
                        );
                      },
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

  Widget _buildSettingRow(
    BuildContext context, {
    required SvgGenImage icon,
    required String title,
    String? value,
    bool isSwitch = false,
    bool? switchValue,
    SvgGenImage? trailingIcon,
    Function()? onTap,
    Function(bool)? onToggleSwitch,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            Center(
              child: SizedBox(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => icon.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
            if (isSwitch)
              FlutterSwitch(
                inactiveColor: colorScheme.outline,
                inactiveToggleColor: colorScheme.onSurfaceVariant,
                activeColor: LemonColor.paleViolet,
                activeToggleColor: colorScheme.onPrimary,
                height: 24.h,
                width: 42.w,
                value: switchValue ?? false,
                onToggle: (value) {
                  if (onToggleSwitch != null) {
                    onToggleSwitch(value);
                  }
                },
              )
            else if (value != null) ...[
              Text(
                value,
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(width: Spacing.xSmall),
              if (trailingIcon != null)
                ThemeSvgIcon(
                  color: colorScheme.onSurfaceVariant,
                  builder: (filter) => trailingIcon.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
