import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/sub_pages/event_ticket_tier_whitelist_form_page/widgets/add_email_to_whitelist_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EventTicketTierWhitelistFormPage extends StatelessWidget {
  const EventTicketTierWhitelistFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.ticketTierSetting.whitelistSetting.whitelistSettingTitle,
      ),
      body: BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
        builder: (context, state) {
          final currentTicketType =
              context.read<ModifyTicketTypeBloc>().initialTicketType;
          final currentWhitelist =
              (currentTicketType?.limitedWhitelistUsers ?? [])
                  .map((item) => item.email ?? '')
                  .toList();
          final displayWhitelistEmails = <String>{
            // current ticket white list emails,
            ...currentWhitelist,
            // added whitelist email in bloc
            ...state.addedWhitelistEmails,
            // filter email which is in removed whitelist
          }
              .where(
                (element) => !state.removedWhitelistEmails.contains(element),
              )
              .toList();
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: CustomScrollView(
                  slivers: [
                    if (displayWhitelistEmails.isEmpty)
                      const SliverToBoxAdapter(
                        child: EmptyList(),
                      ),
                    if (displayWhitelistEmails.isNotEmpty)
                      SliverList.separated(
                        itemCount: displayWhitelistEmails.length,
                        itemBuilder: (context, index) => _EmailItem(
                          email: displayWhitelistEmails[index],
                          onRemove: (email) {
                            // check if email is current whitelist
                            final isInCurrentWhitelist =
                                currentWhitelist.contains(email);
                            // yes ?
                            // => added to removed whitelist
                            if (isInCurrentWhitelist) {
                              context.read<ModifyTicketTypeBloc>().add(
                                    ModifyTicketTypeEvent.onWhitelistRemoved(
                                      email: email,
                                    ),
                                  );
                              return;
                            }
                            // no ?
                            // => update added whitelist
                            context.read<ModifyTicketTypeBloc>().add(
                                  ModifyTicketTypeEvent
                                      .onWhitelistAddedModified(
                                    emails: state.addedWhitelistEmails
                                        .where((item) => item != email)
                                        .toList(),
                                  ),
                                );
                          },
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: Spacing.xSmall,
                        ),
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.background,
                      border: Border(
                        top: BorderSide(color: colorScheme.outline),
                      ),
                    ),
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: LinearGradientButton.primaryButton(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          bounce: true,
                          backgroundColor: LemonColor.atomicBlack,
                          context: context,
                          builder: (newContext) {
                            return AddEmailToWhiteListBottomSheet(
                              onSubmit: (addedEmails) =>
                                  context.read<ModifyTicketTypeBloc>().add(
                                        ModifyTicketTypeEvent.onWhitelistAdded(
                                          emails: addedEmails,
                                        ),
                                      ),
                            );
                          },
                        );
                      },
                      label:
                          t.event.ticketTierSetting.whitelistSetting.addEmail,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmailItem extends StatelessWidget {
  final String email;
  final Function(String email) onRemove;
  const _EmailItem({
    required this.email,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.icEmailAt.svg(),
              SizedBox(width: Spacing.extraSmall),
              Text(
                email,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              onRemove(email);
            },
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (colorFilter) => Assets.icons.icClose.svg(
                colorFilter: colorFilter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
