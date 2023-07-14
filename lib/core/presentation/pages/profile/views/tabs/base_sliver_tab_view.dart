import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/presentation/widgets/common/sliver/sliver_pinned_overlap_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// @children should always be slivers
class BaseSliverTabView extends StatelessWidget {
  final String name;
  final List<Widget> children;
  final scrollNotificationBloc = ScrollNotificationBloc();

  BaseSliverTabView({
    super.key,
    required this.name,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is
        // "inside" the NestedScrollView, so that
        // sliverOverlapAbsorberHandleFor() can find the
        // NestedScrollView.
        builder: (BuildContext context) {
          return BlocProvider.value(
            value: scrollNotificationBloc,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
                    scrollNotificationBloc.add(ScrollNotificationEvent.reachEnd());
                    return true;
                  }
                } 
                scrollNotificationBloc.add(ScrollNotificationEvent.scroll());
                return true;
              },
              child: CustomScrollView(
                
                // The "controller" and "primary" members should be left
                // unset, so that the NestedScrollView can control this
                // inner scroll view.
                // If the "controller" property is set, then this scroll
                // view will not be associated with the NestedScrollView.
                // The PageStorageKey should be unique to this ScrollView;
                // it allows the list to remember its scroll position when
                // the tab view is not on the screen.
                key: PageStorageKey<String>(name.toString()),
                slivers: <Widget>[
                  SliverPinnedOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  ...children
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
