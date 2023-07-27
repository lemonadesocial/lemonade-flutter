
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_dtos.freezed.dart';
part 'wallet_dtos.g.dart';

@freezed
class UserWalletRequestDto with _$UserWalletRequestDto {
  const factory UserWalletRequestDto({
    required String message,
    required String token,
  }) = _UserWalletRequestDto;
  
  factory UserWalletRequestDto.fromJson(Map<String, dynamic> json) => _$UserWalletRequestDtoFromJson(json);
}