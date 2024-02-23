import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IssueTicketsAssignmentForm extends StatelessWidget {
  const IssueTicketsAssignmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _AssignmentFormField(),
        // _AssignmentFormField(),
        // _AssignmentFormField(),
        SizedBox(
          height: Spacing.medium,
        ),
        _AddButton(
          onPress: () => showComingSoonDialog(context),
        ),
      ],
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

class _AssignmentFormField extends StatelessWidget {
  const _AssignmentFormField();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child: LemonTextField(
            hintText: t.common.email,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          flex: 1,
          child: LemonTextField(
            hintText: "1",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
