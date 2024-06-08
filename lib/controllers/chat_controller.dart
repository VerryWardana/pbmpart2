import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Membuat ruang obrolan antara pengguna (user) dan mentor
  Future<String> createChatRoom(String userUid, String mentorEmail) async {
    String roomId = 'chat_$userUid$mentorEmail';
    await _firestore.collection('chat_room').doc(roomId).set({
      'userUid': userUid,
      'mentorEmail': mentorEmail,
      'createdAt': DateTime.now(),
    });
    return roomId;
  }

  // Mengirim pesan ke ruang obrolan
  Future<void> sendMessage(
      String roomId, String senderUid, String message) async {
    await _firestore
        .collection('chat_room')
        .doc(roomId)
        .collection('messages')
        .add({
      'senderUid': senderUid,
      'message': message,
      'createdAt': DateTime.now(),
    });
  }

  // Mendapatkan daftar pesan dari ruang obrolan
  Stream<QuerySnapshot> getChatMessages(String roomId) {
    return _firestore
        .collection('chat_room')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  // Mendapatkan daftar ruang obrolan pengguna
  Stream<List<String>> getUserChatRooms(String mentorEmail) {
    return _firestore
        .collection('chat_room')
        .where('mentorEmail', isEqualTo: mentorEmail)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.id).toList());
  }
}
