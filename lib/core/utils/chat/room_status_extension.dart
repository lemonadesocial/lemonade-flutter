import 'package:app/core/config.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/widgets.dart';

import 'package:matrix/matrix.dart';

// import '../config/app_config.dart';
import 'date_time_extension.dart';

extension RoomStatusExtension on Room {
  CachedPresence? get directChatPresence =>
      client.presences[directChatMatrixID];

  String getLocalizedStatus(BuildContext context) {
    final t = Translations.of(context);
    if (isDirectChat) {
      final directChatPresence = this.directChatPresence;
      if (directChatPresence != null &&
          (directChatPresence.lastActiveTimestamp != null ||
              directChatPresence.currentlyActive != null)) {
        if (directChatPresence.statusMsg?.isNotEmpty ?? false) {
          return directChatPresence.statusMsg!;
        }
        if (directChatPresence.currentlyActive ?? false) {
          return t.chat.currentlyActive;
        }
        if (directChatPresence.lastActiveTimestamp == null) {
          return t.chat.lastSeenLongTimeAgo;
        }
        final time = directChatPresence.lastActiveTimestamp!;
        return t.chat.lastActiveAgo(
            localizedTimeShort: time.localizedTimeShort(context));
      }
      return t.chat.lastSeenLongTimeAgo;
    }
    return t.chat
        .countParticipants(count: summary.mJoinedMemberCount.toString());
  }

  String getLocalizedTypingText(BuildContext context) {
    var typingText = '';
    final typingUsers = this.typingUsers;
    typingUsers.removeWhere((u) => u.id == client.userID);

    if (AppConfig.hideTypingUsernames) {
      typingText = t.chat.isTyping;
      if (typingUsers.first.id != directChatMatrixID) {
        typingText =
            t.chat.numUsersTyping(count: typingUsers.length.toString());
      }
    } else if (typingUsers.length == 1) {
      typingText = t.chat.isTyping;
      if (typingUsers.first.id != directChatMatrixID) {
        typingText =
            t.chat.userIsTyping(username: typingUsers.first.calcDisplayname());
      }
    } else if (typingUsers.length == 2) {
      typingText = t.chat.userAndUserAreTyping(
        username: typingUsers.first.calcDisplayname(),
        username2: typingUsers[1].calcDisplayname(),
      );
    } else if (typingUsers.length > 2) {
      typingText = t.chat.userAndOthersAreTyping(
        username: typingUsers.first.calcDisplayname(),
        count: (typingUsers.length - 1).toString(),
      );
    }
    return typingText;
  }

  List<User> getSeenByUsers(Timeline timeline, {String? eventId}) {
    if (timeline.events.isEmpty) return [];
    eventId ??= timeline.events.first.eventId;

    final lastReceipts = <User>{};
    // now we iterate the timeline events until we hit the first rendered event
    for (final event in timeline.events) {
      lastReceipts.addAll(event.receipts.map((r) => r.user));
      if (event.eventId == eventId) {
        break;
      }
    }
    lastReceipts.removeWhere(
      (user) =>
          user.id == client.userID || user.id == timeline.events.first.senderId,
    );
    return lastReceipts.toList();
  }
}
