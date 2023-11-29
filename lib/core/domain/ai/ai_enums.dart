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

extension AIMetadataActionExtension on AIMetadataAction {
  String get value {
    switch (this) {
      case AIMetadataAction.createPost:
        return 'create_post';
      case AIMetadataAction.createRoom:
        return 'create_room';
      case AIMetadataAction.createEvent:
        return 'create_event';
      case AIMetadataAction.createPoap:
        return 'create_poap';
      case AIMetadataAction.createCollectible:
        return 'create_collectible';
    }
  }
}
