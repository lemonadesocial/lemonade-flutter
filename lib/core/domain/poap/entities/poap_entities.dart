
import 'package:app/core/data/poap/dtos/poap_dtos.dart';

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
