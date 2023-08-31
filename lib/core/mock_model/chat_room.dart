class ChatRoom {

  ChatRoom({
    this.avatarUrl,
    this.name,
    this.latestMessage,
    this.createdAt,
    this.unseenMessageCount,
    this.isPrivate,
    this.isMuted,
  });
  final String? avatarUrl;
  final String? name;
  final String? latestMessage;
  final DateTime? createdAt;
  final int? unseenMessageCount;
  final bool? isPrivate;
  final bool? isMuted;
}