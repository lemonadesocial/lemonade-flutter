import 'package:app/core/data/collaborator/dtos/user_discovery_dto/user_discovery_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_discovery.freezed.dart';

@freezed
class UserDiscovery with _$UserDiscovery {
  UserDiscovery._();

  factory UserDiscovery({
    String? user,
    List<String>? selected,
    String? event,
    List<User>? selectedExpanded,
  }) = _UserDiscovery;

  factory UserDiscovery.fromDto(UserDiscoveryDto dto) => UserDiscovery(
        user: dto.user,
        selected: dto.selected,
        event: dto.event,
        selectedExpanded: List.from(dto.selectedExpanded ?? [])
            .where((item) => item != null)
            .map((item) => User.fromDto(item))
            .toList(),
      );
}
