import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/buy_event_ticket_bloc/buy_event_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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

  Future<bool> _checkProfileRequiredFields(BuildContext context) async {
    List<String> profileRequiredFields = (event.requiredProfileFields ?? [])
        .map(StringUtils.snakeToCamel)
        .toList();
    if (profileRequiredFields.isEmpty) {
      return true;
    }
    final userResult = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<UserRepository>().getMe(),
    );
    return userResult.result!.fold((l) => true, (user) {
      final userJson = user.toJson();
      final missingFields = profileRequiredFields.where((field) {
        final fieldValue = userJson.tryGet(field);
        if (fieldValue is String) {
          return fieldValue.isEmpty == true;
        }
        return fieldValue == null;
      });
      if (missingFields.isEmpty) {
        return true;
      }
      final formattedMissingFields =
          missingFields.map(StringUtils.camelCaseToWords).toList();
      showDialog(
        context: context,
        builder: (context) {
          return LemonAlertDialog(
            onClose: () {
              AutoRouter.of(context).pop();
              AutoRouter.of(context).push(
                EditProfileRoute(
                  userProfile: user,
                ),
              );
            },
            buttonLabel: t.common.actions.ok,
            child: Text(
              t.event.profileRequiredFields(
                fields: formattedMissingFields.join(', '),
              ),
            ),
          );
        },
      );
      return false;
    });
  }

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
                authenticated: (_) async {
                  final result = await _checkJoinRequest(context);
                  final eventJoinRequest = result?.getOrElse(() => null);
                  final isPendingJoinRequest = eventJoinRequest != null &&
                      eventJoinRequest.approvedBy == null &&
                      eventJoinRequest.declinedBy == null;
                  final isDeclinedJoinRequest = eventJoinRequest != null &&
                      eventJoinRequest.declinedBy != null;
                  if (isPendingJoinRequest) {
                    showDialog(
                      context: context,
                      builder: (context) => LemonAlertDialog(
                        child: Text(t.event.eventApproval.waitingApproval),
                      ),
                    );
                    return;
                  }
                  if (isDeclinedJoinRequest) {
                    showDialog(
                      context: context,
                      builder: (context) => LemonAlertDialog(
                        child: Text(t.event.eventApproval.yourRequestDeclined),
                      ),
                    );
                    return;
                  }
                  final isQualified =
                      await _checkProfileRequiredFields(context);
                  if (!isQualified) {
                    return;
                  }
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
