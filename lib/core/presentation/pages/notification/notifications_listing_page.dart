import 'package:app/core/application/notification/notifications_listing_bloc.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/service/notification/notification_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  late final NotificationService notificationService = NotificationService(getIt<NotificationRepository>());

  Widget _notificationsListingBlocProvider(Widget child) {
    return BlocProvider<NotificationsListingBloc>(
      create: (context) => NotificationsListingBloc(notificationService)..add(NotificationsListingEvent.fetch()),
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    return _notificationsListingBlocProvider(
      _NotificationsListingView(),
    );
  }
}

class _NotificationsListingView extends StatefulWidget {
  const _NotificationsListingView();

  @override
  State<_NotificationsListingView> createState() => _NotificationsListingViewState();
}

class _NotificationsListingViewState extends State<_NotificationsListingView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: const Center(
        child: Text('Notification'),
      ),
    );
  }
}