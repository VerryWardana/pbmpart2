import 'package:cloud_firestore/cloud_firestore.dart';

class Mentor {
  String? id;
  String nama;
  String fotoUrl;
  String email;
  String asal;
  String deskripsi;

  Mentor({
    this.id,
    required this.nama,
    required this.fotoUrl,
    required this.email,
    required this.asal,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'fotoUrl': fotoUrl,
      'email': email,
      'asal': asal,
      'deskripsi': deskripsi,
    };
  }

  factory Mentor.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mentor(
      id: doc.id,
      nama: data['nama'],
      fotoUrl: data['fotoUrl'],
      email: data['email'],
      asal: data['asal'],
      deskripsi: data['deskripsi'],
    );
  }
}
