import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/aduan.dart';
import 'package:flutter_application_1/models/mentor.dart';

class HomepageuserController {
  late String email;
  late String username;
  late String imageUrl;

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      email = user.email ?? userDoc['email'];
      username = userDoc['username'];
      imageUrl = userDoc['imageUrl'];
    }
  }

  Future<List<Aduan>> fetchAduan() async {
    List<Aduan> aduanList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('aduan')
              .where('email', isEqualTo: email)
              .get();

      for (var doc in querySnapshot.docs) {
        Timestamp timestamp = doc['tanggalkejadian'];
        DateTime dateTime = timestamp.toDate();
        Aduan aduan = Aduan(
          id: doc.id,
          email: doc['email'],
          jenisPelecehan: doc['jenispelecehan'],
          tanggalKejadian: dateTime,
          lokasi: doc['lokasi'],
          kronologi: doc['kronologi'],
          imageUrl: doc['imageUrl'],
        );
        aduanList.add(aduan);
      }
    } catch (e) {
      print("Error fetching aduan: $e");
    }
    return aduanList;
  }

  Future<List<Mentor>> fetchMentors() async {
    List<Mentor> mentorList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('mentor')
              .get();

      for (var doc in querySnapshot.docs) {
        Mentor mentor = Mentor(
          id: doc.id,
          nama: doc['nama'],
          fotoUrl: doc['fotoUrl'],
          email: doc['email'],
          asal: doc['asal'],
          deskripsi: doc['deskripsi'],
        );
        mentorList.add(mentor);
      }
    } catch (e) {
      print("Error fetching mentors: $e");
    }
    return mentorList;
  }
}
