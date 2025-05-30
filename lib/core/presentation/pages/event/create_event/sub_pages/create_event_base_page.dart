import 'package:app/core/application/common/refresh_bloc/refresh_bloc.dart';
import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_banner_photo_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_map_location_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_registration_section.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_space_select_dropdown.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/select_event_tags_dropdown.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/sub_events_additional_direction_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/event_location_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_virtual_link_setting_page/event_virtual_link_setting_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_submitting_to_space_card.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class CreateEventBasePage extends StatelessWidget {
  const CreateEventBasePage({
    super.key,
  });

  void _onCreateEventSuccess(
    BuildContext context,
    CreateEventState state,
  ) {
    AutoRouter.of(context).root.popUntilRoot();
    AutoRouter.of(context).root.push(
          EventDetailRoute(
            eventId: state.eventId ?? '',
            children: const [
              EventDetailBaseRoute(),
              HostEventPublishFlowRoute(),
              // TODO: Ticket setup
              // EventTicketTierSettingRoute(
              //   children: [
              //     EventTicketTiersListingRoute(
              //       onNext: (mContext) => AutoRouter.of(mContext).replace(
              //         const HostEventPublishFlowRoute(),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
  }

  void _onCreateSubEventSuccess(
    BuildContext context,
    CreateEventState state,
  ) async {
    final t = Translations.of(context);
    final router = AutoRouter.of(context);
    router.root.popUntilRoot();
    final result = await router.root.push<(EventActionType?, Event?)>(
      EventPreviewRoute(
        eventId: state.eventId ?? '',
        buttonBuilder: (mContext, event) => LinearGradientButton.primaryButton(
          label: t.event.eventPublish.publishSession,
          onTap: () => AutoRouter.of(mContext)
              .pop((EventActionType.publishSubEvent, event)),
        ),
      ),
    );
    final eventAction = result?.$1;
    final eventData = result?.$2;
    if (eventAction != EventActionType.publishSubEvent) {
      router.root.push(
        EventDetailRoute(
          eventId: eventData?.id ?? state.eventId ?? '',
        ),
      );
      return;
    }
    final eventAction2 = await router.root.push<EventActionType?>(
      EventPublishingRoute(
        event: eventData!,
        successButtonBuilder: (mContext) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          child: Column(
            children: [
              LinearGradientButton.primaryButton(
                label: t.event.sessionDuplication.createRecurringSession,
                onTap: () => AutoRouter.of(mContext)
                    .pop((EventActionType.duplicateSubEvent)),
              ),
              SizedBox(height: Spacing.xSmall),
              LinearGradientButton.secondaryButton(
                label: t.event.subEventSettings.viewSubEvents,
                onTap: () =>
                    AutoRouter.of(mContext).pop((EventActionType.viewSubEvent)),
                mode: GradientButtonMode.light,
              ),
            ],
          ),
        ),
      ),
    );
    if (eventAction2 == EventActionType.duplicateSubEvent) {
      router.root.push(
        CreateDuplicatedSubEventsRoute(
          subEvent: eventData,
        ),
      );
      return;
    }
    if (eventAction2 == EventActionType.viewSubEvent) {
      router.root.push(
        EventDetailRoute(
          eventId: eventData.id ?? state.eventId ?? '',
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return BlocConsumer<CreateEventBloc, CreateEventState>(
      listener: (context, state) async {
        if (state.status.isSuccess) {
          SnackBarUtils.showSuccess(
            message: t.event.eventCreation.createEventSuccessfully,
          );
          if (state.parentEventId != null) {
            _onCreateSubEventSuccess(context, state);
          } else {
            _onCreateEventSuccess(context, state);
          }
          context.read<RefreshBloc>().add(const RefreshEvent.refreshEvents());
          // Submitting to space
          if (state.submittingToSpaceId != null) {
            getIt<SpaceRepository>().pinEventsToSpace(
              events: [state.eventId ?? ''],
              spaceId: state.submittingToSpaceId ?? '',
            );
          }
        }
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: appColors.pageBg,
          appBar: LemonAppBar(
            leadingWidth: 100.w,
            leading: BlocBuilder<ListSpacesBloc, ListSpacesState>(
              builder: (context, spacesState) {
                return spacesState.maybeWhen(
                  loading: () => Loading.defaultLoading(context),
                  success: (spaces) {
                    if (state.selectedSpaceId == null && spaces.isNotEmpty) {
                      context.read<CreateEventBloc>().add(
                            CreateEventEvent.onSpaceIdChanged(
                              spaceId: spaces.first.id,
                            ),
                          );
                    }
                    return CreateEventSpaceSelectDropdown(
                      onSpaceSelected: (spaceId) {
                        context.read<CreateEventBloc>().add(
                              CreateEventEvent.onSpaceIdChanged(
                                spaceId: spaceId,
                              ),
                            );
                      },
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            title: state.parentEventId != null
                ? t.event.subEvent.createSubEvent
                : t.event.eventCreation.createEvent,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Spacing.smMedium),
                child: InkWell(
                  onTap: () {
                    Vibrate.feedback(FeedbackType.light);
                    AutoRouter.of(context).pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: Sizing.small,
                    color: appColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: CreateEventBannerPhotoCard(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: LemonTextField(
                      hintText: t.event.eventCreation.titleHint,
                      initialText: state.title.value,
                      onChange: (value) => context.read<CreateEventBloc>().add(
                            CreateEventEvent.createEventTitleChanged(
                              title: value,
                            ),
                          ),
                      errorText: state.title.displayError?.getMessage(
                        t.event.eventCreation.title,
                      ),
                      style: appText.md,
                      placeholderStyle: appText.md.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: EventDateTimeSettingSection(
                      event: null,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: SettingTileWidget(
                      color: appColors.cardBg,
                      title: t.event.virtualLinkSetting.virtualLink,
                      subTitle: state.virtualUrl,
                      leading: Icon(
                        Icons.videocam_rounded,
                        size: 18.w,
                        color: colorScheme.onSecondary,
                      ),
                      leadingCircle: false,
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      titleStyle: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      radius: LemonRadius.small,
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        showCupertinoModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          builder: (mContext) {
                            return EventVirtualLinkSettingPage(
                              defaultUrl: state.virtualUrl,
                              onConfirm: (virtualUrl) {
                                context.read<CreateEventBloc>().add(
                                      CreateEventEvent
                                          .createEventVirtualLinkChanged(
                                        virtualUrl: virtualUrl,
                                      ),
                                    );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: appColors.cardBg,
                        borderRadius: BorderRadius.circular(LemonRadius.small),
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<EventLocationSettingBloc,
                              EventLocationSettingState>(
                            builder: (context, locationState) {
                              return SettingTileWidget(
                                color: Colors.transparent,
                                title: locationState.selectedAddress != null
                                    ? locationState.selectedAddress?.title ?? ''
                                    : t.event.locationSetting.chooseLocation,
                                description: state.parentEventId == null
                                    ? locationState.selectedAddress
                                            ?.additionalDirections ??
                                        ''
                                    : '',
                                subTitle:
                                    locationState.selectedAddress?.street1,
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  size: 18.w,
                                  color: colorScheme.onSecondary,
                                ),
                                leadingCircle: false,
                                trailing: Assets.icons.icArrowBack.svg(
                                  width: 18.w,
                                  height: 18.w,
                                ),
                                titleStyle: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                                radius: LemonRadius.small,
                                onTap: () {
                                  showCupertinoModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    backgroundColor: appColors.cardBg,
                                    topRadius:
                                        Radius.circular(LemonRadius.small),
                                    enableDrag: false,
                                    builder: (mContext) {
                                      return BlocProvider.value(
                                        value: context
                                            .read<EventLocationSettingBloc>(),
                                        child: EventLocationSettingPage(
                                          isSubEvent:
                                              state.parentEventId != null,
                                          onConfirmLocation: (address) {
                                            Navigator.pop(mContext);
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          /**
                             * Only show this additional_direction dropdown for subEvent
                             */
                          state.parentEventId != null
                              ? SubEventsAdditionalDirectionDropdown(
                                  parentEventId: state.parentEventId,
                                  onChange: (String selectedInstruction) {
                                    context
                                        .read<EventLocationSettingBloc>()
                                        .add(
                                          AdditionalDirectionsChanged(
                                            additionalDirections:
                                                selectedInstruction,
                                          ),
                                        );
                                  },
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<EventLocationSettingBloc,
                    EventLocationSettingState>(
                  builder: (context, state) {
                    if (state.selectedAddress == null) {
                      return const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      );
                    }
                    return SliverPadding(
                      padding: EdgeInsets.only(
                        top: Spacing.xSmall,
                        left: Spacing.smMedium,
                        right: Spacing.smMedium,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.small),
                          child: CreateEventMapLocationCard(
                            latitude: state.selectedAddress?.latitude ?? 0,
                            longitude: state.selectedAddress?.longitude ?? 0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: SettingTileWidget(
                      color: appColors.cardBg,
                      title: t.event.eventCreation.description,
                      subTitle: StringUtils.stripHtmlTags(
                        state.description ?? '',
                      ),
                      leading: Assets.icons.icDescription.svg(),
                      leadingCircle: false,
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      titleStyle: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      radius: LemonRadius.small,
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          EventDescriptionFieldRoute(
                            description: state.description ?? '',
                            onSave: (value) async {
                              context.read<CreateEventBloc>().add(
                                    CreateEventEvent
                                        .createEventDescriptionChanged(
                                      description: value,
                                    ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xSmall),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: SelectEventTagsDropdown(
                      onChange: (tags) {
                        context.read<CreateEventBloc>().add(
                              CreateEventEvent.createEventTagsChanged(
                                tags: tags,
                              ),
                            );
                      },
                      initialSelectedTags: const [],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xSmall),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Spacing.smMedium,
                      bottom: Spacing.medium,
                    ),
                    child: Container(
                      height: 1.h,
                      decoration: BoxDecoration(
                        color: appColors.pageDivider,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateEventRegistrationSection(),
                ),
                SliverToBoxAdapter(
                  child: CreateEventSubmittingToSpaceCard(
                    submittingToSpaceId: state.submittingToSpaceId,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildSubmitButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Container(
          color: appColors.pageBg,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
              vertical: Spacing.medium,
            ),
            child: LinearGradientButton.primaryButton(
              label: state.parentEventId != null
                  ? t.event.subEvent.createSubEvent
                  : t.event.eventCreation.createEvent,
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                final eventGuestSettingsState =
                    context.read<EventGuestSettingsBloc>().state;
                final start = context
                        .read<EventDateTimeSettingsBloc>()
                        .state
                        .start
                        .value ??
                    EventDateTimeConstants.defaultStartDateTime;
                final end =
                    context.read<EventDateTimeSettingsBloc>().state.end.value ??
                        EventDateTimeConstants.defaultEndDateTime;
                final selectedAddress = context
                    .read<EventLocationSettingBloc>()
                    .state
                    .selectedAddress;
                final timezone =
                    context.read<EventDateTimeSettingsBloc>().state.timezone ??
                        '';
                context.read<CreateEventBloc>().add(
                      CreateEventEvent.createEventFormSubmitted(
                        start: start,
                        end: end,
                        timezone: timezone,
                        address: selectedAddress,
                        guestLimit: eventGuestSettingsState.guestLimit,
                        guestLimitPer: eventGuestSettingsState.guestLimitPer,
                        approvalRequired:
                            eventGuestSettingsState.approvalRequired,
                        private: eventGuestSettingsState.private,
                      ),
                    );
              },
              loadingWhen: state.status.isInProgress,
            ),
          ),
        );
      },
    );
  }
}
