import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_select_question_setting_page/event_application_form_select_question_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_text_question_setting_page/event_application_form_text_question_setting_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EventApplicationFormSettingQuestionsList extends StatelessWidget {
  const EventApplicationFormSettingQuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final applicationFormSettingBloc =
        context.read<EventApplicationFormSettingBloc>();
    Event? event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    final appColors = context.theme.appColors;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            t.event.applicationForm.registrationQuestions,
            style: Typo.extraMedium.copyWith(
              color: appColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.small),
        ),
        BlocBuilder<EventApplicationFormSettingBloc,
            EventApplicationFormSettingBlocState>(
          builder: (context, state) {
            if (state.questions.isEmpty) {
              return SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: appColors.cardBg,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    border: Border.all(
                      color: appColors.pageDivider,
                    ),
                  ),
                  child: Row(
                    children: [
                      ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) => Assets.icons.icInfo.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.event.applicationForm.noQuestions,
                              style: Typo.medium.copyWith(
                                color: appColors.textPrimary,
                              ),
                            ),
                            Text(
                              t.event.applicationForm.noQuestionsDescription,
                              style: Typo.small.copyWith(
                                color: appColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverList.separated(
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                final question = state.questions[index];
                return _QuestionItem(
                  question: question,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      topRadius: Radius.circular(LemonRadius.medium),
                      builder: (context) => BlocProvider.value(
                        value: applicationFormSettingBloc,
                        child: question.type == Enum$QuestionType.text
                            ? EventApplicationFormTextQuestionSettingPage(
                                event: event,
                                initialQuestion: question,
                                index: index,
                              )
                            : EventApplicationFormSelectQuestionSettingPage(
                                event: event,
                                initialQuestion: question,
                                index: index,
                                selectType: question.select_type,
                              ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: Spacing.small);
              },
            );
          },
        ),
      ],
    );
  }
}

class _QuestionItem extends StatelessWidget {
  const _QuestionItem({
    required this.question,
    required this.onTap,
  });

  final Input$QuestionInput question;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: appColors.pageDivider,
          ),
        ),
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icRoundDrag.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.small),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question ?? '',
                    style: Typo.medium.copyWith(
                      color: appColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (question.type == Enum$QuestionType.text) ...[
                        ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (filter) =>
                              Assets.icons.icInsertTextOutline.svg(
                            colorFilter: filter,
                            width: 12.w,
                            height: 12.w,
                          ),
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Text(
                          t.event.applicationForm.questionType.text,
                          style: Typo.small.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                      if (question.type == Enum$QuestionType.options &&
                          question.select_type == Enum$SelectType.single) ...[
                        ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (filter) => Assets.icons.icSingleSelect.svg(
                            colorFilter: filter,
                            width: 12.w,
                            height: 12.w,
                          ),
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Text(
                          t.event.applicationForm.questionType.singleSelect,
                          style: Typo.small.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                      if (question.type == Enum$QuestionType.options &&
                          question.select_type == Enum$SelectType.multi) ...[
                        ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (filter) => Assets.icons.icMultiSelect.svg(
                            colorFilter: filter,
                            width: 12.w,
                            height: 12.w,
                          ),
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Text(
                          t.event.applicationForm.questionType.multipleSelect,
                          style: Typo.small.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                      if (question.required == true) ...[
                        SizedBox(width: Spacing.superExtraSmall),
                        Text(
                          '• ${t.event.applicationForm.required}',
                          style: Typo.small.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
