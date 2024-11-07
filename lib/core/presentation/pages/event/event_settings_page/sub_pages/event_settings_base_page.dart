import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_banner_photo_card.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_registration_section.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_virtual_link_setting_page/event_virtual_link_setting_page.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          fetched: (event) => GestureDetector(
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
                          onChange: (value) {},
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
                                  onConfirm: (virtualUrl) {},
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
                              useRootNavigator: true,
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
                                description: '',
                                onDescriptionChanged: (value) {
                                  // Add description change handler
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
                            // Add tags change handler
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
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.xSmall),
                    ),
                    SliverToBoxAdapter(
                      child: CreateEventRegistrationSection(
                        initialEvent: event,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
