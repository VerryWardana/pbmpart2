import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/artikel.dart';

class ArtikelController {
  final List<Artikel> _artikels = [];

  List<Artikel> get artikels => _artikels;

  Future<void> fetchArtikels() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('artikel').get();

    _artikels.clear();
    for (var doc in snapshot.docs) {
      _artikels.add(Artikel(
        id: doc.id,  // Use doc.id to get the document ID
        imageUrl: doc['imageUrl'],
        title: doc['judul'],
      ));
    }
  }
}
