import 'package:app/core/presentation/widgets/sliver_pinned_overlap_injector.dart';
import 'package:flutter/material.dart';

/// @children should always be slivers
class BaseSliverTabView extends StatelessWidget {
  final String name;
  final List<Widget> children;

  const BaseSliverTabView({
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
          return CustomScrollView(
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
          );
        },
      ),
    );
  }
}
