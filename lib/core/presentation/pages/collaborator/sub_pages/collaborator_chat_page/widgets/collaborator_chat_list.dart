import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/collaborator_chat_item.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/matrix_utils.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MatchedSwipeRoom {
  final UserDiscoverySwipe swipe;
  final Room room;

  MatchedSwipeRoom({
    required this.room,
    required this.swipe,
  });
}

class CollaboratorChatList extends StatelessWidget {
  final List<UserDiscoverySwipe> matchedSwipes;
  const CollaboratorChatList({
    super.key,
    required this.matchedSwipes,
  });

  Future<Room?> getSingleRoomInfo(UserDiscoverySwipe swipe) async {
    final matrixClient = getIt<MatrixService>().client;
    final roomId = await matrixClient.startDirectChat(
      LemonadeMatrixUtils.generateMatrixUserId(
        lemonadeMatrixLocalpart: swipe.otherExpanded?.matrixLocalpart ?? '',
      ),
    );
    return matrixClient.getRoomById(roomId);
  }

  Future<List<MatchedSwipeRoom>> getChatRooms(
    List<UserDiscoverySwipe> matchedSwipes,
  ) async {
    List<MatchedSwipeRoom> rooms = [];
    for (var swipeItem in matchedSwipes) {
      final swipeRoom = await getSingleRoomInfo(swipeItem);
      if (swipeRoom != null) {
        rooms.add(
          MatchedSwipeRoom(room: swipeRoom, swipe: swipeItem),
        );
      }
    }
    return rooms
      ..sort(
        (a, b) => b.room.timeCreated.compareTo(
          a.room.timeCreated,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  t.collaborator.matches,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
                CollaboratorCounter(
                  count: matchedSwipes.length,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.xSmall)),
        StreamBuilder(
          stream: getIt<MatrixService>()
              .client
              .onSync
              .stream
              .where((event) => event.hasRoomUpdate)
              .rateLimit(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: getChatRooms(matchedSwipes),
              builder: (context, snapshot) {
                final chatRooms = snapshot.data ?? [];
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                  sliver: SliverList.separated(
                    itemCount: chatRooms.length,
                    itemBuilder: (context, index) => _ChatItem(
                      swipeRoom: chatRooms[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: Spacing.small,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _ChatItem extends StatelessWidget {
  final MatchedSwipeRoom swipeRoom;
  const _ChatItem({
    required this.swipeRoom,
  });

  @override
  Widget build(BuildContext context) {
    return CollaboratorChatItem(
      room: swipeRoom.room,
    );
  }
}
