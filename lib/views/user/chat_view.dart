import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/chat_controller.dart';

class ChatUser extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatUser({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth controller
  final ChatController _chatController = ChatController();
  final AuthController _authController = AuthController();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatController.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // messages list
          Expanded(child: _buildMessagesList()),

          // user input
        ],
      ),
    );
  }

  // build messages list
  Widget _buildMessagesList() {
    String senderID = _authController.getCurrentUser!.uid;
    return StreamBuilder(
      stream: _chatController.getMessages(
        receiverID,
        senderID,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Text(data['message']);
  }

  // build user input
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
