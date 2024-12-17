import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RsvpApplicationMultiOptionsQuestion extends StatefulWidget {
  final EventApplicationQuestion question;
  final Input$EventApplicationAnswerInput? answerInput;
  final Function(List<String>) onChange;
  const RsvpApplicationMultiOptionsQuestion({
    super.key,
    required this.question,
    this.answerInput,
    required this.onChange,
  });

  @override
  RsvpApplicationMultiOptionsQuestionState createState() =>
      RsvpApplicationMultiOptionsQuestionState();
}

class RsvpApplicationMultiOptionsQuestionState
    extends State<RsvpApplicationMultiOptionsQuestion> {
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedOptions = widget.answerInput?.answers ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: widget.question.question ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
            children: [
              if (widget.question.isRequired == true)
                TextSpan(
                  text: ' *',
                  style: Typo.mediumPlus.copyWith(
                    color: LemonColor.coralReef,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            border: Border.all(
              color: colorScheme.outlineVariant,
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (widget.question.options ?? []).length,
            itemBuilder: (context, index) {
              final option = (widget.question.options ?? [])[index];
              final selected = selectedOptions.contains(option);
              return InkWell(
                onTap: () {
                  final newSelectedOptions = [...selectedOptions];
                  setState(() {
                    if (selected) {
                      selectedOptions = newSelectedOptions
                          .where((element) => element != option)
                          .toList();
                    } else {
                      selectedOptions = [...newSelectedOptions, option];
                    }
                  });
                  widget.onChange(selectedOptions);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.small,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        child: selected
                            ? Assets.icons.icChecked.svg(
                                width: 20.w,
                                height: 20.w,
                              )
                            : Assets.icons.icUncheck.svg(
                                width: 20.w,
                                height: 20.w,
                              ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Text(
                        option,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 1.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: Spacing.medium * 2),
                    Expanded(
                      child: Divider(
                        thickness: 1.w,
                        color: colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
