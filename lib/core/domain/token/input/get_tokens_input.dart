
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tokens_input.freezed.dart';
part 'get_tokens_input.g.dart';

@freezed
class GetTokensInput with _$GetTokensInput {
  const factory GetTokensInput({
    @JsonKey(includeIfNull: false) String? owner,
    @JsonKey(name: 'owner_in', includeIfNull: false) List<String>? ownerIn,
    @JsonKey(includeIfNull: false) String? tokenId,
    @JsonKey(includeIfNull: false) String? contract,
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false, name:'id_in') List<String>? idIn,
    @JsonKey(includeIfNull: false) String? creator,
    @JsonKey(includeIfNull: false) String? network,
    @Default(0) int skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetTokensInput;

  factory GetTokensInput.fromJson(Map<String, dynamic> json) => _$GetTokensInputFromJson(json);
}