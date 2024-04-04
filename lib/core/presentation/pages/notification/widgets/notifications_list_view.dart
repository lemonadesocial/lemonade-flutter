import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:app/core/domain/notification/input/delete_notifications_input.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_card_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:app/graphql/backend/notification/query/get_notifications.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationListView extends StatefulWidget {
  final Input$NotificationTypeFilterInput? filter;
  const NotificationListView({
    super.key,
    this.filter,
  });

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  final GlobalKey<AnimatedListState> _notificationList =
      GlobalKey<AnimatedListState>();

  void removeItem(
    context, {
    required int index,
    required notification_entities.Notification notification,
    bool isDismiss = false,
    Function? refetch,
  }) async {
    final result = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<NotificationRepository>().deleteNotifications(
        input: DeleteNotificationsInput(
          ids: [],
        ),
      ),
    );
    result.result?.fold((l) => null, (success) {
      if (!success) return;
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
      refetch?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Builder(
      builder: (context) {
        return Query$GetNotifications$Widget(
          options: Options$Query$GetNotifications(
            fetchPolicy: FetchPolicy.networkOnly,
            variables: Variables$Query$GetNotifications(
              limit: 100,
              skip: 0,
              type: widget.filter,
            ),
          ),
          builder: (
            result, {
            refetch,
            fetchMore,
          }) {
            if (result.isLoading || result.source == QueryResultSource.cache) {
              return Center(
                child: Loading.defaultLoading(context),
              );
            }

            if (result.hasException ||
                result.parsedData?.getNotifications == null) {
              return Center(
                child: EmptyList(emptyText: t.common.somethingWrong),
              );
            }

            final notifications = (result.parsedData?.getNotifications ?? [])
                .map(
                  (item) => notification_entities.Notification.fromDto(
                    NotificationDto.fromJson(
                      item.toJson(),
                    ),
                  ),
                )
                .toList();

            if (notifications.isEmpty) {
              return Center(
                child: EmptyList(
                  emptyText: t.notification.emptyNotifications,
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    // TODO:
                    // fetchMore?.call(
                    //   FetchMoreOptions$Query$GetNotifications(
                    //     variables: Variables$Query$GetNotifications(
                    //       limit: 10,
                    //       skip: notifications.length,
                    //     ),
                    //     updateQuery: (prevResult, fetchMoreResult) {
                    //       final List<dynamic> finalList = [
                    //         ...(prevResult?['getNotifications'] ?? []) as List<dynamic>,
                    //         ...(fetchMoreResult?['getNotifications'] ?? []) as List<dynamic>,
                    //       ];
                    //       fetchMoreResult?['getNotifications'] = finalList;

                    //       return fetchMoreResult;
                    //     },
                    //   ),
                    // );
                  }
                }
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 150.h),
                    sliver: SliverAnimatedList(
                      // Add more space at bottom of screen
                      key: _notificationList,
                      itemBuilder: (ctx, index, animation) => NotificationCard(
                        key: ValueKey(notifications[index].id ?? ''),
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
                            context,
                            index: index,
                            notification: notification,
                            isDismiss: isDismiss ?? false,
                            refetch: refetch,
                          );
                        },
                      ),
                      initialItemCount: notifications.length,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
