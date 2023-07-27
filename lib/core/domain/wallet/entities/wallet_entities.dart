import 'package:app/core/data/wallet/dtos/wallet_dtos.dart';

class UserWalletRequest {
  final String message;
  final String token;

  UserWalletRequest({required this.message, required this.token});

  factory UserWalletRequest.fromDto(UserWalletRequestDto dto) => UserWalletRequest(
        message: dto.message,
        token: dto.token,
      );
}