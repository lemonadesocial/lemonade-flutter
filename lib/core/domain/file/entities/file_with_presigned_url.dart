import 'package:app/core/data/file/dtos/file_with_presigned_url_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_with_presigned_url.freezed.dart';

@freezed
class FileWithPresignedUrl with _$FileWithPresignedUrl {
  factory FileWithPresignedUrl({
    String? id,
    String? type,
    String? url,
    String? presignedUrl,
  }) = _FileWithPresignedUrl;

  factory FileWithPresignedUrl.fromDto(FileWithPresignedUrlDto dto) =>
      FileWithPresignedUrl(
        id: dto.id,
        type: dto.type,
        url: dto.type,
        presignedUrl: dto.presignedUrl,
      );
}
