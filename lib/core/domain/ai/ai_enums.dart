import 'package:json_annotation/json_annotation.dart';

enum AIMetadataAction {
  @JsonValue("create_post")
  createPost,
  @JsonValue("create_room")
  createRoom,
  @JsonValue("create_event")
  createEvent,
  @JsonValue("create_poap")
  createPoap,
  @JsonValue("create_collectible")
  createCollectible,
}
