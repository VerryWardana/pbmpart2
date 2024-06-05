import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailartikelView extends StatelessWidget {
  final String artikelId;

  const DetailartikelView({Key? key, required this.artikelId})
      : super(key: key);

  Future<DocumentSnapshot> _fetchArtikelDetail() async {
    return await FirebaseFirestore.instance
        .collection('artikel')
        .doc(artikelId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detail Artikel',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFFE87C5F))),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchArtikelDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Artikel tidak ditemukan'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Border radius
                    child: Image.network(data['imageUrl']),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data['judul'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data['content'] ?? 'Tidak ada konten',
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
