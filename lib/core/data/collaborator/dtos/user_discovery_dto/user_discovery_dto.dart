import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_discovery_dto.freezed.dart';
part 'user_discovery_dto.g.dart';

@freezed
class UserDiscoveryDto with _$UserDiscoveryDto {
  factory UserDiscoveryDto({
    String? user,
    List<String>? selected,
    String? event,
    @JsonKey(name: 'selected_expanded') List<UserDto?>? selectedExpanded,
  }) = _UserDiscoveryDto;

  factory UserDiscoveryDto.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoveryDtoFromJson(json);
}
