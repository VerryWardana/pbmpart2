class ChatRoom {
  final String roomId;
  final String userUid;
  final String mentorEmail;
  final DateTime createdAt;

  ChatRoom({
    required this.roomId,
    required this.userUid,
    required this.mentorEmail,
    required this.createdAt,
  });
}