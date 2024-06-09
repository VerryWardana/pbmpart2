import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/mentor_controller.dart';
import 'package:flutter_application_1/models/mentor.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';

class ListMentor extends StatefulWidget {
  ListMentor({Key? key}) : super(key: key);

  @override
  _ListMentorState createState() => _ListMentorState();
}

class _ListMentorState extends State<ListMentor> {
  final MentorController _mentorController = MentorController();

  late Future<List<Mentor>> _mentorsFuture;

  @override
  void initState() {
    super.initState();
    _mentorsFuture = _mentorController.getMentors();
  }

  void _deleteMentor(String id) async {
    await _mentorController.deleteMentor(id);
    setState(() {
      _mentorsFuture = _mentorController.getMentors();
    });
  }

void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Konfirmasi Hapus",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Apakah Anda ingin menghapus mentor ini?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Tidak",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Ya",
                style: TextStyle(color: Colors.greenAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteMentor(id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarAdmin()),
            );
          },
        ),
        title: const Center(
          child: Text(
            'List Mentor',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<List<Mentor>>(
        future: _mentorsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Terjadi kesalahan"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final mentors = snapshot.data ?? [];

          return ListView.builder(
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              var mentor = mentors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(mentor.fotoUrl),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mentor.nama,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  mentor.asal,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFF8A083),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  mentor.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, mentor.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
