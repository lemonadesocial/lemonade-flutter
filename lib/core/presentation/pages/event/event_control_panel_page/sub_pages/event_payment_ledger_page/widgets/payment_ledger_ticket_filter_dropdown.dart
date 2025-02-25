import 'package:app/core/domain/event/entities/ticket_statistics.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/payment/query/list_event_payments.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentLedgerTicketFilterDropdown extends StatefulWidget {
  final Variables$Query$ListEventPayments filterVariables;
  final Function(Variables$Query$ListEventPayments) onChanged;
  final TicketStatistics? ticketStatistics;

  const PaymentLedgerTicketFilterDropdown({
    super.key,
    required this.filterVariables,
    required this.onChanged,
    required this.ticketStatistics,
  });

  @override
  State<PaymentLedgerTicketFilterDropdown> createState() =>
      _PaymentLedgerTicketFilterDropdownState();
}

class _PaymentLedgerTicketFilterDropdownState
    extends State<PaymentLedgerTicketFilterDropdown> {
  void _onAllTicketsSelected() {
    widget.onChanged(
      widget.filterVariables.copyWith(
        checkedIn: null,
      ),
    );
  }

  void _onCheckedInSelected(bool isCheckedIn) {
    widget.onChanged(
      widget.filterVariables.copyWith(
        checkedIn: isCheckedIn,
      ),
    );
  }

  void _onTicketTypeSelected(String ticketTypeId, bool isSelected) {
    final currentTicketTypes = widget.filterVariables.ticketTypes ?? [];
    final updatedTicketTypes = isSelected
        ? [...currentTicketTypes, ticketTypeId]
        : currentTicketTypes.where((id) => id != ticketTypeId).toList();

    widget.onChanged(
      widget.filterVariables.copyWith(
        ticketTypes: updatedTicketTypes.isEmpty ? null : updatedTicketTypes,
      ),
    );
  }

  String get displayText {
    final t = Translations.of(context);
    if (widget.filterVariables.checkedIn == null) {
      return t.event.eventPaymentLedger.allGuests;
    }
    if (widget.filterVariables.checkedIn == true) {
      return t.event.eventPaymentLedger.checkedIn;
    }
    return t.event.eventPaymentLedger.notCheckedIn;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<void>(
      constraints: BoxConstraints(
        minWidth: 244.w,
        maxWidth: 244.w,
      ),
      offset: Offset(0, Spacing.superExtraSmall),
      color: LemonColor.atomicBlack,
      padding: EdgeInsets.zero,
      elevation: 0,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.none,
      child: LemonOutlineButton(
        label: displayText,
        textColor: colorScheme.onPrimary,
        backgroundColor: LemonColor.chineseBlack,
        borderColor: LemonColor.chineseBlack,
        radius: BorderRadius.circular(LemonRadius.button),
        trailing: ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
            colorFilter: filter,
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AllGuestsItem(
                    count: widget.ticketStatistics?.all?.toInt() ?? 0,
                    isSelected: widget.filterVariables.checkedIn == null,
                    onTap: () {
                      _onAllTicketsSelected();
                      setState(() {});
                    },
                  ),
                  _CheckedInItem(
                    ticketStatistics: widget.ticketStatistics,
                    isCheckedIn: widget.filterVariables.checkedIn,
                    onTap: (isCheckedIn) {
                      _onCheckedInSelected(isCheckedIn);
                      setState(() {});
                    },
                  ),
                  Divider(
                    height: 1.w,
                    color: colorScheme.outlineVariant,
                  ),
                  if (widget.ticketStatistics?.ticketTypes?.isNotEmpty ==
                      true) ...[
                    ...widget.ticketStatistics!.ticketTypes!.map(
                      (ticketType) => _TicketTypeItem(
                        ticketType: ticketType,
                        isSelected: widget.filterVariables.ticketTypes
                                ?.contains(ticketType.ticketType) ??
                            false,
                        onTicketTypeSelected: (ticketTypeId, isSelected) {
                          _onTicketTypeSelected(ticketTypeId, isSelected);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AllGuestsItem extends StatelessWidget {
  final int count;
  final bool isSelected;
  final Function() onTap;

  const _AllGuestsItem({
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.extraSmall,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${t.event.eventPaymentLedger.allGuests} ($count)',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            if (isSelected)
              ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icDone.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CheckedInItem extends StatelessWidget {
  final TicketStatistics? ticketStatistics;
  final Function(bool) onTap;
  final bool? isCheckedIn;

  const _CheckedInItem({
    required this.ticketStatistics,
    required this.onTap,
    required this.isCheckedIn,
  });

  int get allCount => ticketStatistics?.all?.toInt() ?? 0;

  int get checkedInCount => ticketStatistics?.checkedIn?.toInt() ?? 0;

  int get notCheckedInCount => allCount - checkedInCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap(true);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
              vertical: Spacing.extraSmall,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${t.event.eventPaymentLedger.checkedIn} ($checkedInCount)',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                if (isCheckedIn == true)
                  ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icDone.svg(
                      colorFilter: filter,
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onTap(false);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
              vertical: Spacing.extraSmall,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${t.event.eventPaymentLedger.notCheckedIn} ($notCheckedInCount)',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                if (isCheckedIn == false)
                  ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icDone.svg(
                      colorFilter: filter,
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TicketTypeItem extends StatelessWidget {
  final TicketStatisticPerTier ticketType;
  final bool isSelected;
  final Function(String, bool) onTicketTypeSelected;

  const _TicketTypeItem({
    required this.ticketType,
    required this.isSelected,
    required this.onTicketTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => onTicketTypeSelected(ticketType.ticketType, !isSelected),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.xSmall,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${ticketType.ticketTypeTitle} (${ticketType.count.toInt()})',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  onTicketTypeSelected(ticketType.ticketType, value ?? false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
