class PoapViewSupplyDto {
  PoapViewSupplyDto({
    required this.claimedQuantity,
    required this.quantity,
  });

  factory PoapViewSupplyDto.fromJson(List<dynamic>? data) {
    if (data == null || data.length < 2) {
      return PoapViewSupplyDto(
        claimedQuantity: 0,
        quantity: 0,
      );
    }

    return PoapViewSupplyDto(
      claimedQuantity: num.tryParse(data[0])?.toInt() ?? 0,
      quantity: num.tryParse(data[1])?.toInt() ?? 0,
    );
  }

  final int claimedQuantity;
  final int quantity;
}

class PoapViewCheckHasClaimedDto {
  PoapViewCheckHasClaimedDto({
    required this.claimed,
  });

  factory PoapViewCheckHasClaimedDto.fromJson(List<dynamic>? data) {
    return PoapViewCheckHasClaimedDto(
      claimed: bool.tryParse(data?[0]) ?? false,
    );
  }

  final bool claimed;
}
