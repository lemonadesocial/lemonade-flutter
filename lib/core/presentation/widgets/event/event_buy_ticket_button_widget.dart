import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventBuyTicketButton extends StatelessWidget {
  final Event event;
  const EventBuyTicketButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [LemonColor.arsenic, LemonColor.charlestonGreen],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LemonRadius.normal)),
          shadows: [
            BoxShadow(
              color: LemonColor.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => Assets.icons.icTicket.svg(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              event.cost != null
                  ? NumberUtils.formatCurrency(
                      amount: event.cost!,
                      currency: event.currency,
                      freeText: t.event.free,
                      prefix: '${t.event.buy} • ',
                    )
                  : t.event.free,
              style: Typo.small.copyWith(color: colorScheme.onPrimary),
            )
          ],
        ),
      ),
    );
  }
}
