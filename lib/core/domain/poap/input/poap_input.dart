import 'package:freezed_annotation/freezed_annotation.dart';

part 'poap_input.freezed.dart';
part 'poap_input.g.dart';

@freezed
class GetPoapViewSupplyInput with _$GetPoapViewSupplyInput {
  factory GetPoapViewSupplyInput({
    required String network,
    required String address,
    @Default('supply') name,
  }) = _GetPoapViewSupplyInput;
  
  factory GetPoapViewSupplyInput.fromJson(Map<String, dynamic> json) => _$GetPoapViewSupplyInputFromJson(json);
}

@freezed
class CheckHasClaimedPoapViewInput with _$CheckHasClaimedPoapViewInput {
  factory CheckHasClaimedPoapViewInput({
    required String network,
    required String address,
    @Default('hasClaimed') name,
    /// user wallet address,
    required List<List<String>> args,
  }) = _CheckHasClaimedPoapViewInput;
  
  factory CheckHasClaimedPoapViewInput.fromJson(Map<String, dynamic> json) => _$CheckHasClaimedPoapViewInputFromJson(json);
}

