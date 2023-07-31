import 'package:matrix/matrix.dart';

extension RoomExtension on Room {
  bool get isMuted => pushRuleState != PushRuleState.notify;
}