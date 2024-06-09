// models/aduan.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Aduan {
  String? id;
  String email;
  String jenisPelecehan;
  DateTime tanggalKejadian;
  String lokasi;
  String kronologi;
  String? imageUrl;

  Aduan({
    this.id,
    required this.email,
    required this.jenisPelecehan,
    required this.tanggalKejadian,
    required this.lokasi,
    required this.kronologi,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'jenispelecehan': jenisPelecehan,
      'tanggalkejadian': tanggalKejadian,
      'lokasi': lokasi,
      'kronologi': kronologi,
      'imageUrl': imageUrl,
    };
  }

  factory Aduan.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Aduan(
      id: doc.id,
      email: data['email'],
      jenisPelecehan: data['jenispelecehan'],
      tanggalKejadian: (data['tanggalkejadian'] as Timestamp).toDate(),
      lokasi: data['lokasi'],
      kronologi: data['kronologi'],
      imageUrl: data['imageUrl'],
    );
  }
}
