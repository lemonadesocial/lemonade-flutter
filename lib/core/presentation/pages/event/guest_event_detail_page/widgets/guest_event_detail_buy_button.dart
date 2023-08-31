import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestEventDetailBuyButton extends StatelessWidget {
  const GuestEventDetailBuyButton({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final buttonText = event.cost != null
        ? NumberUtils.formatCurrency(
            amount: event.cost!,
            currency: event.currency,
            freeText: '${t.event.buyTickets}  •  ${StringUtils.capitalize(t.event.free)}',
            prefix: '${t.event.buyTickets}  •  ',
          )
        : t.event.free;
    return SafeArea(
      child: Container(
        color: colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: Spacing.smMedium, horizontal: Spacing.smMedium),
        child: SizedBox(
          height: Sizing.large,
          child: LinearGradientButton(
            leading: Assets.icons.icTicket.svg(),
            radius: BorderRadius.circular(LemonRadius.small * 2),
            mode: GradientButtonMode.lavenderMode,
            label: StringUtils.capitalize(buttonText),
            textStyle: Typo.medium.copyWith(
              fontFamily: FontFamily.nohemiVariable,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary.withOpacity(0.87),
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
