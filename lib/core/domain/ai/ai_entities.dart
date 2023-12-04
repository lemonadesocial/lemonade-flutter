import 'package:app/core/data/ai/dtos/ai_dtos.dart';

class AIChatMessage {
  final String? text;
  final Map<String, dynamic>? metadata;
  final bool? isUser;
  late bool? finishedAnimation;
  final bool? showDefaultGrid;

  AIChatMessage(
    this.text,
    this.metadata,
    this.isUser,
    this.finishedAnimation,
    this.showDefaultGrid,
  );
}

class Config {
  Config({
    this.id,
    this.avatar,
    this.isPublic,
    this.name,
    this.systemMessage,
    this.welcomeMessage,
    this.welcomeMetadata,
  });

  factory Config.fromDto(ConfigDto dto) => Config(
        id: dto.id,
        avatar: dto.avatar,
        isPublic: dto.isPublic,
        name: dto.name,
        systemMessage: dto.systemMessage,
        welcomeMessage: dto.welcomeMessage,
        welcomeMetadata: dto.welcomeMetadata != null
            ? AIMetadata.fromDto(dto.welcomeMetadata!)
            : null,
      );
  final String? id;
  final String? avatar;
  final bool? isPublic;
  final String? name;
  final String? systemMessage;
  final String? welcomeMessage;
  final AIMetadata? welcomeMetadata;
}

class AIMetadata {
  AIMetadata({
    this.buttons,
  });

  factory AIMetadata.fromDto(AIMetadataDto dto) => AIMetadata(
        buttons: List.from(dto.buttons ?? [])
            .map((item) => ButtonMetadata.fromDto(item))
            .toList(),
      );
  final List<ButtonMetadata>? buttons;
}

class ButtonMetadata {
  ButtonMetadata({
    this.action,
    this.color,
    this.description,
    this.icon,
    this.title,
  });

  factory ButtonMetadata.fromDto(ButtonMetadataDto dto) => ButtonMetadata(
        action: dto.action,
        color: dto.color,
        description: dto.description,
        icon: dto.icon,
        title: dto.title,
      );
  final String? action;
  final String? color;
  final String? description;
  final String? icon;
  final String? title;
}
