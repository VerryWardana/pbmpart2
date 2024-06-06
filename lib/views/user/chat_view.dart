import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/mentor.dart';

class ChatView extends StatefulWidget {
  final Mentor mentor;

  const ChatView({Key? key, required this.mentor}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat dengan ${widget.mentor.nama}'),
      ),
      body: FutureBuilder(
        future: FirebaseChatCore.instance.createRoom(userIds: [widget.mentor.email]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final room = snapshot.data;
            return Chat(
              messages: FirebaseChatCore.instance.messages(room!.id),
              onSendPressed: (partialText) {
                final message = types.TextMessage(
                  authorId: FirebaseAuth.instance.currentUser!.uid,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  id: '',
                  roomId: room.id,
                  text: partialText.text,
                );
                FirebaseChatCore.instance.sendMessage(message, room.id);
              },
              user: types.User(
                id: FirebaseAuth.instance.currentUser!.uid,
              ),
            );
          }
        },
      ),
    );
  }
}
