import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:hive/hive.dart';

extension MatrixChatSpaceExtension on MatrixService {
  static String chatSpaceBoxKey = 'lemonade_chat_space';
  static String activeChatSpaceKey = 'lemonade_chat_space_id';

  Future<String?> getActiveChatSpaceId() async {
    Box box = await Hive.openBox(chatSpaceBoxKey);
    var spaceId = box.get(activeChatSpaceKey) as String?;
    return spaceId;
  }

  Future<void> setActiveChatSpaceId(String? spaceId) async {
    Box box = await Hive.openBox(chatSpaceBoxKey);
    box.put(activeChatSpaceKey, spaceId);
  }

  Future<void> clearChatSpaceBox() async {
    Box box = await Hive.openBox(chatSpaceBoxKey);
    await box.clear();
  }
}