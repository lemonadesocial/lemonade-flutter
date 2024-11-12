import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_banner_photo_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_content_section.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_map_location_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_registration_section.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_guest_settings_page/widgets/delete_event_confirmation_bottom_sheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_virtual_link_setting_page/event_virtual_link_setting_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/select_event_tags_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/event_location_setting_page.dart';
import 'package:app/router/app_router.gr.dart';

@RoutePage()
class EventSettingsBasePage extends StatelessWidget {
  const EventSettingsBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
      builder: (context, eventDetailState) {
        return eventDetailState.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          fetched: (event) {
            return BlocListener<EditEventDetailBloc, EditEventDetailState>(
              listener: (context, state) {
                if (state.status == EditEventDetailBlocStatus.success) {
                  context.read<GetEventDetailBloc>().add(
                        GetEventDetailEvent.fetch(
                          eventId: event.id ?? '',
                        ),
                      );
                }
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  backgroundColor: colorScheme.primary,
                  appBar: LemonAppBar(
                    title: t.common.settings,
                    hideLeading: true,
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
                            size: 24,
                            color: Theme.of(context).colorScheme.onSurface,
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
                            child: CreateEventBannerPhotoCard(
                              thumbnailUrl: EventUtils.getEventThumbnailUrl(
                                event: event,
                              ),
                              onTapAddPhoto: () {
                                AutoRouter.of(context).navigate(
                                  const EventPhotosSettingRoute(),
                                );
                              },
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
                          sliver: SliverToBoxAdapter(
                            child: LemonTextField(
                              initialText: event.title,
                              hintText: t.event.eventCreation.titleHint,
                              onFieldSubmitted: (value) {
                                context.read<EditEventDetailBloc>().add(
                                      EditEventDetailEventUpdateTitle(
                                        eventId: event.id ?? '',
                                        title: value,
                                      ),
                                    );
                              },
                              style: Typo.mediumPlus.copyWith(
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
                              subTitle: event.virtualUrl,
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
                                      defaultUrl: event.virtualUrl,
                                      onConfirm: (virtualUrl) {
                                        context.read<EditEventDetailBloc>().add(
                                              EditEventDetailEventUpdateVirtualUrl(
                                                eventId: event.id ?? '',
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
                              title: event.address != null
                                  ? event.address?.title ?? ''
                                  : t.event.locationSetting.chooseLocation,
                              subTitle: event.address?.street1,
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
                                  topRadius: Radius.circular(LemonRadius.small),
                                  enableDrag: false,
                                  builder: (mContext) {
                                    return const EventLocationSettingPage();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        if (event.address != null) ...[
                          SliverPadding(
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
                                  latitude: event.address?.latitude ?? 0,
                                  longitude: event.address?.longitude ?? 0,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                    description: event.description ?? '',
                                    onDescriptionChanged: (value) {
                                      context.read<EditEventDetailBloc>().add(
                                            EditEventDetailEventUpdateDescription(
                                              eventId: event.id ?? '',
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
                                context.read<EditEventDetailBloc>().add(
                                      EditEventDetailEventUpdateTags(
                                        eventId: event.id ?? '',
                                        tags: tags,
                                      ),
                                    );
                              },
                              initialSelectedTags: event.tags ?? [],
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
                        SliverToBoxAdapter(
                          child: SizedBox(height: Spacing.xSmall),
                        ),
                        SliverToBoxAdapter(
                          child: CreateEventRegistrationSection(
                            initialEvent: event,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Spacing.medium,
                            ),
                            child: Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: colorScheme.outline,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CreateEventContentSection(
                            initialEvent: event,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: Spacing.medium),
                        ),
                        _buildDeleteEventButton(context, event),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDeleteEventButton(BuildContext context, Event event) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: () {
            showCupertinoModalBottomSheet(
              context: context,
              barrierColor: Colors.black.withOpacity(0.8),
              topRadius: Radius.circular(30.r),
              builder: (mContext) {
                return DeleteEventConfirmationBottomSheet(
                  event: event,
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              color: LemonColor.coralReef.withOpacity(0.18),
            ),
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    child: ThemeSvgIcon(
                      color: LemonColor.coralReef,
                      builder: (filter) => Assets.icons.icDelete.svg(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                        colorFilter: filter,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.small),
                Text(
                  t.event.deleteEvent,
                  style: Typo.medium.copyWith(
                    color: LemonColor.coralReef,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
