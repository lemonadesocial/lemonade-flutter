import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_page/widgets/application_form_questions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileFieldKeyOption {
  final int id;
  final String fieldKey;
  final String label;

  ProfileFieldKeyOption({
    required this.id,
    required this.fieldKey,
    required this.label,
  });
}

@RoutePage()
class EventApplicationFormQuestionsPage extends StatelessWidget {
  final _scrollController = ScrollController();

  EventApplicationFormQuestionsPage({super.key});

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
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    final getEventDetailBloc = context.read<GetEventDetailBloc>();

    List<ProfileFieldKeyOption> profileFieldKeyOptions = [];
    for (var element in ProfileFieldKey.values) {
      profileFieldKeyOptions.add(
        ProfileFieldKeyOption(
          id: element.index,
          fieldKey: element.fieldKey,
          label: element.label,
        ),
      );
    }
    // final items = profileFieldKeyOptions
    //     .map(
    //       (fieldKeyOption) => MultiSelectItem<ProfileFieldKeyOption>(
    //           fieldKeyOption, fieldKeyOption.label),
    //     )
    //     .toList();
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.applicationForm.applicationFormTitle,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocListener<EventApplicationFormSettingBloc,
          EventApplicationFormSettingBlocState>(
        listener: (context, state) {
          if (state.status == EventApplicationFormStatus.success) {
            SnackBarUtils.showSuccessSnackbar(
              t.event.applicationForm.saveFormSuccessfully,
            );
            getEventDetailBloc.add(
              GetEventDetailEvent.fetch(
                eventId: eventId,
              ),
            );
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
                    // SliverToBoxAdapter(
                    //   child: BlocBuilder<EventApplicationFormSettingBloc,
                    //       EventApplicationFormSettingBlocState>(
                    //     builder: (context, state) => Container(
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 1,
                    //           color: colorScheme.outlineVariant,
                    //         ),
                    //         borderRadius:
                    //             BorderRadius.circular(LemonRadius.small),
                    //       ),
                    //       child: MultiSelectBottomSheetField(
                    //         initialChildSize: 0.6,
                    //         listType: MultiSelectListType.LIST,
                    //         searchable: false,
                    //         itemsTextStyle: Typo.medium
                    //             .copyWith(color: colorScheme.onPrimary),
                    //         selectedItemsTextStyle: Typo.medium
                    //             .copyWith(color: colorScheme.onPrimary),
                    //         selectedColor: colorScheme.primaryContainer,
                    //         checkColor: colorScheme.onPrimary,
                    //         buttonText:
                    //             Text(t.event.applicationForm.profileInfo),
                    //         cancelText:
                    //             Text(t.common.actions.cancel.toUpperCase()),
                    //         confirmText:
                    //             Text(t.common.actions.ok.toUpperCase()),
                    //         title: Padding(
                    //           padding: EdgeInsets.only(
                    //             left: Spacing.smMedium,
                    //             right: Spacing.smMedium,
                    //             top: Spacing.medium,
                    //           ),
                    //           child: Text(
                    //             t.event.applicationForm.profileInfoDescription,
                    //             style: Typo.extraLarge.copyWith(
                    //               color: colorScheme.onPrimary,
                    //               fontWeight: FontWeight.w800,
                    //               fontFamily: FontFamily.nohemiVariable,
                    //             ),
                    //           ),
                    //         ),
                    //         items: items,
                    //         onConfirm: (values) {
                    //           List<String> requiredProfileFields = [
                    //             ...values
                    //                 .whereType<ProfileFieldKeyOption>()
                    //                 .map((option) => option.fieldKey),
                    //           ];
                    //           context
                    //               .read<EventApplicationFormSettingBloc>()
                    //               .add(
                    //                 EventApplicationFormSettingBlocEvent
                    //                     .updateRequiredProfileFields(
                    //                   requiredProfileFields:
                    //                       requiredProfileFields,
                    //                 ),
                    //               );
                    //         },
                    //         chipDisplay: MultiSelectChipDisplay(
                    //           chipColor: colorScheme.secondaryContainer,
                    //           textStyle: Typo.medium
                    //               .copyWith(color: colorScheme.onPrimary),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Spacing.xLarge),
                        width: MediaQuery.of(context).size.width,
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 2,
                          dashColor: colorScheme.secondary,
                        ),
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
                                  style: Typo.mediumPlus.copyWith(
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
                            context.read<EventApplicationFormSettingBloc>().add(
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
    );
  }
}
