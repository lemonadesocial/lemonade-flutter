import 'package:app/core/data/wallet/dtos/wallet_dtos.dart';

class UserWalletRequest {

  UserWalletRequest({required this.message, required this.token});

  factory UserWalletRequest.fromDto(UserWalletRequestDto dto) => UserWalletRequest(
        message: dto.message,
        token: dto.token,
      );
  final String message;
  final String token;
}