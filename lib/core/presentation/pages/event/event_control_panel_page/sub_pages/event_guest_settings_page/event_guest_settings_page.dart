import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_guest_settings_page/widgets/delete_event_confirmation_bottom_sheet.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum EventPrivacy { public, private }

@RoutePage()
class EventGuestSettingsPage extends StatefulWidget {
  const EventGuestSettingsPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventGuestSettingsPage> createState() => _EventGuestSettingsPageState();
}

class _EventGuestSettingsPageState extends State<EventGuestSettingsPage> {
  final TextEditingController guestLimitPerController = TextEditingController();
  final TextEditingController guestLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      guestLimitController.text =
          widget.event!.guestLimit?.toStringAsFixed(0) ?? '';
      guestLimitPerController.text =
          widget.event!.guestLimitPer?.toStringAsFixed(0) ?? '';
      context.read<EventGuestSettingsBloc>().add(
            PrivateChanged(private: widget.event?.private ?? false),
          );
      final eventApprovalRequired = widget.event?.approvalRequired ?? true;
      context.read<EventGuestSettingsBloc>().add(
            RequireApprovalChanged(approvalRequired: eventApprovalRequired),
          );
    } else {
      final eventGuestSettingBloc =
          context.read<EventGuestSettingsBloc>().state;
      guestLimitController.text = eventGuestSettingBloc.guestLimit.toString();
      guestLimitPerController.text =
          eventGuestSettingBloc.guestLimitPer.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: LemonColor.atomicBlack,
          title: t.event.eventCreation.guestSettings,
        ),
        backgroundColor: LemonColor.atomicBlack,
        body: BlocListener<EditEventDetailBloc, EditEventDetailState>(
          listener: (context, state) {
            if (state.status == EditEventDetailBlocStatus.success) {
              AutoRouter.of(context).pop();
            }
          },
          child: _buildContent(colorScheme),
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    return BlocBuilder<EventGuestSettingsBloc, EventGuestSettingState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                  vertical: Spacing.xSmall,
                ),
                child: Column(
                  children: [
                    _buildSegmentedButton(colorScheme, state),
                    SizedBox(
                      height: Spacing.medium,
                    ),
                    _buildSettingTile(
                      title: t.event.guestSettings.autoApprove,
                      subTitle: t.event.guestSettings.autoApproveDescription,
                      value: !state.approvalRequired,
                      onChanged: (value) {
                        Vibrate.feedback(FeedbackType.light);
                        context.read<EventGuestSettingsBloc>().add(
                              RequireApprovalChanged(approvalRequired: !value),
                            );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    _buildContainer(
                      _buildSettingTile(
                        title: t.event.guestSettings.guestUnlockLimit,
                        subTitle:
                            t.event.guestSettings.guestUnlockLimitDescription,
                        value: state.guestLimitPer == null,
                        onChanged: (value) =>
                            _onGuestLimitPerToggle(value, state),
                        trailing: SizedBox(
                          width: 60.w,
                          child: LemonTextField(
                            textInputType: TextInputType.number,
                            controller: guestLimitPerController,
                            contentPadding: EdgeInsets.all(Spacing.small),
                            onChange: (value) => context
                                .read<EventGuestSettingsBloc>()
                                .add(
                                  GuestLimitPerChanged(guestLimitPer: value),
                                ),
                            readOnly: state.guestLimitPer == null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    _buildContainer(
                      _buildSettingTile(
                        title: t.event.guestSettings.noUnlockLimit,
                        value: state.guestLimitPer == null,
                        onChanged: (value) =>
                            _onNoGuestLimitPerToggle(value, state),
                        subTitle: '',
                      ),
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    _buildContainer(
                      _buildSettingTile(
                        title: t.event.guestSettings.totalGuestLimit,
                        subTitle:
                            t.event.guestSettings.totalGuestLimitDescription,
                        value: state.guestLimit == null,
                        onChanged: (value) => _onGuestLimitToggle(value, state),
                        trailing: SizedBox(
                          width: 60.w,
                          child: LemonTextField(
                            textInputType: TextInputType.number,
                            controller: guestLimitController,
                            contentPadding: EdgeInsets.all(Spacing.small),
                            onChange: (value) => context
                                .read<EventGuestSettingsBloc>()
                                .add(GuestLimitChanged(guestLimit: (value))),
                            readOnly: state.guestLimit == null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    _buildContainer(
                      _buildSettingTile(
                        title: t.event.guestSettings.noGuestLimit,
                        value: state.guestLimit == null,
                        onChanged: (value) =>
                            _onNoGuestLimitToggle(value, state),
                        subTitle: '',
                      ),
                    ),
                    SizedBox(
                      height: Spacing.medium,
                    ),
                    SettingTileWidget(
                      title: t.event.deleteEvent,
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.8),
                          topRadius: Radius.circular(30.r),
                          builder: (mContext) {
                            return const DeleteEventConfirmationBottomSheet();
                          },
                        );
                      },
                      color: LemonColor.chineseBlack,
                      titleColor: LemonColor.coralReef,
                      leadingCircle: false,
                      leading: ThemeSvgIcon(
                        color: LemonColor.coralReef,
                        builder: (filter) {
                          return Assets.icons.icDelete
                              .svg(colorFilter: filter, width: 18, height: 18);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
            widget.event != null
                ? BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: LemonColor.atomicBlack,
                            border: Border(
                              top: BorderSide(
                                color: colorScheme.outline,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(Spacing.smMedium),
                          child: SafeArea(
                            child: LinearGradientButton.primaryButton(
                              loadingWhen: state.status ==
                                  EditEventDetailBlocStatus.loading,
                              onTap: () {
                                Vibrate.feedback(FeedbackType.light);
                                FocusManager.instance.primaryFocus?.unfocus();
                                context.read<EditEventDetailBloc>().add(
                                      EditEventDetailEvent.update(
                                        eventId: widget.event?.id ?? '',
                                        guestLimit: context
                                            .read<EventGuestSettingsBloc>()
                                            .state
                                            .guestLimit,
                                        guestLimitPer: context
                                            .read<EventGuestSettingsBloc>()
                                            .state
                                            .guestLimitPer,
                                        private: context
                                            .read<EventGuestSettingsBloc>()
                                            .state
                                            .private,
                                        approvalRequired: context
                                            .read<EventGuestSettingsBloc>()
                                            .state
                                            .approvalRequired,
                                      ),
                                    );
                              },
                              label: t.common.actions.saveChanges,
                              textColor: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Widget _buildSegmentedButton(
    ColorScheme colorScheme,
    EventGuestSettingState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      width: double.maxFinite,
      child: SegmentedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? LemonColor.lavender18
                : LemonColor.chineseBlack;
          }),
          foregroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? LemonColor.lavender
                : LemonColor.black33;
          }),
          textStyle: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              return const TextStyle(
                fontFamily: FontFamily.nohemiVariable,
                fontWeight: FontWeight.w700,
              );
            },
          ),
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(
            value: false,
            label: Text("Public"),
            icon: Icon(Icons.visibility_off_outlined),
          ),
          ButtonSegment(
            value: true,
            label: Text("Private"),
            icon: Icon(Icons.visibility_outlined),
          ),
        ],
        selected: {
          state.private,
        },
        onSelectionChanged: (Set<bool> newSelection) {
          context.read<EventGuestSettingsBloc>().add(
                PrivateChanged(private: newSelection.first),
              );
        },
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subTitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Widget? trailing,
  }) {
    return SettingTileWidget(
      title: title,
      subTitle: subTitle,
      onTap: () => {},
      color: LemonColor.chineseBlack,
      trailing: trailing ??
          FlutterSwitch(
            inactiveColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            inactiveToggleColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.18),
            activeColor: LemonColor.paleViolet,
            activeToggleColor: Theme.of(context).colorScheme.onPrimary,
            height: 24.h,
            width: 42.w,
            value: value,
            onToggle: onChanged,
          ),
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }

  void _onGuestLimitPerToggle(
    bool isGuestLimitPer,
    EventGuestSettingState state,
  ) {
    guestLimitPerController.text =
        isGuestLimitPer ? '' : EventConstants.defaultEventGuestLimitPer;
    context.read<EventGuestSettingsBloc>().add(
          GuestLimitPerChanged(
            guestLimitPer: isGuestLimitPer
                ? null
                : EventConstants.defaultEventGuestLimitPer,
          ),
        );
  }

  void _onNoGuestLimitPerToggle(
    bool isNoGuestLimitPer,
    EventGuestSettingState state,
  ) {
    guestLimitPerController.text =
        isNoGuestLimitPer ? '' : EventConstants.defaultEventGuestLimitPer;
    context.read<EventGuestSettingsBloc>().add(
          GuestLimitPerChanged(
            guestLimitPer: isNoGuestLimitPer
                ? null
                : EventConstants.defaultEventGuestLimitPer,
          ),
        );
  }

  void _onGuestLimitToggle(bool isGuestLimit, EventGuestSettingState state) {
    guestLimitController.text =
        isGuestLimit ? '' : EventConstants.defaultEventGuestLimit;
    context.read<EventGuestSettingsBloc>().add(
          GuestLimitChanged(
            guestLimit:
                isGuestLimit ? null : EventConstants.defaultEventGuestLimit,
          ),
        );
  }

  void _onNoGuestLimitToggle(
    bool isNoGuestLimit,
    EventGuestSettingState state,
  ) {
    guestLimitController.text =
        isNoGuestLimit ? '' : EventConstants.defaultEventGuestLimit;
    context.read<EventGuestSettingsBloc>().add(
          GuestLimitChanged(
            guestLimit:
                isNoGuestLimit ? null : EventConstants.defaultEventGuestLimit,
          ),
        );
  }
}
