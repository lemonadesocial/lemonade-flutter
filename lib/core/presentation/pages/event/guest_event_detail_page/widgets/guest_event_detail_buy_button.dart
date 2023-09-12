import 'package:app/core/application/event/buy_event_ticket_bloc/buy_event_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final buttonText = event.cost != null
        ? NumberUtils.formatCurrency(
            amount: event.cost!,
            currency: event.currency,
            freeText:
                '${t.event.tickets}  •  ${StringUtils.capitalize(t.event.free)}',
            prefix: '${t.event.tickets}  •  ',
          )
        : t.event.free;
    return BlocConsumer<BuyEventTicketBloc, BuyEventTicketState>(
      listener: (context, newState) {
        newState.maybeWhen(
          success: () {
            onBuySuccess?.call();
          },
          needWebview: () {
            // TODO:wait for UI
            // Tell user payment not support, go to webview
            BottomSheetUtils.showSnapBottomSheet(
              context,
              builder: (context) => EventDetailPage(
                eventId: event.id!,
                eventName: event.title ?? '',
              ),
            );
          },
          failure: () {
            // TODO: wait for UI
            // Tell user buy ticket fail
          },
          orElse: () => null,
        );
      },
      builder: (context, state) => SafeArea(
        child: Container(
          color: colorScheme.primary,
          padding: EdgeInsets.symmetric(
            vertical: Spacing.smMedium,
            horizontal: Spacing.smMedium,
          ),
          child: SizedBox(
            height: Sizing.large,
            child: LinearGradientButton(
              onTap: () => {
                state.maybeWhen(
                  loading: () => null,
                  orElse: () {
                    context
                        .read<BuyEventTicketBloc>()
                        .add(BuyEventTicketEvent.buy());
                  },
                )
              },
              leading: state.maybeWhen(
                loading: () => null,
                orElse: () => ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) =>
                      Assets.icons.icTicketBold.svg(colorFilter: filter),
                ),
              ),
              label: state.maybeWhen(
                loading: () => t.event.processing,
                orElse: () => StringUtils.capitalize(buttonText),
              ),
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
      ),
    );
  }
}
