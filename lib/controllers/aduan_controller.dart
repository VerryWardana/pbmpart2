import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_application_1/models/aduan.dart';

class AduanController {
  final CollectionReference aduanCollection = FirebaseFirestore.instance.collection('aduan');

  Future<void> addAduan(Aduan aduan, File? imageFile) async {
    String? imageUrl;
    String? username;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      username = userDoc['username'] ?? 'User';
    }

    if (imageFile != null && username != null) {
      final fileName = '${username}_${aduan.jenisPelecehan}_${DateTime.now()}.png';
      final storageRef = FirebaseStorage.instance.ref().child('aduan/$fileName');
      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    aduan.imageUrl = imageUrl;
    await aduanCollection.add(aduan.toMap());
  }
}
