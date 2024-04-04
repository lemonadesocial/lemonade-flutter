import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/notification/notifications_listing_bloc.dart';
import 'package:app/core/presentation/pages/notification/widgets/notifications_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/notification_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsListingBloc>(
      create: (context) => NotificationsListingBloc(),
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

class _NotificationsListingViewState extends State<_NotificationsListingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final authBloc = context.watch<AuthBloc>();
    final isLoggedIn = authBloc.state
        .maybeWhen(orElse: () => false, authenticated: (_) => true);

    if (!isLoggedIn) {
      return const Scaffold(
        body: Center(
          child: EmptyList(),
        ),
      );
    }

    return Scaffold(
      appBar: LemonAppBar(
        title: t.notification.notifications,
        leading: InkWell(
          onTap: () => DrawerUtils.openDrawer(context),
          child: Icon(
            Icons.menu_outlined,
            color: colorScheme.onPrimary,
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
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.primary,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: Spacing.medium),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            labelStyle: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: Typo.medium.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: LemonColor.paleViolet,
            tabs: [
              Tab(text: t.notification.tabs.all),
              Tab(text: t.notification.tabs.events),
              Tab(text: t.notification.tabs.activity),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const NotificationListView(),
                NotificationListView(
                  filter: Input$NotificationTypeFilterInput(
                    $in: NotificationUtils.eventRelatedNotificationTypes,
                  ),
                ),
                NotificationListView(
                  filter: Input$NotificationTypeFilterInput(
                    nin: NotificationUtils.eventRelatedNotificationTypes,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
