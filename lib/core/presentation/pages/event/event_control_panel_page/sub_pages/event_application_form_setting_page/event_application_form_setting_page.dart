import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_profile_setting_page/event_application_form_profile_setting_page.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/application_form_questions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventApplicationFormSettingPage extends StatelessWidget {
  EventApplicationFormSettingPage({super.key});

  final _scrollController = ScrollController();

  scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    Event? event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    final getEventDetailBloc = context.read<GetEventDetailBloc>();
    int requiredProfileFieldsCount = event?.applicationProfileFields?.fold(
          0,
          (sum, field) => sum! + (field.required == true ? 1 : 0),
        ) ??
        0;
    int optionalProfileFieldsCount = event?.applicationProfileFields?.fold(
          0,
          (sum, field) => sum! + (field.required == false ? 1 : 0),
        ) ??
        0;

    return BlocProvider(
      create: (context) => EventApplicationFormSettingBloc(
        initialQuestions: event?.applicationQuestions ?? [],
      ),
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.event.applicationForm.applicationFormTitle,
        ),
        resizeToAvoidBottomInset: false,
        body: BlocListener<EventApplicationFormSettingBloc,
            EventApplicationFormSettingBlocState>(
          listener: (context, state) {
            if (state.status == EventApplicationFormStatus.success) {
              SnackBarUtils.showSuccess(
                message: t.event.applicationForm.saveFormSuccessfully,
              );
              getEventDetailBloc.add(
                GetEventDetailEvent.fetch(
                  eventId: eventId,
                ),
              );
              AutoRouter.of(context).pop();
            }
          },
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.smMedium),
                      ),
                      SliverToBoxAdapter(
                        child: InkWell(
                          onTap: () {
                            BottomSheetUtils.showSnapBottomSheetWithRadius(
                              context,
                              color: LemonColor.atomicBlack,
                              child: EventApplicationFormProfileSettingPage(
                                event: event,
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(Spacing.smMedium),
                            decoration: BoxDecoration(
                              color: LemonColor.white06,
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.normal),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      LemonRadius.large * 2,
                                    ),
                                    color: LemonColor.white06,
                                  ),
                                  width: Sizing.medium,
                                  height: Sizing.medium,
                                  child: Center(
                                    child: ThemeSvgIcon(
                                      color: colorScheme.onSecondary,
                                      builder: (filter) =>
                                          Assets.icons.icProfileOutline.svg(
                                        colorFilter: filter,
                                        width: 15.w,
                                        height: 15.w,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Spacing.small),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t.event.applicationForm.profileInfo,
                                        style: Typo.medium.copyWith(
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        event?.applicationProfileFields
                                                    ?.isEmpty ??
                                                true
                                            ? t.event.applicationForm
                                                .profileInfoDescription
                                            : '$requiredProfileFieldsCount ${t.common.required.toLowerCase()}, $optionalProfileFieldsCount ${t.common.optional.toLowerCase()}',
                                        style: Typo.small.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: Spacing.small),
                                ThemeSvgIcon(
                                  color: colorScheme.onSecondary,
                                  builder: (filter) =>
                                      Assets.icons.icArrowRight.svg(
                                    colorFilter: filter,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: Spacing.large,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Text(
                              t.event.applicationForm.applicationQuestions,
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: Spacing.xSmall,
                            ),
                            BlocBuilder<EventApplicationFormSettingBloc,
                                EventApplicationFormSettingBlocState>(
                              builder: (context, state) => Container(
                                height: 21.w,
                                width: 21.w,
                                decoration: BoxDecoration(
                                  color: colorScheme.outline,
                                  borderRadius: BorderRadius.circular(
                                    LemonRadius.extraSmall,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    state.questions.length.toString(),
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.smMedium),
                      ),
                      SliverToBoxAdapter(
                        child: Focus(
                          onFocusChange: (isFocused) {
                            if (isFocused) {
                              scrollToEnd();
                            } else {
                              scrollToTop();
                            }
                          },
                          child: ApplicationFormQuestions(
                            onAddButtonPressed: scrollToEnd,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 350.w),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.background,
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: SafeArea(
                      child: BlocBuilder<EventApplicationFormSettingBloc,
                          EventApplicationFormSettingBlocState>(
                        builder: (context, state) => Opacity(
                          opacity: state.isValid ? 1 : 0.5,
                          child: LinearGradientButton.primaryButton(
                            onTap: () {
                              if (!state.isValid) return;
                              context
                                  .read<EventApplicationFormSettingBloc>()
                                  .add(
                                    EventApplicationFormSettingBlocEvent
                                        .submitCreate(
                                      eventId: eventId,
                                    ),
                                  );
                            },
                            label: t.event.applicationForm.saveForm,
                            textColor: colorScheme.onPrimary,
                            loadingWhen: state.status ==
                                EventApplicationFormStatus.loading,
                          ),
                        ),
                      ),
                    ),
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
