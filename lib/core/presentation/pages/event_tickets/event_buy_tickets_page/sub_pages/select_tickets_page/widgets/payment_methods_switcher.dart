import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodsSwitcher extends StatelessWidget {
  final Function(SelectTicketsPaymentMethod paymentMethod) onSelect;
  final SelectTicketsPaymentMethod selectedPaymentMethod;

  const PaymentMethodsSwitcher({
    super.key,
    required this.onSelect,
    required this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: _MethodItem(
            selected: selectedPaymentMethod == SelectTicketsPaymentMethod.card,
            label: t.event.eventBuyTickets.paymentMethods.card,
            icon: Assets.icons.icCash.svg(),
            onPressed: () {
              onSelect(SelectTicketsPaymentMethod.card);
            },
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          child: _MethodItem(
            selected:
                selectedPaymentMethod == SelectTicketsPaymentMethod.wallet,
            label: t.event.eventBuyTickets.paymentMethods.wallet,
            icon: Assets.icons.icWallet.svg(),
            onPressed: () {
              onSelect(SelectTicketsPaymentMethod.wallet);
            },
          ),
        ),
      ],
    );
  }
}

class _MethodItem extends StatelessWidget {
  final bool selected;
  final String label;
  final SvgPicture icon;
  final Function() onPressed;

  const _MethodItem({
    required this.selected,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor =
        selected ? LemonColor.paleViolet18 : LemonColor.atomicBlack;
    final textColor =
        selected ? LemonColor.paleViolet : colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              child: icon,
            ),
            SizedBox(width: Spacing.xSmall),
            Text(
              label,
              style: Typo.medium.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
