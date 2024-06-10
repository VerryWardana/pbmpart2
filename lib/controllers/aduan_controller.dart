import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_application_1/models/aduan.dart';

class AduanController {
  final CollectionReference aduanCollection = FirebaseFirestore.instance.collection('aduan');

  Future<void> addAduan(Aduan aduan, File? imageFile) async {
    String? imageUrl;
    String? email; // Mengganti username dengan email
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      email = user.email; // Menggunakan email dari user saat ini
    }

    if (imageFile != null && email != null) { // Menggunakan email saat ini
      final fileName = '${email}_${aduan.jenisPelecehan}_${DateTime.now()}.png';
      final storageRef = FirebaseStorage.instance.ref().child('aduan/$fileName');
      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    aduan.imageUrl = imageUrl;
    await aduanCollection.add(aduan.toMap());
  }
  Future<List<Aduan>> getAduanList() async {
    QuerySnapshot querySnapshot = await aduanCollection.get();
    return querySnapshot.docs.map((doc) {
      return Aduan.fromMap(doc.data() as DocumentSnapshot<Object?>);
    }).toList();
  }

  getAllAduan() {}
}


