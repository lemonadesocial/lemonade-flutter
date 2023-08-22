import 'package:app/core/data/poap/dtos/poap_dtos.dart';
import 'package:app/core/domain/poap/poap_enums.dart';

/// Entity for see claimed quantity and quantiy of poap
class PoapViewSupply {
  PoapViewSupply({
    required this.claimedQuantity,
    required this.quantity,
  });

  factory PoapViewSupply.fromDto(PoapViewSupplyDto dto) => PoapViewSupply(
        claimedQuantity: dto.claimedQuantity,
        quantity: dto.quantity,
      );

  final int claimedQuantity;
  final int quantity;
}

class PoapViewCheckHasClaimed {
  PoapViewCheckHasClaimed({
    required this.claimed,
  });

  factory PoapViewCheckHasClaimed.fromDto(PoapViewCheckHasClaimedDto dto) {
    return PoapViewCheckHasClaimed(
      claimed: dto.claimed,
    );
  }

  final bool claimed;
}

class Claim {
  Claim({
    this.id,
    this.network,
    this.state,
    this.errorMessage,
    this.args,
    this.address,
    this.tokenId,
  });

  factory Claim.fromDto(ClaimDto dto) => Claim(
        id: dto.id,
        network: dto.network,
        state: dto.state,
        errorMessage: dto.errorMessage,
        args: dto.args != null ? ClaimArgs.fromDto(dto.args!) : null,
        address: dto.address,
        tokenId: dto.tokenId,
      );

  final String? id;
  final String? network;
  final ClaimState? state;
  final String? errorMessage;
  final ClaimArgs? args;
  final String? address;
  final String? tokenId;
}

class ClaimArgs {
  ClaimArgs({
    this.claimer,
    this.tokenURI,
  });

  factory ClaimArgs.fromDto(ClaimArgsDto dto) => ClaimArgs(
        claimer: dto.claimer,
        tokenURI: dto.tokenURI,
      );

  final String? claimer;
  final String? tokenURI;
}