import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTicketBasicInfoForm extends StatelessWidget {
  const CreateTicketBasicInfoForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final modifyTicketTypeBloc = context.read<ModifyTicketTypeBloc>();

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
            BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
              buildWhen: (prev, cur) => prev.title.value != cur.title.value,
              builder: (context, state) {
                return Expanded(
                  child: LemonTextField(
                    initialText:
                        modifyTicketTypeBloc.initialTicketType?.title ?? '',
                    onChange: (value) {
                      modifyTicketTypeBloc.add(
                        ModifyTicketTypeEvent.onTitleChanged(
                          title: value,
                        ),
                      );
                    },
                    errorText: state.title.displayError
                        ?.getMessage(t.event.ticketTierSetting.ticketName),
                    hintText: t.event.ticketTierSetting.ticketName,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: Spacing.smMedium),
        BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
          builder: (context, state) => LemonTextField(
            initialText:
                modifyTicketTypeBloc.initialTicketType?.description ?? '',
            onChange: (value) {
              modifyTicketTypeBloc.add(
                ModifyTicketTypeEvent.onDescriptionChanged(
                  description: value,
                ),
              );
            },
            hintText: t.event.ticketTierSetting.ticketDescription,
          ),
        ),
      ],
    );
  }
}
