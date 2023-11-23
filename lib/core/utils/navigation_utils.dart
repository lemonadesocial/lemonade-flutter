import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationUtils {
  // ignore: always_declare_return_types
  static handleNotificationNavigate(
    BuildContext context,
    notification_entities.Notification? notification,
  ) async {
    String? type = notification?.type;
    if (kDebugMode) {
      print('handleNotificationNavigate');
    }

    switch (type) {
      case NotificationType.userContactSignUp:
      case NotificationType.userFriendshipRequest:
        {
          AutoRouter.of(context).navigate(
            ProfileRoute(
              userId: notification?.from ?? '',
            ),
          );
          return;
        }
      case NotificationType.eventCohostRequest:
        {
          AutoRouter.of(context).navigate(
            ProfileRoute(
              userId: notification?.from ?? '',
            ),
          );
          return;
        }
      case NotificationType.paymentSucceeded:
        {
          PaymentNotificationExtension.handlePaymentSuccessNotification(
            context,
            notification,
          );
        }
        return;
    }

    if (notification?.refEvent != null) {
      return AutoRouter.of(context).navigate(
        GuestEventDetailRoute(
          eventId: notification?.refEvent ?? '',
        ),
      );
    }

    if (notification?.refUser != null) {
      return AutoRouter.of(context).navigate(
        ProfileRoute(
          userId: notification?.refUser ?? '',
        ),
      );
    }
  }
}

extension PaymentNotificationExtension on NavigationUtils {
  static handlePaymentSuccessNotification(
    BuildContext context,
    notification,
  ) async {
    final eventId = notification?.refEvent;
    if (eventId == null) return;
    final loadingResult = await showFutureLoadingDialog<Either<Failure, Event>>(
      context: context,
      future: () => getIt<EventRepository>().getEventDetail(
        input: GetEventDetailInput(id: eventId),
      ),
    );

    if (loadingResult.result == null) return;

    return loadingResult.result?.fold(
      (l) => null,
      (event) {
        if (EventUtils.isAttending(
          event: event,
          userId: AuthUtils.getUserId(context),
        )) {
          AutoRouter.of(context).navigate(
            GuestEventDetailRoute(
              eventId: notification?.refEvent ?? '',
            ),
          );
        } else {
          AutoRouter.of(context).pushAll(
            [
              GuestEventDetailRoute(
                eventId: notification?.refEvent ?? '',
              ),
              EventBuyTicketsRoute(
                event: event,
                children: const [
                  EventPickMyTicketRoute(),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
