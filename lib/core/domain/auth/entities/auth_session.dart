class AuthSession {
  final String userId;
  final String? userAvatar;
  final String? userDisplayName;
  final String? username;

  AuthSession({
    required this.userId,
    required this.userAvatar,
    this.userDisplayName,
    this.username,
  });
}
