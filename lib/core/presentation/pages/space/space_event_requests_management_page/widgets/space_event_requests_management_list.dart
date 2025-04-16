import 'package:app/core/application/space/get_space_event_requests_bloc/get_space_event_requests_bloc.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/space/space_event_requests_management_page/widgets/space_event_request_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/query/get_space_event_requests.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SpaceEventRequestsManagementList extends StatelessWidget {
  const SpaceEventRequestsManagementList({
    super.key,
    required this.spaceId,
    required this.state,
  });

  final String spaceId;
  final Enum$EventJoinRequestState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSpaceEventRequestsBloc(
        spaceRepository: getIt<SpaceRepository>(),
      )..add(
          GetSpaceEventRequestsEvent.fetch(
            input: Variables$Query$GetSpaceEventRequests(
              space: spaceId,
              state: state,
              limit: 100,
              skip: 0,
            ),
          ),
        ),
      child: _View(
        spaceId: spaceId,
        state: state,
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View({
    required this.spaceId,
    required this.state,
  });

  final String spaceId;
  final Enum$EventJoinRequestState state;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View>
    with AutomaticKeepAliveClientMixin<_View> {
  final RefreshController refreshController = RefreshController();
  late final Variables$Query$GetSpaceEventRequests input;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    input = Variables$Query$GetSpaceEventRequests(
      space: widget.spaceId,
      state: widget.state,
      limit: 100,
      skip: 0,
    );
  }

  Future<void> _refresh() async {
    context.read<GetSpaceEventRequestsBloc>().add(
          GetSpaceEventRequestsEvent.fetch(
            input: input,
            refresh: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GetSpaceEventRequestsBloc, GetSpaceEventRequestsState>(
      builder: (context, state) {
        final requests = state.maybeWhen(
          orElse: () => <SpaceEventRequest>[],
          success: (response) => response.records
              .where(
                (request) => request.eventExpanded != null,
              )
              .toList(),
        );
        final isLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

        return Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              refreshController.refreshCompleted();
              await _refresh();
            },
            child: CustomScrollView(
              slivers: [
                if (isLoading)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Loading.defaultLoading(context),
                    ),
                  )
                else if (requests.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: EmptyList(),
                    ),
                  )
                else
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return SpaceEventRequestItem(
                        request: request,
                        onApprove: (request) {
                          _refresh();
                        },
                        onDecline: (request) {
                          _refresh();
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: requests.length,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
