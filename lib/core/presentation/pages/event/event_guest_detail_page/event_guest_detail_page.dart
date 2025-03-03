import 'package:app/core/data/event/dtos/event_guest_detail_dto/event_guest_detail_dto.dart';
import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_application_questions.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_payment_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_timeline_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_user_info_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_guest_detail.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventGuestDetailPage extends StatefulWidget {
  final String eventId;
  final String userId;
  final String email;

  const EventGuestDetailPage({
    super.key,
    required this.eventId,
    required this.userId,
    required this.email,
  });

  @override
  State<EventGuestDetailPage> createState() => _EventGuestDetailPageState();
}

class _EventGuestDetailPageState extends State<EventGuestDetailPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventGuestDetail.eventGuestDetail,
      ),
      body: Query$GetEventGuestDetail$Widget(
        options: Options$Query$GetEventGuestDetail(
          variables: Variables$Query$GetEventGuestDetail(
            event: widget.eventId,
            user: widget.userId.isNotEmpty ? widget.userId : null,
            email: widget.email,
          ),
        ),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          if (result.isLoading) {
            return Center(
              child: Loading.defaultLoading(context),
            );
          }
          final eventGuestDetail = EventGuestDetail.fromDto(
            EventGuestDetailDto.fromJson(
              result.parsedData!.getEventGuestDetail!.toJson(),
            ),
          );
          print(
              'eventGuestDetail joinRequest: ${eventGuestDetail.joinRequest?.toJson().toString()}');
          final widgets = [
            EventGuestDetailUserInfoWidget(
              eventGuestDetail: eventGuestDetail,
            ),
            if (eventGuestDetail.payment != null)
              EventGuestDetailPaymentInfoWidget(
                eventGuestDetail: eventGuestDetail,
              ),
            if (eventGuestDetail.application != null &&
                eventGuestDetail.application!.isNotEmpty)
              EventGuestDetailApplicationQuestionsWidget(
                eventGuestDetail: eventGuestDetail,
              ),
            if (eventGuestDetail.joinRequest != null)
              EventGuestDetailTimelineInfoWidget(
                eventGuestDetail: eventGuestDetail,
              ),
          ];
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  left: Spacing.small,
                  right: Spacing.small,
                  top: Spacing.small,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                  separatorBuilder: (context, index) {
                    if (index == 1 && eventGuestDetail.payment == null) {
                      return const SizedBox.shrink();
                    }
                    if (index == 2 && eventGuestDetail.application == null) {
                      return const SizedBox.shrink();
                    }
                    return Divider(
                      color: colorScheme.outline,
                      height: Spacing.medium * 2,
                    );
                  },
                  itemCount: widgets.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
