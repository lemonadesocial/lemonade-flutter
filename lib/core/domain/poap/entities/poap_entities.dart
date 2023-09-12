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
    this.to,
    this.chainlinkRequest,
  });

  factory Claim.fromDto(ClaimDto dto) => Claim(
        id: dto.id,
        network: dto.network,
        state: dto.state,
        errorMessage: dto.errorMessage,
        args: dto.args != null ? ClaimArgs.fromDto(dto.args!) : null,
        address: dto.address,
        tokenId: dto.tokenId,
        to: dto.to,
        chainlinkRequest: dto.chainlinkRequest != null
            ? ChainlinkRequest.fromDto(dto.chainlinkRequest!)
            : null,
      );

  final String? id;
  final String? network;
  final ClaimState? state;
  final String? errorMessage;
  final ClaimArgs? args;
  final String? address;
  final String? tokenId;
  final String? to;
  final ChainlinkRequest? chainlinkRequest;
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

class ChainlinkRequest {
  ChainlinkRequest({
    this.fulfilled,
  });
  final bool? fulfilled;

  factory ChainlinkRequest.fromDto(ChainlinkRequestDto dto) => ChainlinkRequest(
        fulfilled: dto.fulfilled,
      );
}

class Transfer {
  Transfer({
    this.id,
    this.network,
    this.state,
    this.errorMessage,
    this.args,
    this.address,
    this.tokenId,
    this.to,
  });

  factory Transfer.fromDto(TransferDto dto) => Transfer(
        id: dto.id,
        network: dto.network,
        state: dto.state,
        errorMessage: dto.errorMessage,
        args: dto.args != null ? TransferArgs.fromDto(dto.args!) : null,
        address: dto.address,
        tokenId: dto.tokenId,
        to: dto.to,
      );

  final String? id;
  final String? network;
  final TransferState? state;
  final String? errorMessage;
  final TransferArgs? args;
  final String? address;
  final String? tokenId;
  final String? to;
}

class TransferArgs {
  TransferArgs({
    this.claimer,
    this.tokenURI,
  });

  factory TransferArgs.fromDto(TransferArgsDto dto) => TransferArgs(
        claimer: dto.claimer,
        tokenURI: dto.tokenURI,
      );

  final String? claimer;
  final String? tokenURI;
}

class PoapPolicyNode {
  const PoapPolicyNode({
    required this.value,
    this.children,
  });

  factory PoapPolicyNode.fromDto(PoapPolicyNodeDto dto) => PoapPolicyNode(
        value: dto.value,
        children: List<PoapPolicyNodeDto>.from(dto.children ?? [])
            .map(PoapPolicyNode.fromDto)
            .toList(),
      );

  final String value;
  final List<PoapPolicyNode>? children;
}

class PoapPolicyError {
  PoapPolicyError({
    this.message,
    this.path,
  });

  factory PoapPolicyError.fromDto(PoapPolicyErrorDto dto) => PoapPolicyError(
        message: dto.message,
        path: dto.path,
      );

  final String? message;
  final String? path;
}

class PoapPolicyResult {
  const PoapPolicyResult({
    required this.boolean,
    this.node,
    required this.errors,
  });

  factory PoapPolicyResult.fromDto(PoapPolicyResultDto dto) => PoapPolicyResult(
        boolean: dto.boolean ?? false,
        node: dto.node != null ? PoapPolicyNode.fromDto(dto.node!) : null,
        errors: List<PoapPolicyErrorDto>.from(dto.errors ?? [])
            .map(PoapPolicyError.fromDto)
            .toList(),
      );

  final bool boolean;
  final PoapPolicyNode? node;
  final List<PoapPolicyError> errors;
}

class PoapPolicy {
  PoapPolicy({
    this.id,
    this.network,
    this.address,
    this.node,
    this.result,
  });

  factory PoapPolicy.fromDto(PoapPolicyDto dto) => PoapPolicy(
        id: dto.id,
        network: dto.network,
        address: dto.address,
        node: dto.node != null ? PoapPolicyNode.fromDto(dto.node!) : null,
        result:
            dto.result != null ? PoapPolicyResult.fromDto(dto.result!) : null,
      );

  final String? id;
  final String? network;
  final String? address;
  final PoapPolicyNode? node;
  final PoapPolicyResult? result;
}
