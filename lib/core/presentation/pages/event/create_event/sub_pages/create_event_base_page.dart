import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/create_event_config_grid.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/description_editor_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
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

    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          SnackBarUtils.showSuccess(
            message: t.event.eventCreation.createEventSuccessfully,
          );
          AutoRouter.of(context).popTop();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            title: t.event.eventCreation.createEvent,
          ),
          body: SafeArea(
            child: BlocBuilder<CreateEventBloc, CreateEventState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: LemonTextField(
                              hintText: t.event.eventCreation.titleHint,
                              initialText: state.title.value,
                              onChange: (value) => context
                                  .read<CreateEventBloc>()
                                  .add(EventTitleChanged(title: value)),
                              errorText: state.title.displayError?.getMessage(
                                t.event.eventCreation.title,
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
                          sliver: SliverToBoxAdapter(
                            child: SettingTileWidget(
                              title: t.event.eventCreation.description,
                              subTitle: StringUtils.stripHtmlTags(
                                context
                                    .read<CreateEventBloc>()
                                    .state
                                    .description
                                    .value,
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
                                showCupertinoModalBottomSheet(
                                  backgroundColor: LemonColor.atomicBlack,
                                  context: context,
                                  enableDrag: false,
                                  builder: (innerContext) =>
                                      DescriptionEditorBottomSheet(
                                    content: context
                                        .read<CreateEventBloc>()
                                        .state
                                        .description
                                        .value,
                                    onTapBack: (result) {
                                      AutoRouter.of(context).pop();
                                      context.read<CreateEventBloc>().add(
                                            EventDescriptionChanged(
                                              description: result,
                                            ),
                                          );
                                    },
                                  ),
                                );
                              },
                              isError: state.description.displayError != null,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(top: 30.h),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: const SliverToBoxAdapter(
                            child: EventDateTimeSettingSection(),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(top: 30.h),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: const CreateEventConfigGrid(),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 15,
                      child: _buildSubmitButton(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.smMedium,
            vertical: Spacing.xSmall,
          ),
          child: LinearGradientButton(
            label: t.event.eventCreation.createEvent,
            height: 48.h,
            radius: BorderRadius.circular(24),
            textStyle: Typo.medium.copyWith(),
            mode: GradientButtonMode.lavenderMode,
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
              final eventGuestSettingsState =
                  context.read<EventGuestSettingsBloc>().state;
              final start =
                  context.read<EventDateTimeSettingsBloc>().state.start.value ??
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
                    FormSubmitted(
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
        );
      },
    );
  }
}
