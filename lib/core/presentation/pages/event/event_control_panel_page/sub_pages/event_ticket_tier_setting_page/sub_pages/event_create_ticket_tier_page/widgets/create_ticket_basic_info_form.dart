import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CreateTicketBasicInfoForm extends StatelessWidget {
  const CreateTicketBasicInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.whatIsTicketName,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Sizing.xLarge,
              height: Sizing.xLarge,
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                color: LemonColor.raisinBlack,
              ),
              child: Center(
                child: ThemeSvgIcon(
                  builder: (filter) => Assets.icons.icAddPhoto.svg(
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: LemonTextField(
                hintText: t.event.ticketTierSetting.ticketName,
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.smMedium),
        LemonTextField(
          hintText: t.event.ticketTierSetting.ticketDescription,
        ),
      ],
    );
  }
}
