import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app_theme/app_theme.dart';

class RsvpApplicationSingleOptionQuestion extends StatefulWidget {
  final EventApplicationQuestion question;
  final Input$EventApplicationAnswerInput? answerInput;
  final Function(String) onChange;

  const RsvpApplicationSingleOptionQuestion({
    super.key,
    required this.question,
    this.answerInput,
    required this.onChange,
  });

  @override
  State<RsvpApplicationSingleOptionQuestion> createState() =>
      _RsvpApplicationSingleOptionQuestionState();
}

class _RsvpApplicationSingleOptionQuestionState
    extends State<RsvpApplicationSingleOptionQuestion> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = widget.answerInput?.answers?.firstOrNull;
    });
  }

  void handleSelection(String value) {
    setState(() {
      selectedItem = value;
    });
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
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
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: selectedItem,
            onChanged: (value) {
              if (value != null) {
                handleSelection(value);
              }
            },
            customButton: Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                border: Border.all(
                  color: appColors.pageDivider,
                ),
                color: appColors.cardBg,
              ),
              child: Row(
                children: [
                  Text(
                    selectedItem ?? t.common.selectAnOption,
                    style: appText.md.copyWith(
                      color: selectedItem == null
                          ? appColors.textTertiary
                          : appColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) =>
                        Assets.icons.icArrowUpDown.svg(colorFilter: filter),
                  ),
                ],
              ),
            ),
            items: (widget.question.options ?? [])
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: _Item(
                      option: option,
                      selected: selectedItem == option,
                    ),
                  ),
                )
                .toList(),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                color: appColors.pageBg,
              ),
              offset: Offset(0, -Spacing.superExtraSmall),
            ),
            menuItemStyleData: MenuItemStyleData(
              overlayColor: WidgetStatePropertyAll(appColors.pageBg),
            ),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String option;
  final bool selected;
  const _Item({
    required this.option,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            option,
            style: appText.md.copyWith(
              color: appColors.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        if (selected)
          ThemeSvgIcon(
            color: appColors.textPrimary,
            builder: (filter) => Assets.icons.icDone.svg(
              colorFilter: filter,
              width: Sizing.mSmall,
              height: Sizing.mSmall,
            ),
          ),
      ],
    );
  }
}
