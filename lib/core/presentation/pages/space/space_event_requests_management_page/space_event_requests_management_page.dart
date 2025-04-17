import 'package:app/core/presentation/pages/space/space_event_requests_management_page/widgets/space_event_requests_management_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';

@RoutePage()
class SpaceEventRequestsManagementPage extends StatefulWidget {
  final String spaceId;
  const SpaceEventRequestsManagementPage({
    super.key,
    required this.spaceId,
  });

  @override
  State<SpaceEventRequestsManagementPage> createState() =>
      _SpaceEventRequestsManagementPageState();
}

class _SpaceEventRequestsManagementPageState
    extends State<SpaceEventRequestsManagementPage>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(title: t.space.submittedEvents),
      body: Column(
        children: [
          TabBar(
            controller: controller,
            labelStyle: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: Typo.medium.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.36),
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: LemonColor.paleViolet,
            tabs: [
              Tab(text: t.common.pending),
              Tab(text: t.common.approved),
              Tab(text: t.common.declined),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                SpaceEventRequestsManagementList(
                  spaceId: widget.spaceId,
                  state: Enum$EventJoinRequestState.pending,
                ),
                SpaceEventRequestsManagementList(
                  spaceId: widget.spaceId,
                  state: Enum$EventJoinRequestState.approved,
                ),
                SpaceEventRequestsManagementList(
                  spaceId: widget.spaceId,
                  state: Enum$EventJoinRequestState.declined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
