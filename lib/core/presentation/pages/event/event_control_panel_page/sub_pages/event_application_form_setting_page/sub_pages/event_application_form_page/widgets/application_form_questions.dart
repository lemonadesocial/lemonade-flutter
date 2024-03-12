import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        index: entry.key,
                        questionInput: entry.value,
                        onLabelChanged: (label) => context
                            .read<EventApplicationFormSettingBloc>()
                            .add(
                              EventApplicationFormSettingBlocEvent
                                  .updateQuestion(
                                index: entry.key,
                                questions: entry.value.copyWith(label: label),
                              ),
                            ),
                        onRemove: () {
                          context.read<EventApplicationFormSettingBloc>().add(
                                EventApplicationFormSettingBlocEvent
                                    .removeQuestion(
                                  index: entry.key,
                                ),
                              );
                        },
                        removable: questions.length > 1,
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
  final Input$EventApplicationQuestion questionInput;
  final Function(String value)? onLabelChanged;
  final Function()? onRemove;
  final bool removable;
  final int index;

  const _QuestionFormField({
    required this.questionInput,
    this.onLabelChanged,
    this.onRemove,
    this.removable = false,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${t.event.applicationForm.question} ${index + 1}',
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
            fontFamily: FontFamily.nohemiVariable,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: LemonTextField(
                  initialText: questionInput.label,
                  hintText: t.event.applicationForm.questionHint,
                  onChange: onLabelChanged,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              InkWell(
                onTap: removable ? onRemove : null,
                child: Container(
                  width: Sizing.medium,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          removable ? Colors.transparent : colorScheme.outline,
                    ),
                    color: removable
                        ? LemonColor.atomicBlack
                        : colorScheme.background,
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
        ),
      ],
    );
  }
}
