import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/buy_event_ticket_bloc/buy_event_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventDetailBuyButton extends StatelessWidget {
  const GuestEventDetailBuyButton({
    super.key,
    required this.event,
    this.onBuySuccess,
  });

  final Event event;
  final VoidCallback? onBuySuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyEventTicketBloc(event: event),
      child: _GuestEventDetailBuyButtonView(
        event: event,
        onBuySuccess: onBuySuccess,
      ),
    );
  }
}

class _GuestEventDetailBuyButtonView extends StatelessWidget {
  const _GuestEventDetailBuyButtonView({
    required this.event,
    this.onBuySuccess,
  });

  final Event event;
  final VoidCallback? onBuySuccess;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final authState = context.watch<AuthBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;
    final buttonText = event.cost != null
        ? NumberUtils.formatCurrency(
            amount: event.cost!,
            currency: event.currency,
            freeText:
                '${t.event.tickets(n: 1)}  •  ${StringUtils.capitalize(t.event.free)}',
            prefix: '${t.event.tickets(n: 1)}  •  ',
          )
        : t.event.free;
    return SafeArea(
      child: Container(
        color: colorScheme.primary,
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.smMedium,
        ),
        child: SizedBox(
          height: Sizing.large,
          child: LinearGradientButton(
            onTap: () {
              authState.maybeWhen(
                authenticated: (_) {
                  AutoRouter.of(context).navigate(
                    EventBuyTicketsRoute(event: event),
                  );
                },
                orElse: () {
                  AutoRouter.of(context).navigate(
                    const LoginRoute(),
                  );
                },
              );
            },
            leading: ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) =>
                  Assets.icons.icTicketBold.svg(colorFilter: filter),
            ),
            label: StringUtils.capitalize(buttonText),
            radius: BorderRadius.circular(LemonRadius.small * 2),
            mode: GradientButtonMode.lavenderMode,
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
