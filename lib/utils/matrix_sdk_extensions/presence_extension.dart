import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

import '../date_time_extension.dart';

extension PresenceExtension on CachedPresence {
  String getLocalizedLastActiveAgo(BuildContext context) {
    final t = Translations.of(context);
    final lastActiveTimestamp = this.lastActiveTimestamp;
    if (lastActiveTimestamp != null) {
      return t.matrix
          .lastActiveAgo(localizedTimeShort: lastActiveTimestamp.localizedTimeShort(context));
    }
    return t.matrix.lastSeenLongTimeAgo;
  }

  String getLocalizedStatusMessage(BuildContext context) {
    final statusMsg = this.statusMsg;
    if (statusMsg != null && statusMsg.isNotEmpty) {
      return statusMsg;
    }
    if (currentlyActive ?? false) {
      return t.matrix.currentlyActive;
    }
    return getLocalizedLastActiveAgo(context);
  }

  Color get color {
    switch (presence) {
      case PresenceType.online:
        return Colors.green;
      case PresenceType.offline:
        return Colors.grey;
      case PresenceType.unavailable:
      default:
        return Colors.red;
    }
  }
}
