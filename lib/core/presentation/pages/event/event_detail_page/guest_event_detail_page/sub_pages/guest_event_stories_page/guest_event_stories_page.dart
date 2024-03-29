import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/event/dtos/event_story_dto/event_story_dto.dart';
import 'package:app/core/domain/event/entities/event_story.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/sub_pages/guest_event_stories_page/widgets/event_story_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_stories.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GuestEventStoriesPage extends StatelessWidget {
  const GuestEventStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final colorScheme = Theme.of(context).colorScheme;
    final matrixClient = getIt<MatrixService>().client;
    final chatRoom = matrixClient.getRoomById(event?.matrixEventRoomId ?? '');

    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizing.xLarge),
          color: LemonColor.lavender,
        ),
        width: Sizing.xLarge,
        height: Sizing.xLarge,
        child: Center(
          child: Assets.icons.icAdd.svg(
            height: Sizing.small,
            width: Sizing.small,
          ),
        ),
      ),
      appBar: LemonAppBar(
        title: t.event.eventLounge.eventLoungeTitle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          ChatRoute(roomId: event?.matrixEventRoomId ?? ''),
                        );
                      },
                      child: Container(
                        height: Sizing.xLarge,
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.small),
                        ),
                        padding: EdgeInsets.all(Spacing.xSmall),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: Spacing.extraSmall),
                            Assets.icons.icChatBubbleGradient.svg(),
                            SizedBox(width: Spacing.xSmall),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    t.event.dashboard.liveChat,
                                    style: Typo.medium.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    chatRoom?.isUnread == true
                                        ? t.event.eventLounge.newMessages
                                        : t.event.eventLounge
                                            .liveChatDescription,
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (event?.guestDirectoryEnabled == true) ...[
                    SizedBox(width: Spacing.xSmall),
                    InkWell(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const GuestEventGuestDirectoryRoute());
                      },
                      child: Container(
                        width: Sizing.xLarge,
                        height: Sizing.xLarge,
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.small),
                        ),
                        child: Center(
                          child: ThemeSvgIcon(
                            color: LemonColor.paleViolet,
                            builder: (colorFilter) =>
                                Assets.icons.icPeopleAlt.svg(
                              colorFilter: colorFilter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: Spacing.medium,
              ),
            ),
            Query$GetEventStories$Widget(
              options: Options$Query$GetEventStories(
                variables: Variables$Query$GetEventStories(
                  id: event?.id ?? '',
                  limit: 50,
                  object: "Event",
                ),
              ),
              builder: (
                result, {
                refetch,
                fetchMore,
              }) {
                if (result.isLoading) {
                  return SliverToBoxAdapter(
                    child: Loading.defaultLoading(context),
                  );
                }

                if (result.hasException || result.parsedData?.stories == null) {
                  return SliverToBoxAdapter(
                    child: EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
                  );
                }

                final eventStories = result.parsedData!.stories
                    .map(
                      (item) => EventStory.fromDto(
                        EventStoryDto.fromJson(
                          item.toJson(),
                        ),
                      ),
                    )
                    .toList();

                if (eventStories.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: EmptyList(),
                  );
                }

                return SliverList.separated(
                  itemCount: eventStories.length,
                  itemBuilder: (context, index) {
                    final eventStory = eventStories[index];
                    return EventStoryItem(
                      eventStory: eventStory,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1.w,
                    color: colorScheme.outline,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
