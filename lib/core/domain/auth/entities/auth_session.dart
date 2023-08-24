class AuthSession {

  AuthSession({
    required this.userId,
    required this.userAvatar,
    this.userDisplayName,
    this.username,
    this.wallets,
    this.walletCustodial,
  });
  
  final String userId;
  final String? userAvatar;
  final String? userDisplayName;
  final String? username;
    final List<String>? wallets;
  final String? walletCustodial;
}
