import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_subevents_setting_bloc/event_subevents_setting_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventSubEventsSettingPage extends StatefulWidget {
  const EventSubEventsSettingPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventSubEventsSettingPage> createState() =>
      _EventSubEventsSettingPageState();
}

class _EventSubEventsSettingPageState extends State<EventSubEventsSettingPage> {
  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      context.read<EventSubEventsSettingBloc>().add(
            SubEventEnabledChanged(
              subEventEnabled: widget.event?.subeventEnabled ?? false,
            ),
          );
      context.read<EventSubEventsSettingBloc>().add(
            SubEventSettingsChanged(
              subEventSettings: widget.event?.subeventSettings,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
        title: t.event.subEventSettings.subEventSettings,
      ),
      backgroundColor: LemonColor.atomicBlack,
      body: BlocListener<EditEventDetailBloc, EditEventDetailState>(
        listener: (context, state) {
          if (state.status == EditEventDetailBlocStatus.success) {
            AutoRouter.of(context).pop();
          }
        },
        child:
            BlocBuilder<EventSubEventsSettingBloc, EventSubEventsSettingState>(
          builder: (context, subEventsSettingState) {
            final subEventEnabled = subEventsSettingState.subEventEnabled;
            final subEventSettings = subEventsSettingState.subEventSettings;
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
                        SettingTileWidget(
                          title: t.event.subEventSettings.allowSubEvent,
                          subTitle:
                              t.event.subEventSettings.allowSubEventDescription,
                          onTap: () {},
                          color: LemonColor.chineseBlack,
                          borderRadius: BorderRadius.all(
                            Radius.circular(LemonRadius.medium),
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
                              context.read<EventSubEventsSettingBloc>().add(
                                    SubEventEnabledChanged(
                                      subEventEnabled: value,
                                    ),
                                  );
                            },
                            value: subEventEnabled,
                          ),
                        ),
                        SizedBox(height: Spacing.small),
                        SettingTileWidget(
                          title: t.event.subEventSettings.requireTicketToCreate,
                          subTitle: t.event.subEventSettings
                              .requireTicketToCreateDescription,
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
                              context.read<EventSubEventsSettingBloc>().add(
                                    SubEventSettingsChanged(
                                      subEventSettings: payload,
                                    ),
                                  );
                            },
                            value:
                                subEventSettings?.ticketRequiredForCreation ??
                                    false,
                          ),
                        ),
                        Divider(
                          color: colorScheme.outline,
                          height: 0,
                          thickness: 0.5.w,
                        ),
                        SettingTileWidget(
                          title: t.event.subEventSettings.requireTicketToAttend,
                          subTitle: t.event.subEventSettings
                              .requireTicketToAttendDescription,
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
                              context.read<EventSubEventsSettingBloc>().add(
                                    SubEventSettingsChanged(
                                      subEventSettings: payload,
                                    ),
                                  );
                            },
                            value:
                                subEventSettings?.ticketRequiredForPurchase ??
                                    false,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(height: Spacing.medium),
                        SettingTileWidget(
                          title: t.event.subEventSettings.viewSubEvents,
                          color: LemonColor.chineseBlack,
                          trailing: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icArrowRight.svg(
                              colorFilter: filter,
                            ),
                          ),
                          borderRadius:
                              BorderRadius.circular(LemonRadius.medium),
                          onTap: () {
                            AutoRouter.of(context).push(
                              SubEventsListingRoute(
                                parentEventId: widget.event?.id ?? '',
                              ),
                            );
                          },
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
                                child: LinearGradientButton.secondaryButton(
                                  mode: GradientButtonMode.light,
                                  loadingWhen: state.status ==
                                      EditEventDetailBlocStatus.loading,
                                  onTap: () {
                                    Vibrate.feedback(FeedbackType.light);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    context.read<EditEventDetailBloc>().add(
                                          EditEventDetailEvent.update(
                                            eventId: widget.event?.id ?? '',
                                            subEventEnabled:
                                                subEventsSettingState
                                                    .subEventEnabled,
                                            subEventSettings:
                                                subEventsSettingState
                                                    .subEventSettings,
                                          ),
                                        );
                                  },
                                  label: t.common.actions.saveChanges,
                                  textColor: Colors.black,
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
        ),
      ),
    );
  }
}
