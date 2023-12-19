import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_safe_init_info_dto.freezed.dart';
part 'free_safe_init_info_dto.g.dart';

@freezed
class FreeSafeInitInfoDto with _$FreeSafeInitInfoDto {
  factory FreeSafeInitInfoDto({
    int? max,
    int? current,
  }) = _FreeSafeInitInfoDto;

  factory FreeSafeInitInfoDto.fromJson(Map<String, dynamic> json) =>
      _$FreeSafeInitInfoDtoFromJson(json);
}
