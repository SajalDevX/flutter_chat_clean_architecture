class Message {
  final String id;
  final String? receiverId;
  final String senderId;
  final String chatId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message(
      {required this.id,
      this.receiverId,
      required this.senderId,
      required this.chatId,
      required this.content,
      required this.timestamp,
      required this.isRead});
}
