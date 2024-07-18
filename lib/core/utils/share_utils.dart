import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static shareEvent(Event event) {
    Share.shareUri(
      Uri.parse('${AppConfig.webUrl}/event/${event.id}'),
    );
  }
}
