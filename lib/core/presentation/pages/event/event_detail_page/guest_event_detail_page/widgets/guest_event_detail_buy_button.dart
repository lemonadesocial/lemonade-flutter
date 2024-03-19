import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/buy_event_ticket_bloc/buy_event_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:collection/collection.dart';

class GuestEventDetailBuyButton extends StatelessWidget {
  const GuestEventDetailBuyButton({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyEventTicketBloc(event: event),
      child: _GuestEventDetailBuyButtonView(
        event: event,
      ),
    );
  }
}

class _GuestEventDetailBuyButtonView extends StatelessWidget {
  const _GuestEventDetailBuyButtonView({
    required this.event,
  });

  final Event event;

  Future<Either<Failure, EventJoinRequest?>?> _checkJoinRequest(
    BuildContext context,
  ) async {
    final result =
        await showFutureLoadingDialog<Either<Failure, EventJoinRequest?>>(
      context: context,
      future: () => getIt<EventRepository>()
          .getMyEventJoinRequest(eventId: event.id ?? ''),
    );
    return result.result;
  }

  Future<void> _checkProfileRequiredFields(BuildContext context) async {
    List<String> profileRequiredFields = (event.applicationProfileFields ?? [])
        .where((e) => e.required == true)
        .map((e) => e.field ?? '')
        .map(StringUtils.snakeToCamel)
        .toList();

    final userResult = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<UserRepository>().getMe(),
    );

    User? user = userResult.result?.fold((l) => null, (user) => user);
    if (user != null) {
      final userJson = user.toJson();
      final missingFields = profileRequiredFields.where((field) {
        final fieldValue = userJson.tryGet(field);
        if (fieldValue is String) {
          return fieldValue.isEmpty == true;
        }
        return fieldValue == null;
      });
      final hasApplicationFields =
          event.applicationProfileFields?.isNotEmpty ?? false;
      final hasApplicationQuestions =
          event.applicationQuestions?.isNotEmpty ?? false;
      final hasMissingFields = missingFields.isNotEmpty;
      final isMissingSubmission =
          event.applicationQuestions?.isNotEmpty == true &&
              event.applicationFormSubmission == null;

      if ((hasApplicationFields || hasApplicationQuestions) &&
          (hasMissingFields || isMissingSubmission)) {
        AutoRouter.of(context)
            .navigate(GuestEventApplicationRoute(event: event, user: user));
      } else {
        AutoRouter.of(context).navigate(EventBuyTicketsRoute(event: event));
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;
    final defaultTicketType =
        ListUtils.findWithConditionOrFirst<EventTicketType>(
      items: event.eventTicketTypes ?? [],
      condition: (ticketType) => ticketType.isDefault == true,
    );
    final defaultPrice = ListUtils.findWithConditionOrFirst<EventTicketPrice>(
      items: defaultTicketType?.prices ?? [],
      condition: (price) => price.isDefault == true,
    );
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );
    return FutureBuilder(
      future: isLoggedIn
          ? getIt<EventTicketRepository>().getEventCurrencies(
              input: GetEventCurrenciesInput(id: event.id ?? ''),
            )
          : Future.value(null),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final currencyInfo =
            snapshot.data?.getOrElse(() => []).firstWhereOrNull(
                  (info) => info.currency == defaultPrice?.currency,
                );
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
                    authenticated: (_) async {
                      final result = await _checkJoinRequest(context);
                      final eventJoinRequest = result?.getOrElse(() => null);
                      if (eventJoinRequest != null) {
                        AutoRouter.of(context).push(
                          GuestEventApprovalStatusRoute(
                            event: event,
                            eventJoinRequest: eventJoinRequest,
                          ),
                        );
                        return;
                      }

                      await _checkProfileRequiredFields(context);
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
                label: EventTicketUtils.getDisplayedTicketPrice(
                  decimals: currencyInfo?.decimals?.toInt(),
                  price: defaultPrice,
                ),
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
