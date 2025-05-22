import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/my_event_tickets_list_page/widgets/event_reservations_list_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class EventReservationsListView extends StatelessWidget {
  final List<Event> eventsList;
  final Function()? onFetchMore;
  final bool hasNextPage;
  final Debouncer debouncer = Debouncer(milliseconds: 300);

  EventReservationsListView({
    super.key,
    required this.eventsList,
    this.onFetchMore,
    this.hasNextPage = true,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    if (eventsList.isEmpty) {
      return const Expanded(
        child: Center(
          child: EmptyList(
            emptyText: '',
          ),
        ),
      );
    }

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            debouncer.run(() => onFetchMore?.call());
          }
          return true;
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == eventsList.length) {
              return hasNextPage && eventsList.length >= 20
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      child: Loading.defaultLoading(context),
                    )
                  : const SizedBox();
            }
            return InkWell(
              key: ValueKey(eventsList[index].id ?? ''),
              onTap: () {
                AutoRouter.of(context).navigate(
                  MyEventTicketRoute(
                    event: eventsList[index],
                  ),
                );
              },
              child: EventReservationsListItemWidget(
                event: eventsList[index],
              ),
            );
          },
          itemCount: eventsList.length + 1,
          separatorBuilder: (context, index) => Divider(
            color: appColors.pageDivider,
            height: 1.w,
            thickness: 1.w,
          ),
        ),
      ),
    );
  }
}
