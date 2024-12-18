import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_required_switch.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_text_input.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class _InputOption {
  final String value;
  final UniqueKey key;
  _InputOption({
    required this.value,
    required this.key,
  });
}

class EventApplicationFormSelectQuestionSettingPage extends StatefulWidget {
  const EventApplicationFormSelectQuestionSettingPage({
    super.key,
    required this.event,
    required this.selectType,
    this.index,
    this.initialQuestion,
  });

  final Event? event;
  final int? index;
  final Input$QuestionInput? initialQuestion;
  final Enum$SelectType? selectType;

  @override
  State<EventApplicationFormSelectQuestionSettingPage> createState() =>
      _EventApplicationFormSelectQuestionSettingPageState();
}

class _EventApplicationFormSelectQuestionSettingPageState
    extends State<EventApplicationFormSelectQuestionSettingPage> {
  final _scrollController = ScrollController();
  late Input$QuestionInput question;
  List<_InputOption> options = [];

  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      question = widget.initialQuestion?.copyWith(
            options: [...widget.initialQuestion?.options ?? [], ""],
          ) ??
          Input$QuestionInput(
            type: Enum$QuestionType.options,
            required: false,
            select_type: widget.selectType,
            options: [""],
          );
      options = question.options
              ?.map((option) => _InputOption(value: option, key: UniqueKey()))
              .toList() ??
          [
            _InputOption(value: "", key: UniqueKey()),
          ];
    });
  }

  bool get isValid {
    final isQuestionTitleValid = question.question?.isNotEmpty ?? false;
    final isOptionsValid = options.isNotEmpty;
    final isOptionItemValid = options.any((option) => option.value.isNotEmpty);
    return isQuestionTitleValid && isOptionsValid && isOptionItemValid;
  }

  void onOptionItemChanged({
    required int index,
    required String value,
  }) {
    final newOptions = [...options];
    if (index == options.length - 1 && value.isNotEmpty) {
      newOptions.add(_InputOption(value: "", key: UniqueKey()));
      scrollToEnd();
    }
    newOptions[index] = _InputOption(value: value, key: options[index].key);
    setState(() {
      options = newOptions;
    });
  }

  void onOptionItemRemoved({
    required int index,
  }) {
    final newOptions = [...options];
    if (newOptions.length == 1) {
      return;
    }
    newOptions.removeAt(index);
    if (newOptions.length == 1 && newOptions.first.value.isNotEmpty) {
      newOptions.add(_InputOption(value: "", key: UniqueKey()));
      scrollToEnd();
    }
    setState(() {
      options = newOptions;
    });
  }

  void onSave() {
    if (!isValid) return;
    Vibrate.feedback(FeedbackType.light);
    question = question.copyWith(
      options: options
          .where((option) => option.value.isNotEmpty)
          .map((option) => option.value)
          .toList(),
    );
    if (widget.index != null) {
      context.read<EventApplicationFormSettingBloc>().add(
            EventApplicationFormSettingBlocEvent.updateQuestion(
              index: widget.index!,
              question: question,
            ),
          );
    } else {
      context.read<EventApplicationFormSettingBloc>().add(
            EventApplicationFormSettingBlocEvent.addQuestion(
              question: question,
            ),
          );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.applicationForm.addQuestion,
        actions: [
          Opacity(
            opacity: isValid ? 1.0 : 0.5,
            child: LemonOutlineButton(
              radius: BorderRadius.circular(LemonRadius.button),
              backgroundColor: LemonColor.white87,
              textColor: colorScheme.primary,
              onTap: onSave,
              label: t.common.actions.save,
            ),
          ),
          SizedBox(width: Spacing.small),
        ],
        backgroundColor: LemonColor.atomicBlack,
      ),
      backgroundColor: LemonColor.atomicBlack,
      body: Column(
        children: [
          AddQuestionInfoWidget(
            title: widget.selectType == Enum$SelectType.single
                ? t.event.applicationForm.questionType.singleSelect
                : t.event.applicationForm.questionType.multipleSelect,
            description: widget.selectType == Enum$SelectType.single
                ? t.event.applicationForm.questionType.singleSelectDescription
                : t.event.applicationForm.questionType
                    .multipleSelectDescription,
            icon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => widget.selectType == Enum$SelectType.single
                  ? Assets.icons.icSingleSelect.svg(
                      colorFilter: filter,
                    )
                  : Assets.icons.icMultiSelect.svg(
                      colorFilter: filter,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.small,
                vertical: Spacing.medium,
              ),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: AddQuestionTextInput(
                      onChange: (value) {
                        setState(() {
                          question = question.copyWith(question: value);
                        });
                      },
                      initialValue: question.question,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.xSmall),
                  ),
                  SliverToBoxAdapter(
                    child: Text(t.event.applicationForm.options),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.xSmall),
                  ),
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      return _OptionItem(
                        key: options[index].key,
                        option: options[index].value,
                        onChange: (value) {
                          onOptionItemChanged(
                            index: index,
                            value: value,
                          );
                        },
                        onRemove: () {
                          onOptionItemRemoved(
                            index: index,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: Spacing.xSmall);
                    },
                    itemCount: options.length,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.xSmall),
                  ),
                  SliverToBoxAdapter(
                    child: AddQuestionRequiredSwitch(
                      isRequired: question.required ?? false,
                      onChanged: (value) {
                        setState(() {
                          question = question.copyWith(required: value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String option;
  final Function(String value) onChange;
  final Function() onRemove;
  const _OptionItem({
    super.key,
    required this.option,
    required this.onChange,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonTextField(
      suffixIcon: InkWell(
        onTap: onRemove,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCloseCircle.svg(
                colorFilter: filter,
                width: 18.w,
                height: 18.w,
              ),
            ),
          ],
        ),
      ),
      radius: LemonRadius.medium,
      fillColor: LemonColor.chineseBlack,
      filled: true,
      onChange: (value) {
        onChange(value);
      },
      hintText: t.event.applicationForm.addOption,
      initialText: option,
    );
  }
}
