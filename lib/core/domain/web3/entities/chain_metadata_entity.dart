class ChainMetadata {
  final String chainId;
  final String displayName;
  final String name;
  final String icon;
  final bool isTestnet;
  final String rpcUrl;

  ChainMetadata({
    required this.chainId,
    required this.name,
    required this.displayName,
    required this.icon,
    this.isTestnet = false,
    required this.rpcUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainMetadata &&
        other.chainId == chainId &&
        other.name == name &&
        other.icon == icon &&
        other.isTestnet == isTestnet &&
        other.rpcUrl == other.rpcUrl;
  }

  @override
  int get hashCode {
    return chainId.hashCode ^ name.hashCode ^ icon.hashCode ^ rpcUrl.hashCode ^ isTestnet.hashCode;
  }
}
