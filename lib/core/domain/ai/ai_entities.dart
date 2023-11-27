class AIChatMessage {
  final String? text;
  final Map<String, dynamic>? metadata;
  final bool? isUser;
  late bool? finishedAnimation;

  AIChatMessage(this.text, this.metadata, this.isUser, this.finishedAnimation);
}
