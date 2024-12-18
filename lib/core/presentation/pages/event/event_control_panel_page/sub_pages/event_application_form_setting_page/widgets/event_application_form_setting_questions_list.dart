import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_select_question_setting_page/event_application_form_select_question_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_text_question_setting_page/event_application_form_text_question_setting_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            t.event.applicationForm.registrationQuestions,
            style: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
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
                    color: LemonColor.atomicBlack,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
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
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              t.event.applicationForm.noQuestionsDescription,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
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
                  onDelete: () {
                    applicationFormSettingBloc.add(
                      EventApplicationFormSettingBlocEvent.removeQuestion(
                        index: index,
                      ),
                    );
                  },
                  onEdit: () {
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
    required this.onEdit,
    required this.onDelete,
  });

  final Input$QuestionInput question;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      padding: EdgeInsets.all(Spacing.small),
      child: Row(
        children: [
          ThemeSvgIcon(
            color: LemonColor.white18,
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
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    if (question.type == Enum$QuestionType.text) ...[
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) =>
                            Assets.icons.icInsertTextOutline.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        t.event.applicationForm.questionType.text,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                    if (question.type == Enum$QuestionType.options &&
                        question.select_type == Enum$SelectType.single) ...[
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icSingleSelect.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        t.event.applicationForm.questionType.singleSelect,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                    if (question.type == Enum$QuestionType.options &&
                        question.select_type == Enum$SelectType.multi) ...[
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icMultiSelect.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        t.event.applicationForm.questionType.multipleSelect,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                    if (question.required == true) ...[
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        '• ${t.event.applicationForm.required}',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: "edit",
              onChanged: (value) {
                if (value == "edit") {
                  onEdit();
                } else if (value == "delete") {
                  onDelete();
                }
              },
              customButton: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: "edit",
                  child: Text(
                    StringUtils.capitalize(t.common.actions.edit),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "delete",
                  child: Text(
                    t.common.actions.remove,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
              dropdownStyleData: DropdownStyleData(
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                  color: colorScheme.secondaryContainer,
                ),
                offset: Offset(0, -Spacing.superExtraSmall),
              ),
              menuItemStyleData: const MenuItemStyleData(
                overlayColor: MaterialStatePropertyAll(
                  LemonColor.darkBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
