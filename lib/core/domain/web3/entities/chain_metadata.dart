class ChainMetadata {
  final String id;
  final String chainId;
  final String displayName;
  final String name;
  final String icon;
  final bool isTestnet;
  final String rpcUrl;
  final NativeCurrency nativeCurrency;
  final String Function(String txHash) blockExplorerForTransaction;

  ChainMetadata({
    required this.id,
    required this.chainId,
    required this.name,
    required this.displayName,
    required this.icon,
    this.isTestnet = false,
    required this.rpcUrl,
    required this.nativeCurrency,
    required this.blockExplorerForTransaction,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainMetadata &&
        other.id == id &&
        other.chainId == chainId &&
        other.name == name &&
        other.icon == icon &&
        other.isTestnet == isTestnet &&
        other.rpcUrl == other.rpcUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chainId.hashCode ^
        name.hashCode ^
        icon.hashCode ^
        rpcUrl.hashCode ^
        isTestnet.hashCode;
  }
}

class NativeCurrency {
  final String name;
  final String symbol;
  final int decimals;

  NativeCurrency({
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}
