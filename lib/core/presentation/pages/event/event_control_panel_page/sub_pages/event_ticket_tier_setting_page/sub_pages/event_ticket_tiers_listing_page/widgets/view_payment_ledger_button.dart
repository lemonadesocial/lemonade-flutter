import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewPaymentLedgerButton extends StatelessWidget {
  const ViewPaymentLedgerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    return InkWell(
      onTap: () {
        if (event != null) {
          context.router.root.push(
            EventPaymentLedgerRoute(
              event: event,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icBook.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Text(
                t.event.eventPaymentLedger.paymentLedger,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
