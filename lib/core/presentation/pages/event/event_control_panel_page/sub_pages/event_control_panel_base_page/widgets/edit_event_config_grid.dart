import 'package:app/core/application/event/edit_event_bloc/edit_event_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_datetime_settings_page/event_datetime_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_guest_settings_page/event_guest_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/event_location_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_virtual_link_setting_page/event_virtual_link_setting_page.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum EventPrivacy { public, private }

class EditEventConfigGrid extends StatelessWidget {
  final Event? event;
  const EditEventConfigGrid({super.key, this.event});

  onTap(
    BuildContext context,
    EventConfiguration eventConfig,
  ) {
    Vibrate.feedback(FeedbackType.light);
    Widget? page;
    final eventConfigType = eventConfig.type;
    switch (eventConfigType) {
      case EventConfigurationType.visibility ||
            EventConfigurationType.guestSettings:
        page = EventGuestSettingsPage(
          event: event,
        );
        break;
      case EventConfigurationType.startDateTime:
        page = EventDatetimeSettingsPage(
          event: event,
        );
        break;
      case EventConfigurationType.endDateTime:
        page = EventDatetimeSettingsPage(
          event: event,
        );
        break;
      case EventConfigurationType.location:
        return showCupertinoModalBottomSheet(
          context: context,
          backgroundColor: LemonColor.atomicBlack,
          topRadius: Radius.circular(LemonRadius.small),
          enableDrag: false,
          builder: (mContext) {
            return EventLocationSettingPage(
              event: event,
            );
          },
        );
      case EventConfigurationType.applicationForm:
        return AutoRouter.of(context)
            .navigate(EventApplicationFormSettingRoute());
      case EventConfigurationType.photos:
        return AutoRouter.of(context).push(EventPhotosSettingRoute());
      default:
        page = null;
        break;
    }
    if (page == null) {
      return SnackBarUtils.showComingSoon();
    }
    showCupertinoModalBottomSheet(
      enableDrag: false,
      barrierColor: LemonColor.black50,
      bounce: true,
      expand: true,
      backgroundColor: LemonColor.atomicBlack,
      context: context,
      builder: (newContext) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            color: LemonColor.atomicBlack,
          ),
          clipBehavior: Clip.hardEdge,
          child: FractionallySizedBox(
            heightFactor: 0.95,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Expanded(
                  child: page ?? const SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (event != null) {
      final eventConfigs = [
        ...EventConfiguration.createEventConfigurations(event: event),
        ...EventConfiguration.photosConfigurations(context, event: event),
      ];
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.2,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: eventConfigs.length,
          (BuildContext context, int index) {
            final eventConfig = eventConfigs[index];
            EventConfigurationType? eventConfigType = eventConfig.type;
            switch (eventConfigType) {
              case EventConfigurationType.virtual:
                return BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
                  builder: (context, state) {
                    return EventConfigCard(
                      title: eventConfig.title,
                      description: event?.virtualUrl ?? eventConfig.description,
                      icon: eventConfig.icon,
                      selected: eventConfig.selected,
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        showCupertinoModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          builder: (mContext) {
                            return EventVirtualLinkSettingPage(
                              defaultUrl: event?.virtualUrl,
                              onConfirm: (virtualUrl) {
                                context.read<EditEventDetailBloc>().add(
                                      EditEventDetailEvent.update(
                                        eventId: event?.id ?? '',
                                        virtual: virtualUrl.isNotEmpty,
                                        virtualUrl: virtualUrl,
                                      ),
                                    );
                              },
                            );
                          },
                        );
                      },
                      loading:
                          state.status == EditEventDetailBlocStatus.loading,
                    );
                  },
                );
              default:
                return EventConfigCard(
                  title: eventConfig.title,
                  description: eventConfig.description,
                  icon: eventConfig.icon,
                  selected: eventConfig.selected,
                  onTap: () {
                    onTap(context, eventConfig);
                  },
                );
            }
          },
        ),
      );
    }
    final eventConfigs = EventConfiguration.defaultEventConfigurations();
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.3,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 4,
        (BuildContext context, int index) {
          final eventConfig = eventConfigs[index];
          EventConfigurationType? eventConfigType = eventConfig.type;
          switch (eventConfigType) {
            case EventConfigurationType.visibility:
              return BlocBuilder<EventGuestSettingsBloc,
                  EventGuestSettingState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: state.private == true
                        ? t.event.private
                        : t.event.public,
                    description: state.private == true
                        ? t.event.privateDescription
                        : t.event.publicDescription,
                    icon: eventConfig.icon,
                    onTap: () => onTap(context, eventConfig),
                  );
                },
              );
            case EventConfigurationType.guestSettings:
              return BlocBuilder<EventGuestSettingsBloc,
                  EventGuestSettingState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: eventConfig.title,
                    description: t.event.eventCreation.guestSettingDescription(
                      guestLimit: state.guestLimit ?? 'unlimited',
                      guestLimitPer: state.guestLimitPer ?? 'no',
                    ),
                    icon: eventConfig.icon,
                    onTap: () => onTap(context, eventConfig),
                  );
                },
              );
            case EventConfigurationType.startDateTime:
              return BlocBuilder<EventDateTimeSettingsBloc,
                  EventDateTimeSettingsState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: DateFormatUtils.custom(
                      state.start.value,
                      pattern: 'EEE, MMMM dd - HH:mm',
                    ),
                    description: eventConfig.description,
                    icon: eventConfig.icon,
                    onTap: () => onTap(context, eventConfig),
                  );
                },
              );
            case EventConfigurationType.endDateTime:
              return BlocBuilder<EventDateTimeSettingsBloc,
                  EventDateTimeSettingsState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: DateFormatUtils.custom(
                      state.end.value,
                      pattern: 'EEE, MMMM dd - HH:mm',
                    ),
                    description: eventConfig.description,
                    icon: eventConfig.icon,
                    onTap: () => onTap(context, eventConfig),
                  );
                },
              );
            case EventConfigurationType.virtual:
              return BlocBuilder<EditEventBloc, EditEventState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: eventConfig.title,
                    description: state.virtualUrl ?? '',
                    icon: eventConfig.icon,
                    onTap: () {
                      Vibrate.feedback(FeedbackType.light);
                      showCupertinoModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        builder: (mContext) {
                          return EventVirtualLinkSettingPage(
                            defaultUrl: state.virtualUrl,
                            onConfirm: (virtualUrl) {
                              context.read<EditEventBloc>().add(
                                    EditEventEvent.virtualLinkChanged(
                                      virtualUrl: virtualUrl,
                                    ),
                                  );
                            },
                          );
                        },
                      );
                    },
                    selected: state.virtual,
                  );
                },
              );
            case EventConfigurationType.location:
              return BlocBuilder<EventLocationSettingBloc,
                  EventLocationSettingState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: eventConfig.title,
                    description: state.selectedAddress?.title ??
                        t.event.locationSetting.addLocation,
                    icon: eventConfig.icon,
                    onTap: () => onTap(context, eventConfig),
                    selected: state.selectedAddress != null,
                  );
                },
              );

            default:
              return EventConfigCard(
                title: '',
                description: '',
                icon: eventConfig.icon,
                onTap: () => null,
              );
          }
        },
      ),
    );
  }
}
