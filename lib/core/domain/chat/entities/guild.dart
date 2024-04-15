import 'package:freezed_annotation/freezed_annotation.dart';

part 'guild.g.dart';
part 'guild.freezed.dart';

@freezed
class Guild with _$Guild {
  @JsonSerializable(explicitToJson: true)
  const factory Guild({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? showMembers,
    int? memberCount,
    List<GuildRole>? roles,
  }) = _Guild;

  factory Guild.fromJson(Map<String, dynamic> json) => _$GuildFromJson(json);
}

@freezed
class GuildRole with _$GuildRole {
  @JsonSerializable(explicitToJson: true)
  const factory GuildRole({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? logic,
    String? visibility,
    List<GuildRequirement>? requirements,
  }) = _GuildRole;

  factory GuildRole.fromJson(Map<String, dynamic> json) =>
      _$GuildRoleFromJson(json);
}

@freezed
class GuildRequirement with _$GuildRequirement {
  @JsonSerializable(explicitToJson: true)
  const factory GuildRequirement({
    int? id,
    String? name,
    String? address,
    String? type,
    String? symbol,
    String? chain,
    bool? isNegated,
    int? roleId,
    String? visibility,
    int? visibilityRoleId,
  }) = _GuildRequirement;

  factory GuildRequirement.fromJson(Map<String, dynamic> json) =>
      _$GuildRequirementFromJson(json);
}

@freezed
class GuildRolePermission with _$GuildRolePermission {
  @JsonSerializable(explicitToJson: true)
  const factory GuildRolePermission({int? roleId, bool? access}) =
      _GuildRolePermission;

  factory GuildRolePermission.fromJson(Map<String, dynamic> json) =>
      _$GuildRolePermissionFromJson(json);
}
