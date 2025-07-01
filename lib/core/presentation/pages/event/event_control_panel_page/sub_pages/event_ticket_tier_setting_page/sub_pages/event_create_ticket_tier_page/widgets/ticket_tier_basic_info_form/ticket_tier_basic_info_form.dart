import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_category_form/ticket_category_dropdown.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketTierBasicInforForm extends StatefulWidget {
  const TicketTierBasicInforForm({
    super.key,
  });

  @override
  State<TicketTierBasicInforForm> createState() =>
      _TicketTierBasicInforFormState();
}

class _TicketTierBasicInforFormState extends State<TicketTierBasicInforForm> {
  bool _descriptionVisible = false;
  bool _categoryVisible = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final modifyTicketTypeBloc = context.read<ModifyTicketTypeBloc>();
    final event = context
        .read<GetEventDetailBloc>()
        .state
        .maybeWhen(orElse: () => null, fetched: (event) => event);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
          buildWhen: (prev, cur) => prev.title.value != cur.title.value,
          builder: (context, state) {
            return LemonTextField(
              initialText: modifyTicketTypeBloc.initialTicketType?.title ?? '',
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
              radius: LemonRadius.medium,
            );
          },
        ),
        SizedBox(height: Spacing.xSmall),
        if (_descriptionVisible ||
            modifyTicketTypeBloc.initialTicketType?.description?.isNotEmpty ==
                true)
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
              radius: LemonRadius.medium,
            ),
          )
        else
          InkWell(
            onTap: () {
              setState(() {
                _descriptionVisible = true;
              });
            },
            child: Row(
              children: [
                Assets.icons.icPlus.svg(),
                SizedBox(width: Spacing.extraSmall),
                Text(
                  t.event.ticketTierSetting.addTicketDescription,
                  style: Typo.medium.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: Spacing.smMedium),
        if (event != null &&
            (_categoryVisible ||
                modifyTicketTypeBloc.state.category?.isNotEmpty == true))
          TicketCategoryDropdown(event: event)
        else
          InkWell(
            onTap: () {
              setState(() {
                _categoryVisible = true;
              });
            },
            child: Row(
              children: [
                Assets.icons.icPlus.svg(),
                SizedBox(width: Spacing.extraSmall),
                Text(
                  t.event.ticketTierSetting.addTicketCategory,
                  style: Typo.medium.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
