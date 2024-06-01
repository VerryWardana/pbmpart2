import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Masuk dengan email dan password
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ambil peran pengguna dari Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      String role = userDoc['role'];

      // Arahkan pengguna ke halaman yang sesuai berdasarkan perannya
      switch (role) {
        case 'user':
          Navigator.pushReplacementNamed(context, '/homepageuser');
          break;
        case 'admin':
          Navigator.pushReplacementNamed(context, '/homepageadmin');
          break;
        case 'mentor':
          Navigator.pushReplacementNamed(context, '/homepagementor');
          break;
        default:
          throw ('Peran tidak dikenali');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw ('Alamat email tidak valid');
        case 'user-disabled':
          throw ('Pengguna telah dinonaktifkan');
        case 'user-not-found':
          throw ('Tidak ada pengguna yang ditemukan untuk email ini');
        case 'wrong-password':
          throw ('Password salah');
        default:
          throw ('Email atau password salah');
      }
    } catch (e) {
      throw Exception(
          'Terjadi kesalahan yang tidak diketahui: ${e.toString()}');
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Tambahkan data pengguna ke Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'username': username, // Simpan username dalam firestore
        'role': 'user',
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw ('Email sudah digunakan');
        case 'invalid-email':
          throw ('Alamat email tidak valid');
        case 'operation-not-allowed':
          throw ('Operasi ini tidak diizinkan');
        case 'weak-password':
          throw ('Password terlalu lemah');
        default:
          throw ('Pendaftaran gagal, silakan coba lagi');
      }
    } catch (e) {
      throw Exception(
          'Terjadi kesalahan yang tidak diketahui: ${e.toString()}');
    }
  }
}
