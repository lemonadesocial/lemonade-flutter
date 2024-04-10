import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ApplicationFormQuestions extends StatelessWidget {
  final Function()? onAddButtonPressed;
  const ApplicationFormQuestions({
    super.key,
    this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventApplicationFormSettingBloc,
        EventApplicationFormSettingBlocState>(
      builder: (context, state) {
        final questions = state.questions;
        return Column(
          key: Key(questions.length.toString()),
          mainAxisSize: MainAxisSize.min,
          children: [
            ...questions.asMap().entries.map(
                  (entry) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _QuestionFormField(
                        questionInput: entry.value,
                        onLabelChanged: (label) =>
                            context.read<EventApplicationFormSettingBloc>().add(
                                  EventApplicationFormSettingBlocEvent
                                      .updateQuestion(
                                    index: entry.key,
                                    questions:
                                        entry.value.copyWith(question: label),
                                  ),
                                ),
                        onToggleRequired: (requiredValue) {
                          Vibrate.feedback(FeedbackType.light);
                          context.read<EventApplicationFormSettingBloc>().add(
                                EventApplicationFormSettingBlocEvent
                                    .updateQuestion(
                                  index: entry.key,
                                  questions: entry.value
                                      .copyWith(required: requiredValue),
                                ),
                              );
                        },
                        onRemove: () {
                          context.read<EventApplicationFormSettingBloc>().add(
                                EventApplicationFormSettingBlocEvent
                                    .removeQuestion(
                                  index: entry.key,
                                ),
                              );
                        },
                      ),
                      if (entry.key != questions.length - 1)
                        SizedBox(height: Spacing.medium),
                    ],
                  ),
                ),
            SizedBox(
              height: Spacing.medium,
            ),
            _AddButton(
              onPress: () async {
                context.read<EventApplicationFormSettingBloc>().add(
                      EventApplicationFormSettingBlocEvent.addQuestion(),
                    );
                await Future.delayed(const Duration(milliseconds: 300));
                onAddButtonPressed?.call();
              },
            ),
          ],
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final Function()? onPress;
  const _AddButton({
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            width: Sizing.xLarge,
            height: Sizing.xLarge,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.xLarge),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionFormField extends StatelessWidget {
  final Input$QuestionInput questionInput;
  final Function(String value)? onLabelChanged;
  final Function()? onRemove;
  final Function(bool value)? onToggleRequired;

  const _QuestionFormField({
    required this.questionInput,
    this.onLabelChanged,
    this.onRemove,
    this.onToggleRequired,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                ),
                child: Column(
                  children: [
                    LemonTextField(
                      initialText: questionInput.question,
                      hintText: t.event.applicationForm.enterQuestion,
                      onChange: onLabelChanged,
                      borderColor: Colors.transparent,
                    ),
                    Container(
                      height: Sizing.large,
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      decoration: BoxDecoration(
                        color: LemonColor.white06,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(LemonRadius.small),
                          bottomRight: Radius.circular(LemonRadius.small),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.event.applicationForm.required,
                            style: Typo.medium
                                .copyWith(color: colorScheme.onSecondary),
                          ),
                          FlutterSwitch(
                            inactiveColor: colorScheme.outline,
                            inactiveToggleColor: colorScheme.onSurfaceVariant,
                            activeColor: LemonColor.paleViolet,
                            activeToggleColor: colorScheme.onPrimary,
                            height: 24.h,
                            width: 42.w,
                            value: questionInput.required ?? false,
                            onToggle: (value) {
                              if (onToggleRequired != null) {
                                onToggleRequired!(value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            InkWell(
              onTap: onRemove,
              child: Container(
                width: Sizing.regular,
                height: Sizing.regular,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.normal),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icClose.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
