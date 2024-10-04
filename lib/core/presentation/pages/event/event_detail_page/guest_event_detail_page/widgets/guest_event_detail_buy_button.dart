import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_buy_tickets_prerequisite_check_bloc/event_buy_tickets_prerequisite_check_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/event/query/get_my_event_join_request.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:matrix/matrix.dart' as matrix;

class GuestEventDetailBuyButton extends StatelessWidget {
  const GuestEventDetailBuyButton({
    super.key,
    required this.event,
    required this.refetch,
  });

  final Event event;
  final Refetch<Query$GetMyEventJoinRequest>? refetch;

  @override
  Widget build(BuildContext context) {
    return _GuestEventDetailBuyButtonView(event: event, refetch: refetch);
  }
}

class _GuestEventDetailBuyButtonView extends StatelessWidget {
  const _GuestEventDetailBuyButtonView({
    required this.event,
    this.refetch,
  });

  final Event event;
  final Refetch<Query$GetMyEventJoinRequest>? refetch;

  String getDisplayPrice() {
    final defaultTicketType =
        ListUtils.findWithConditionOrFirst<EventTicketType>(
      items: event.eventTicketTypes ?? [],
      condition: (ticketType) => ticketType.isDefault == true,
    );

    final defaultPrice = ListUtils.findWithConditionOrFirst<EventTicketPrice>(
      items: defaultTicketType?.prices ?? [],
      condition: (price) => price.isDefault == true,
    );

    final targetPaymentAccount =
        (event.paymentAccountsExpanded ?? []).firstWhereOrNull(
      (element) =>
          element.accountInfo?.currencies?.contains(defaultPrice?.currency) ==
          true,
    );

    final decimals = targetPaymentAccount?.accountInfo?.currencyMap
            ?.tryGet<CurrencyInfo>(defaultPrice?.currency ?? '')
            ?.decimals ??
        0;

    return EventTicketUtils.getDisplayedTicketPrice(
      decimals: decimals,
      price: defaultPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;
    final userId = AuthUtils.getUserId(context);

    return BlocConsumer<EventBuyTicketsPrerequisiteCheckBloc,
        EventBuyTicketsPrerequisiteCheckState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          isNotInvited: () => AutoRouter.of(context).push(
            const GuestEventPrivateAlertRoute(),
          ),
          hasJoinRequest: (joinRequest) {
            AutoRouter.of(context).push(
              GuestEventApprovalStatusRoute(
                event: event,
                eventJoinRequest: joinRequest,
              ),
            );
            if (refetch != null) refetch!();
          },
          applicationFormNotCompleted: (user) async {
            // Application form is moved to events buy tickets page
            await AutoRouter.of(context).navigate(
              EventBuyTicketsRoute(event: event),
            );
          },
          allPassed: () async {
            await AutoRouter.of(context).navigate(
              EventBuyTicketsRoute(event: event),
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading =
            state is EventBuyTicketsPrerequisiteCheckStateChecking;
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Spacing.smMedium,
              horizontal: Spacing.smMedium,
            ),
            child: SizedBox(
              height: Sizing.large,
              child: LinearGradientButton(
                onTap: () {
                  if (isLoading) {
                    return;
                  }
                  authState.maybeWhen(
                    authenticated: (_) async {
                      context.read<EventBuyTicketsPrerequisiteCheckBloc>().add(
                            EventBuyTicketsPrerequisiteCheckEvent.check(
                              event: event,
                              userId: userId,
                            ),
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
                label: getDisplayPrice(),
                radius: BorderRadius.circular(LemonRadius.small * 2),
                mode: GradientButtonMode.lavenderMode,
                loadingWhen: isLoading,
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
      },
    );
  }
}
