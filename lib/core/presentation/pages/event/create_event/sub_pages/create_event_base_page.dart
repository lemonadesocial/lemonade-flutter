import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/choose_location_page.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_banner_photo_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_map_location_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_registration_section.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/select_event_tags_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_virtual_link_setting_page/event_virtual_link_setting_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
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

@RoutePage()
class CreateEventBasePage extends StatelessWidget {
  const CreateEventBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          SnackBarUtils.showSuccess(
            message: t.event.eventCreation.createEventSuccessfully,
          );
          AutoRouter.of(context).root.popUntilRoot();
          AutoRouter.of(context).root.push(
                EventDetailRoute(
                  eventId: state.eventId ?? '',
                  children: [
                    const EventDetailBaseRoute(),
                    EventTicketTierSettingRoute(
                      children: [
                        EventTicketTiersListingRoute(
                          onNext: (mContext) => AutoRouter.of(mContext).replace(
                            const HostEventPublishFlowRoute(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
        }
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            hideLeading: true,
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
                    color: colorScheme.onSurfaceVariant,
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
                      labelStyle: Typo.mediumPlus.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      placeholderStyle: Typo.mediumPlus.copyWith(
                        color: LemonColor.white23,
                        fontWeight: FontWeight.w500,
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
                    child: EventDateTimeSettingSection(),
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
                        color: colorScheme.onSecondary,
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
                    child: SettingTileWidget(
                      title: t.event.locationSetting.chooseLocation,
                      subTitle: "",
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
                        color: colorScheme.onSecondary,
                      ),
                      radius: LemonRadius.small,
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          backgroundColor: LemonColor.atomicBlack,
                          topRadius: Radius.circular(30.r),
                          builder: (mContext) {
                            return const ChooseLocationPage();
                          },
                        );
                      },
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
                        child: CreateEventMapLocationCard(
                          latitude: state.selectedAddress?.latitude ?? 0,
                          longitude: state.selectedAddress?.longitude ?? 0,
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
                        color: colorScheme.onSecondary,
                      ),
                      radius: LemonRadius.small,
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          EventDescriptionFieldRoute(
                            description: state.description ?? '',
                            onDescriptionChanged: (value) {
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
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateEventRegistrationSection(),
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
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Container(
          color: colorScheme.background,
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
                        subEventEnabled:
                            eventGuestSettingsState.subEventEnabled,
                        subEventSettings:
                            eventGuestSettingsState.subEventSettings,
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
