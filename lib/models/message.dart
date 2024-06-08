class Message {
  final String senderUid;
  final String message;
  final DateTime createdAt;

  Message({
    required this.senderUid,
    required this.message,
    required this.createdAt,
  });
}