import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data:
              "${widget.question.question} ${widget.question.isRequired == true ? '**&#42;**' : ''}",
          styleSheet: MarkdownStyleSheet(
            a: appText.md.copyWith(
              color: appColors.textAccent,
              decoration: TextDecoration.none,
            ),
            p: appText.md,
            strong: appText.md.copyWith(
              color: appColors.textError,
            ),
          ),
          onTapLink: (text, href, title) async {
            await launchUrl(Uri.parse(text));
          },
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          decoration: BoxDecoration(
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            border: Border.all(
              color: appColors.pageDivider,
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
                        style: appText.md,
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
                        color: appColors.pageDivider,
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
