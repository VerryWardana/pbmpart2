import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/chat_controller.dart';
import 'package:flutter_application_1/views/mentor/userchatlist_view.dart';

class HomepageMentor extends StatefulWidget {
  @override
  _HomepageMentorState createState() => _HomepageMentorState();
}

class _HomepageMentorState extends State<HomepageMentor> {
  final ChatController _chatController = ChatController();
  final String mentorEmail = 'mentor@example.com'; // Ganti dengan email mentor yang sesuai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'List Chat with Users',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: UserChatList(
              chatController: _chatController,
              mentorEmail: mentorEmail, // Berikan mentorEmail
            ),
          ),
        ],
      ),
    );
  }
}
