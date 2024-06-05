import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/artikel_controller.dart';
import 'package:flutter_application_1/models/artikel.dart';
import 'package:flutter_application_1/views/user/detailartikel_view.dart';
import 'package:flutter_application_1/views/user/navbar_bawah.dart';

class ArtikelView extends StatefulWidget {
  const ArtikelView({Key? key}) : super(key: key);

  @override
  State<ArtikelView> createState() => _ArtikelViewState();
}

class _ArtikelViewState extends State<ArtikelView> {
  final ArtikelController _controller = ArtikelController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _controller.fetchArtikels();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarBawah()),
            );
          },
        ),
        title: const Text(
          'Artikel',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFFE87C5F),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _controller.artikels.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _controller.artikels.length,
                itemBuilder: (context, index) {
                  Artikel artikel = _controller.artikels[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            artikel.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 150,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikel.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailartikelView(
                                          artikelId: artikel.id),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00E6AB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Baca',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
