// lib/controllers/homepage_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/aduan.dart';

class HomepageuserController {
  late String username;

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      username = userDoc['username'] ?? 'User';
    }
  }

  Future<List<Aduan>> fetchAduan() async {
    List<Aduan> aduanList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('aduan').get();

      for (var doc in querySnapshot.docs) {
        Timestamp timestamp =
            doc['tanggalkejadian']; // Assuming the timestamp field is named 'tanggal'
        DateTime dateTime = timestamp.toDate();
        Aduan aduan = Aduan(
          id: doc.id, // Assuming the document ID is used as the id
          jenisPelecehan:
              doc['jenisPelecehan'], // Extracting jenisPelecehan field
          tanggalKejadian: dateTime, lokasi: doc['lokasi'], kronologi: doc['kronologi'], imageUrl: doc['imageUrl'],
        );
        aduanList.add(aduan);
      }
    } catch (e) {
      print("Error fetching aduan: $e");
    }
    return aduanList;
  }
}
