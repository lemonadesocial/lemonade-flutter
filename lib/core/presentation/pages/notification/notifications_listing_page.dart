import 'package:app/core/application/notification/notifications_listing_bloc.dart';
import 'package:app/core/data/notification/repository/notification_repository_impl.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_card_widget.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/notification/notification_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/navigation_utils.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  late final NotificationService notificationService =
      NotificationService(NotificationRepositoryImpl());

  Widget _notificationsListingBlocProvider(Widget child) {
    return BlocProvider<NotificationsListingBloc>(
      create: (context) => NotificationsListingBloc(notificationService)
        ..add(NotificationsListingEvent.fetch()),
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
  State<_NotificationsListingView> createState() =>
      _NotificationsListingViewState();
}

class _NotificationsListingViewState extends State<_NotificationsListingView> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.notification.notifications,
        leading: BurgerMenu(),
        actions: [
          ThemeSvgIcon(
              color: themeColor.onSurface,
              builder: (filter) =>
                  Assets.icons.icChat.svg(colorFilter: filter)),
        ],
      ),
      backgroundColor: themeColor.primary,
      body: BlocBuilder<NotificationsListingBloc, NotificationsListingState>(
        builder: (context, state) {
          return state.when(
            loading: () => Loading.defaultLoading(context),
            fetched: (notifications) {
              return ListView.separated(
                itemBuilder: (ctx, index) => NotificationCard(
                  key: Key(notifications[index].id ?? ''),
                  notification: notifications[index],
                  onTap: () {
                    NavigationUtils.handleNotificationNavigate(
                        context, notifications[index]);
                  },
                ),
                separatorBuilder: (ctx, index) =>
                    SizedBox(height: Spacing.extraSmall),
                itemCount: notifications.length + 1,
              );
            },
            failure: () => Center(
              child: Text(t.common.somethingWrong),
            ),
          );
        },
      ),
    );
  }
}
