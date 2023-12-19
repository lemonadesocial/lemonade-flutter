import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/notification/notifications_listing_bloc.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as entities;
import 'package:app/core/presentation/pages/notification/widgets/notification_card_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsListingBloc>(
      create: (context) =>
          NotificationsListingBloc()..add(NotificationsListingEvent.fetch()),
      child: const _NotificationsListingView(),
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
  final GlobalKey<AnimatedListState> _notificationList =
      GlobalKey<AnimatedListState>();

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
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  ),
                  child: NotificationCard(
                    index: index,
                    notification: notification,
                  ),
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
        leading: InkWell(
          onTap: () => DrawerUtils.openDrawer(context),
          child: Icon(
            Icons.menu_outlined,
            color: themeColor.onPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {
                context.read<AuthBloc>().state.maybeWhen(
                      authenticated: (session) => AutoRouter.of(context)
                          .navigate(const ChatListRoute()),
                      orElse: () =>
                          AutoRouter.of(context).navigate(const LoginRoute()),
                    );
              },
              child: ThemeSvgIcon(
                color: themeColor.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
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
                  child:
                      EmptyList(emptyText: t.notification.emptyNotifications),
                );
              }
              return AnimatedList(
                // Add more space at bottom of screen
                padding: EdgeInsets.only(bottom: 150.h),
                key: _notificationList,
                itemBuilder: (ctx, index, animation) =>
                    index == notifications.length
                        ? const SizedBox(height: 80)
                        : NotificationCard(
                            key: Key(notifications[index].id ?? ''),
                            index: index,
                            notification: notifications[index],
                            onTap: () {
                              NavigationUtils.handleNotificationNavigate(
                                context,
                                notifications[index],
                              );
                            },
                            onRemove: (index, notification, isDismiss) {
                              removeItem(
                                index,
                                notification: notification,
                                isDismiss: isDismiss ?? false,
                              );
                            },
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
