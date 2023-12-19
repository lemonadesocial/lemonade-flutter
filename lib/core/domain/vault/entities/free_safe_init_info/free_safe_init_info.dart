import 'package:app/core/data/vault/dtos/free_safe_init_info_dto/free_safe_init_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_safe_init_info.freezed.dart';
part 'free_safe_init_info.g.dart';

@freezed
class FreeSafeInitInfo with _$FreeSafeInitInfo {
  FreeSafeInitInfo._();

  factory FreeSafeInitInfo({
    int? max,
    int? current,
    int? remaining,
  }) = _FreeSafeInitInfo;

  factory FreeSafeInitInfo.fromJson(Map<String, dynamic> json) =>
      _$FreeSafeInitInfoFromJson(json);

  factory FreeSafeInitInfo.fromDto(FreeSafeInitInfoDto dto) => FreeSafeInitInfo(
        max: dto.max,
        current: dto.current,
        remaining: (dto.max ?? 0) - (dto.current ?? 0),
      );
}
