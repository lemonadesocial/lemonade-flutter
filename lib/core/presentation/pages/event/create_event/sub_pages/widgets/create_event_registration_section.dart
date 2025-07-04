import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/guest_limit_select_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_subevents_setting_page/event_subevents_setting_page.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/app_theme/app_theme.dart';

class CreateEventRegistrationSection extends StatelessWidget {
  final Event? initialEvent;

  const CreateEventRegistrationSection({
    super.key,
    this.initialEvent,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    final isEditMode = initialEvent != null;
    final state = isEditMode ? null : context.watch<CreateEventBloc>().state;

    void handlePrivacyChange(bool? isPrivate) {
      if (isEditMode) {
        context.read<EditEventDetailBloc>().add(
              EditEventDetailEventUpdatePrivate(
                eventId: initialEvent!.id ?? '',
                private: isPrivate ?? false,
              ),
            );
      } else {
        context.read<CreateEventBloc>().add(
              CreateEventEvent.createEventPrivateChanged(
                private: isPrivate ?? false,
              ),
            );
      }
    }

    void handleApprovalRequiredChange(bool isRequired) {
      if (isEditMode) {
        context.read<EditEventDetailBloc>().add(
              EditEventDetailEventUpdateApprovalRequired(
                eventId: initialEvent!.id ?? '',
                approvalRequired: isRequired,
              ),
            );
      } else {
        context.read<CreateEventBloc>().add(
              CreateEventEvent.createEventApprovalRequiredChanged(
                approvalRequired: isRequired,
              ),
            );
      }
    }

    void handleGuestLimitChange(int? limit) {
      if (isEditMode) {
        context.read<EditEventDetailBloc>().add(
              EditEventDetailEventUpdateGuestLimit(
                eventId: initialEvent!.id ?? '',
                guestLimit: limit?.toString(),
              ),
            );
      } else {
        context.read<CreateEventBloc>().add(
              CreateEventEvent.createEventGuestLimitChanged(
                guestLimit: limit?.toString(),
              ),
            );
      }
    }

    void handleGuestLimitPerChange(int? limitPer) {
      if (isEditMode) {
        context.read<EditEventDetailBloc>().add(
              EditEventDetailEventUpdateGuestLimitPer(
                eventId: initialEvent!.id ?? '',
                guestLimitPer: limitPer?.toString(),
              ),
            );
      } else {
        context.read<CreateEventBloc>().add(
              CreateEventEvent.createEventGuestLimitPerChanged(
                guestLimitPer: limitPer?.toString(),
              ),
            );
      }
    }

    final private =
        isEditMode ? initialEvent!.private : (state?.private ?? false);
    final approvalRequired = isEditMode
        ? initialEvent!.approvalRequired
        : (state?.approvalRequired ?? false);
    final guestLimit = isEditMode
        ? initialEvent!.guestLimit?.toStringAsFixed(0)
        : state?.guestLimit;
    final guestLimitPer = isEditMode
        ? initialEvent!.guestLimitPer?.toStringAsFixed(0)
        : state?.guestLimitPer;

    final ticketsCount =
        isEditMode ? initialEvent?.eventTicketTypes?.length ?? 0 : 0;
    final discountCount =
        isEditMode ? initialEvent?.paymentTicketDiscounts?.length ?? 0 : 0;
    final applicationFormCount =
        isEditMode ? initialEvent?.applicationQuestions?.length ?? 0 : 0;
    // final rewardCount = isEditMode ? initialEvent?.rewards?.length ?? 0 : 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.registration,
            style: Typo.mediumPlus.copyWith(
              color: appColors.textTertiary,
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: appColors.cardBg,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<bool>(
                    value: private,
                    onChanged: handlePrivacyChange,
                    customButton: _buildSettingRow(
                      context,
                      icon: Assets.icons.icPublic,
                      title: t.event.visibility,
                      value: private == true ? t.event.private : t.event.public,
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
                        color: appColors.pageBg,
                      ),
                      offset: Offset(0, -Spacing.superExtraSmall),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      overlayColor: MaterialStatePropertyAll(
                        appColors.pageBg,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: appColors.pageDivider,
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
                  switchValue: approvalRequired,
                  onToggleSwitch: handleApprovalRequiredChange,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: appColors.pageDivider,
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
                  value: guestLimit ?? t.event.guestSettings.unlimited,
                  trailingIcon: Assets.icons.icEdit,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      bounce: true,
                      backgroundColor: appColors.pageBg,
                      barrierColor: Colors.black.withOpacity(0.5),
                      context: context,
                      enableDrag: false,
                      builder: (newContext) {
                        return GuestLimitSelectBottomSheet(
                          title: t.event.guestSettings.guestLimit,
                          description:
                              t.event.guestSettings.guestLimitDescription,
                          initialValue: int.tryParse(guestLimit ?? '100'),
                          onRemove: () {
                            AutoRouter.of(context).pop();
                            handleGuestLimitChange(null);
                          },
                          onSetLimit: (value) {
                            AutoRouter.of(context).pop();
                            handleGuestLimitChange(value);
                          },
                        );
                      },
                    );
                  },
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: appColors.pageDivider,
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
                  value: guestLimitPer ?? t.event.guestSettings.unlimited,
                  trailingIcon: Assets.icons.icEdit,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      bounce: true,
                      backgroundColor: appColors.pageBg,
                      barrierColor: Colors.black.withOpacity(0.5),
                      context: context,
                      enableDrag: false,
                      builder: (newContext) {
                        return GuestLimitSelectBottomSheet(
                          title: t.event.guestSettings.inviteLimitPerGuest,
                          description:
                              t.event.guestSettings.inviteLimitDescription,
                          initialValue: int.tryParse(guestLimitPer ?? '5'),
                          onRemove: () {
                            AutoRouter.of(context).pop();
                            handleGuestLimitPerChange(null);
                          },
                          onSetLimit: (value) {
                            AutoRouter.of(context).pop();
                            handleGuestLimitPerChange(value);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (isEditMode) ...[
            SizedBox(height: Spacing.xSmall),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColors.cardBg,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                    ),
                    child: Column(
                      children: [
                        _buildSettingRow(
                          context,
                          icon: Assets.icons.icTicket,
                          title:
                              t.event.ticketTierSetting.ticketTierSettingTitle,
                          trailingIcon: Assets.icons.icArrowRight,
                          onTap: () {
                            AutoRouter.of(context).navigate(
                              const EventTicketTierSettingRoute(),
                            );
                          },
                          value:
                              ticketsCount > 0 ? ticketsCount.toString() : null,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: appColors.pageDivider,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    margin: EdgeInsets.only(
                      left: Spacing.xLarge + Spacing.superExtraSmall,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                    ),
                    child: Column(
                      children: [
                        _buildSettingRow(
                          context,
                          icon: Assets.icons.icDiscount,
                          title: t.event.eventPromotions.eventPromotionsTitle,
                          trailingIcon: Assets.icons.icArrowRight,
                          onTap: () {
                            AutoRouter.of(context).navigate(
                              const EventDiscountSettingRoute(),
                            );
                          },
                          value: discountCount > 0
                              ? discountCount.toString()
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColors.cardBg,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              child: Column(
                children: [
                  _buildSettingRow(
                    context,
                    icon: Assets.icons.icApplicationForm,
                    title: t.event.configuration.applicationForm,
                    trailingIcon: Assets.icons.icArrowRight,
                    onTap: () {
                      AutoRouter.of(context).navigate(
                        const EventApplicationFormSettingRoute(),
                      );
                    },
                    value: applicationFormCount > 0
                        ? applicationFormCount.toString()
                        : null,
                  ),
                ],
              ),
            ),
            // TODO: Temporary hide reward setting
            // SizedBox(height: Spacing.xSmall),
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: LemonColor.chineseBlack,
            //     borderRadius: BorderRadius.circular(LemonRadius.medium),
            //   ),
            //   child: Column(
            //     children: [
            //       _buildSettingRow(
            //         context,
            //         icon: Assets.icons.icGift,
            //         title: t.event.configuration.rewards,
            //         trailingIcon: Assets.icons.icArrowRight,
            //         onTap: () {
            //           AutoRouter.of(context).navigate(
            //             const EventRewardSettingRoute(),
            //           );
            //         },
            //         value: rewardCount > 0 ? rewardCount.toString() : null,
            //       ),
            //     ],
            //   ),
            // ),
            if (initialEvent?.subeventParent == null ||
                initialEvent?.subeventParent?.isEmpty == true) ...[
              SizedBox(height: Spacing.xSmall),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                ),
                child: Column(
                  children: [
                    _buildSettingRow(
                      context,
                      icon: Assets.icons.icSessions,
                      title: t.event.subEvent.sessionsSettings,
                      trailingIcon: Assets.icons.icArrowRight,
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.5),
                          bounce: true,
                          expand: true,
                          backgroundColor: appColors.pageBg,
                          context: context,
                          builder: (newContext) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(18),
                                ),
                                color: appColors.pageBg,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: FractionallySizedBox(
                                heightFactor: 1,
                                child: Column(
                                  children: [
                                    const BottomSheetGrabber(),
                                    Expanded(
                                      child: EventSubEventsSettingPage(
                                        event: initialEvent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
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
    final appColors = context.theme.appColors;
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
                  color: appColors.textTertiary,
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
                style: Typo.medium.copyWith(color: appColors.textPrimary),
              ),
            ),
            if (isSwitch)
              FlutterSwitch(
                inactiveColor: appColors.pageDivider,
                inactiveToggleColor: appColors.textTertiary,
                activeColor: appColors.textAccent,
                activeToggleColor: appColors.textPrimary,
                height: 24.h,
                width: 42.w,
                value: switchValue ?? false,
                onToggle: (value) {
                  if (onToggleSwitch != null) {
                    onToggleSwitch(value);
                  }
                },
              )
            else ...[
              if (value != null)
                Text(
                  value,
                  style: Typo.medium.copyWith(color: appColors.textPrimary),
                ),
              SizedBox(width: Spacing.xSmall),
              ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => trailingIcon!.svg(
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
