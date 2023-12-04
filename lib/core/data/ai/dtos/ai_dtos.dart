import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_dtos.g.dart';
part 'ai_dtos.freezed.dart';

@freezed
class ConfigDto with _$ConfigDto {
  @JsonSerializable(explicitToJson: true)
  factory ConfigDto({
    @JsonKey(name: '_id') String? id,
    String? avatar,
    bool? isPublic,
    String? name,
    String? systemMessage,
    String? welcomeMessage,
    AIMetadataDto? welcomeMetadata,
  }) = _ConfigDto;

  factory ConfigDto.fromJson(Map<String, dynamic> json) =>
      _$ConfigDtoFromJson(json);
}

@freezed
class AIMetadataDto with _$AIMetadataDto {
  @JsonSerializable(explicitToJson: true)
  factory AIMetadataDto({
    List<ButtonMetadataDto>? buttons,
  }) = _AIMetadataDto;

  factory AIMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$AIMetadataDtoFromJson(json);
}

@freezed
class ButtonMetadataDto with _$ButtonMetadataDto {
  @JsonSerializable(explicitToJson: true)
  factory ButtonMetadataDto({
    String? action,
    String? color,
    String? description,
    String? icon,
    String? title,
  }) = _ButtonMetadataDto;

  factory ButtonMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$ButtonMetadataDtoFromJson(json);
}
