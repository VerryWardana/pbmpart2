// report_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_application_1/models/aduan.dart';

class AduanController {
  final CollectionReference aduanCollection = FirebaseFirestore.instance.collection('aduan');

  Future<void> addAduan(Aduan aduan, File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('aduan/${DateTime.now()}.png');
      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    aduan.imageUrl = imageUrl;
    await aduanCollection.add(aduan.toMap());
  }
}
