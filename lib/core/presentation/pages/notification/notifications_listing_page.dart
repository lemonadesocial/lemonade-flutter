import 'package:app/core/application/notification/notifications_listing_bloc.dart';
import 'package:app/core/data/notification/repository/notification_repository_impl.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_card_widget.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/notification/notification_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:app/core/domain/notification/entities/notification.dart' as entities;

@RoutePage()
class NotificationPage extends StatelessWidget {
  late final NotificationService notificationService = NotificationService(NotificationRepositoryImpl());

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
  GlobalKey<AnimatedListState> _notificationList = GlobalKey<AnimatedListState>();
  final _appRouter = AppRouter();

  removeItem(
    int index, {
    required entities.Notification notification,
    bool isDismiss = false,
  }) {
    context.read<NotificationsListingBloc>().add(
          NotificationsListingEvent.removeItem(
            index: index,
            notification: notification,
          ),
        );
    _notificationList.currentState?.removeItem(
      index,
      (context, animation) {
        return isDismiss
            ? Container()
            : SizeTransition(
                sizeFactor: animation,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) => AnimatedOpacity(
                    opacity: animation.value,
                    duration: Duration(milliseconds: 300),
                    child: child,
                  ),
                  child: NotificationCard(notification: notification),
                ),
              );
      },
    );
  }

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
            builder: (filter) => Assets.icons.icChat.svg(colorFilter: filter),
          ),
        ],
      ),
      backgroundColor: themeColor.primary,
      body: BlocBuilder<NotificationsListingBloc, NotificationsListingState>(
        builder: (context, state) {
          return state.when(
            loading: () => Loading.defaultLoading(context),
            fetched: (notifications) {
              if (notifications.isEmpty) {
                return Center(
                  child: EmptyList(emptyText: t.notification.emptyNotifications),
                );
              }
              return AnimatedList(
                key: _notificationList,
                itemBuilder: (ctx, index, animation) => index == notifications.length
                    ? const SizedBox(height: 80)
                    : _NotificationSlidable(
                        id: notifications[index].id ?? '',
                        onRemove: () {
                          removeItem(
                            index,
                            notification: notifications[index],
                          );
                        },
                        onDismissed: () {
                          removeItem(
                            index,
                            notification: notifications[index],
                            isDismiss: true,
                          );
                        },
                        child: NotificationCard(
                          key: Key(notifications[index].id ?? ''),
                          notification: notifications[index],
                          onTap: () {
                            NavigationUtils.handleNotificationNavigate(
                              _appRouter,
                              context,
                              notifications[index].type,
                              notifications[index].object_type,
                              notifications[index].object_id,
                            );
                          },
                        ),
                      ),
                initialItemCount: notifications.length,
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

class _NotificationSlidable extends StatelessWidget {
  final Widget child;
  final String id;
  final void Function()? onRemove;
  final void Function()? onDismissed;
  const _NotificationSlidable({
    required this.id,
    required this.child,
    this.onRemove,
    // ignore: unused_element
    this.onDismissed,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Slidable(
      key: ValueKey(id),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          closeOnCancel: true,
          confirmDismiss: () async {
            return true;
          },
          onDismissed: () {
            onDismissed?.call();
          },
        ),
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onRemove?.call();
            },
            backgroundColor: LemonColor.red,
            foregroundColor: colorScheme.onPrimary,
            icon: Icons.delete,
            label: t.common.delete,
          ),
        ],
      ),
      child: child,
    );
  }
}
