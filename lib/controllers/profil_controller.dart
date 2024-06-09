import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart'
    as model_user; // alias ditambahkan di sini
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilController {
  late String imageUrl;
  late String email;
  late String username;
  late String umur;
  late String jenisKelamin;

  Future<model_user.User> getCurrentUserData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        imageUrl = userDoc['imageUrl'] ?? '';
        email = user.email ?? '';
        username = userDoc['username'] ?? 'User';
        umur = userDoc['umur'] ?? '';
        jenisKelamin = userDoc['jeniskelamin'] ?? '';

        return model_user.User(
          // menggunakan alias di sini
          id: user.uid,
          username: username,
          email: email,
          imageUrl: imageUrl,
          nama: user.displayName ?? 'User',
          umur: umur,
          jenisKelamin: jenisKelamin,
        );
      } else {
        throw 'User not found';
      }
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  Future<void> changeProfilePicture(
      BuildContext context, model_user.User user) async {
    // menggunakan alias di sini
    try {
      final pickedFile = await _pickImageFromGallery();
      if (pickedFile != null) {
        final imageUrl = await _uploadImageToStorage(pickedFile, user);
        await _updateImageUrlInFirestore(user.id, imageUrl);
      }
    } catch (e) {
      print('Error changing profile picture: $e');
      // Handle error if necessary
    }
  }

  Future<File?> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<String> _uploadImageToStorage(
      File imageFile, model_user.User user) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('profil').child('$email.png');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  Future<void> _updateImageUrlInFirestore(
      String userId, String imageUrl) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'imageUrl': imageUrl});
  }

  Future<void> updateUserData(
    String userId,
    String newUsername,
    String newUmur,
    String newJenisKelamin,
  ) async {
    try {
      // Update username and email in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'username': newUsername,
        'umur': newUmur,
        'jeniskelamin': newJenisKelamin,
      });

      // If no errors, email is updated in both places
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigasi ke halaman login
      Navigator.of(context).pushReplacementNamed('/logout');
    } catch (e) {
      print('Error signing out: $e');
      // Handle error if necessary
    }
  }
}
