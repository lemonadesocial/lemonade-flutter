import 'package:app/core/data/event/dtos/event_checkin_dto/event_checkin_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/checkin_guest_list_page/widgets/checkin_event_checkin_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_checkins.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CheckinEventCheckinsList extends StatelessWidget {
  final RefreshController refreshController = RefreshController();
  final Event? event;
  CheckinEventCheckinsList({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$GetEventCheckins$Widget(
      options: Options$Query$GetEventCheckins(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetEventCheckins(
          input: Input$GetEventCheckinsInput(
            event: event?.id ?? '',
          ),
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final eventCheckinsList =
            (result.parsedData?.getEventCheckins ?? []).map((item) {
          return EventCheckin.fromDto(
            EventCheckinDto.fromJson(item.toJson()),
          );
        }).toList();

        return NotificationListener(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                refetch?.call();
                refreshController.refreshCompleted();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.smMedium),
                  ),
                  if (result.isLoading && eventCheckinsList.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Loading.defaultLoading(
                          context,
                        ),
                      ),
                    ),
                  if (result.hasException)
                    SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          emptyText: t.common.somethingWrong,
                        ),
                      ),
                    ),
                  if (!result.isLoading && eventCheckinsList.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          emptyText: t.event.eventApproval.noGuestFound,
                        ),
                      ),
                    ),
                  SliverList.separated(
                    itemCount: eventCheckinsList.length,
                    itemBuilder: (context, index) {
                      final eventCheckin = eventCheckinsList[index];
                      return CheckinEventCheckinItem(
                        event: event,
                        eventCheckin: eventCheckin,
                        onTap: () async {
                          if (eventCheckin.user != null) {
                            AutoRouter.of(context).push(
                              ProfileRoute(userId: eventCheckin.user!),
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Spacing.superExtraSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
