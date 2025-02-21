import 'package:app/core/application/common/refresh_bloc/refresh_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/helper/event_publish_helper.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_cohosts_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_collectibles_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_cover_photo_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_faq_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_programs_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_rewards_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_speakers_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_tickets_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/event_publish_checklist_rating_badge.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/event_publish_checklist_rating_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';

enum EventPublishCheckList {
  tickets,
  coverPhoto,
  collectibles,
  rewards,
  programs,
  cohosts,
  speakers,
  faq,
}

enum EventPublishRating {
  average,
  good,
  great,
  awesome,
}

class EventPublishChecklistItemData {
  final bool fulfilled;
  final Widget widget;

  const EventPublishChecklistItemData({
    required this.fulfilled,
    required this.widget,
  });
}

@RoutePage()
class HostEventPublishFlowPage extends StatelessWidget {
  const HostEventPublishFlowPage({
    super.key,
  });

  Future<void> publishEvent(
    BuildContext context, {
    required Event event,
  }) async {
    final t = Translations.of(context);
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<EventRepository>().updateEvent(
        input: Input$EventInput(
          published: true,
        ),
        id: event.id ?? '',
      ),
    );
    response.result?.fold((l) => null, (updatedEvent) {
      context.read<GetEventDetailBloc>().add(
            GetEventDetailEvent.fetch(eventId: event.id ?? ''),
          );

      context.read<RefreshBloc>().add(const RefreshEvent.refreshEvents());
      SnackBarUtils.showSuccess(
        message: t.event.eventPublish.eventPublishSuccess,
      );
      AutoRouter.of(context).pop();
    });
  }

  int getPublishRatingScore(List<EventPublishChecklistItemData> checklist) {
    return checklist.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.fulfilled == true ? 1 : 0),
    );
  }

  EventPublishRating getPublishRating(int ratingScore) {
    if (ratingScore <= 2) {
      return EventPublishRating.average;
    }

    if (ratingScore <= 4) {
      return EventPublishRating.good;
    }

    if (ratingScore <= 6) {
      return EventPublishRating.great;
    }

    return EventPublishRating.awesome;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );

    if (event == null) {
      return Scaffold(
        appBar: const LemonAppBar(),
        body: Center(
          child: Loading.defaultLoading(context),
        ),
      );
    }

    final checklist = EventPublishCheckList.values.map((item) {
      if (item == EventPublishCheckList.tickets) {
        final fulfilled = EventPublishHelper.isTicketsFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishTicketsChecklistItem(
            event: event,
            fulfilled: fulfilled,
          ),
        );
      }

      if (item == EventPublishCheckList.coverPhoto) {
        final fulfilled = EventPublishHelper.isCoverPhotoFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishCoverPhotoChecklistItem(
            event: event,
            fulfilled: fulfilled,
          ),
        );
      }

      if (item == EventPublishCheckList.collectibles) {
        final fulfilled = EventPublishHelper.isCollectiblesFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishCollectiblesChecklistItem(
            fulfilled: fulfilled,
            event: event,
          ),
        );
      }

      if (item == EventPublishCheckList.rewards) {
        final fulfilled = EventPublishHelper.isRewardsFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishRewardsChecklistItem(
            fulfilled: fulfilled,
            event: event,
          ),
        );
      }

      if (item == EventPublishCheckList.programs) {
        final fulfilled = EventPublishHelper.isProgramsFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishProgramsChecklistItem(
            fulfilled: fulfilled,
            event: event,
          ),
        );
      }

      if (item == EventPublishCheckList.cohosts) {
        final fulfilled = EventPublishHelper.isCohostsFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishCohostsChecklistItem(
            fulfilled: fulfilled,
            event: event,
          ),
        );
      }

      if (item == EventPublishCheckList.speakers) {
        final fulfilled = EventPublishHelper.isSpeakersFulfilled(event);
        return EventPublishChecklistItemData(
          fulfilled: fulfilled,
          widget: EventPublishSpeakersChecklistItem(
            fulfilled: fulfilled,
            event: event,
          ),
        );
      }

      final fulfilled = EventPublishHelper.isFAQsFulfilled(event);
      return EventPublishChecklistItemData(
        fulfilled: fulfilled,
        widget: EventPublishFAQChecklistItem(
          fulfilled: fulfilled,
          event: event,
        ),
      );
    }).toList()
      ..sort((a, b) {
        final aOrder = a.fulfilled == true ? 1 : -1;
        final bOrder = b.fulfilled == true ? 1 : -1;
        return aOrder.compareTo(bOrder);
      });

    final ratingScore = getPublishRatingScore(checklist);
    final rating = getPublishRating(ratingScore);

    return Scaffold(
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: EventPublishChecklistRatingBadge(
              rating: rating,
              score: ratingScore,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.event.eventPublish.eventPublishTitle,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.event.eventPublish.eventPublishDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.smMedium * 2,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: EventPublishChecklistRatingBar(
                      rating: rating,
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: checklist.length,
                  itemBuilder: (context, index) {
                    return checklist[index].widget;
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3.5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              child: SafeArea(
                child: ratingScore >= 5
                    ? LinearGradientButton.primaryButton(
                        onTap: () => publishEvent(context, event: event),
                        label: t.common.actions.publish,
                      )
                    : LinearGradientButton.secondaryButton(
                        onTap: () => publishEvent(context, event: event),
                        label: t.common.actions.publish,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
