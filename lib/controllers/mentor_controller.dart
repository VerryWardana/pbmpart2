import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/models/mentor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Mentorcontroller {
  final CollectionReference mentorsCollection =
      FirebaseFirestore.instance.collection('mentor');

  final ImagePicker _picker = ImagePicker();

  Future<List<Mentor>> getMentors() async {
    QuerySnapshot snapshot = await mentorsCollection.get();
    return snapshot.docs.map((doc) => Mentor.fromMap(doc)).toList();
  }

  Future<void> tambahMentor(String nama, String asal, String deskripsi, String fotoUrl, String email) async {
    await mentorsCollection.add({
      'nama': nama,
      'asal': asal,
      'deskripsi': deskripsi,
      'fotoUrl': fotoUrl,
      'email': email,
    });
  }

  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String> uploadImage(File image, String fileName) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('mentor/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
