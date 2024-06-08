import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/chat_controller.dart';

class UserChatList extends StatelessWidget {
  final ChatController chatController;
  final String mentorEmail; 

  const UserChatList({
    Key? key,
    required this.chatController,
    required this.mentorEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: chatController.getUserChatRooms(mentorEmail), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), 
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<String> userChats = snapshot.data ?? [];
          if (userChats.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada chat dengan Anda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: userChats.length,
              itemBuilder: (context, index) {
                String userChatId = userChats[index];
                return ListTile(
                  title: Text('User Chat ID: $userChatId'),
                  onTap: () {
                    // Navigate to user chat room
                  },
                );
              },
            );
          }
        }
      },
    );
  }
}
