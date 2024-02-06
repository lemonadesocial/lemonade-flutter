import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_with_presigned_url_dto.freezed.dart';
part 'file_with_presigned_url_dto.g.dart';

@freezed
class FileWithPresignedUrlDto with _$FileWithPresignedUrlDto {
  factory FileWithPresignedUrlDto({
    @JsonKey(name: '_id') String? id,
    String? type,
    String? url,
    @JsonKey(name: 'presigned_url') String? presignedUrl,
  }) = _FileWithPresignedUrlDto;

  factory FileWithPresignedUrlDto.fromJson(Map<String, dynamic> json) =>
      _$FileWithPresignedUrlDtoFromJson(json);
}
