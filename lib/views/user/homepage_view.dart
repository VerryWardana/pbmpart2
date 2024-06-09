import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/homepage_controller.dart';
import 'package:flutter_application_1/models/aduan.dart';
import 'package:flutter_application_1/models/mentor.dart';
import 'package:flutter_application_1/views/user/aduan_view.dart';
import 'package:flutter_application_1/views/user/artikel_view.dart';
import 'package:flutter_application_1/views/user/chat_view.dart';
import 'package:flutter_application_1/controllers/chat_controller.dart';
import 'package:flutter_application_1/views/user/profil_view.dart';

class HomepageuserView extends StatefulWidget {
  const HomepageuserView({Key? key}) : super(key: key);

  @override
  _HomepageuserViewState createState() => _HomepageuserViewState();
}

class _HomepageuserViewState extends State<HomepageuserView> {
  final HomepageuserController _controller = HomepageuserController();
  final ChatController _chatController = ChatController(); // Tambahkan ini
  List<Aduan> aduanList = [];
  List<Mentor> mentorList = [];

  @override
  void initState() {
    super.initState();
    _controller.getCurrentUser().then((_) {
      setState(() {}); // Update the UI when data is fetched
    });
    _controller.fetchMentors().then((mentors) {
      setState(() {
        mentorList = mentors;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat Datang',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        'Halo, ${_controller.username}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilUser(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: _controller.imageUrl.isNotEmpty
                        ? NetworkImage(_controller.imageUrl)
                        : const AssetImage('assets/images/Profile.png')
                            as ImageProvider,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/mask.png',
                  ),
                ),
                const Positioned(
                  top: 30,
                  left: 35,
                  child: Text(
                    'Mengalami pelecehan?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
                const Positioned(
                  top: 55,
                  left: 35,
                  child: Text(
                    'Klik tanda + untuk melapor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE87C5F),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormaduanView()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Butuh Teman Curhat?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: mentorList.isNotEmpty
                  ? Row(
                      children: mentorList.map((mentor) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              _showMentorDetails(context, mentor);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(mentor.fotoUrl),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  mentor.nama,
                                  style: const TextStyle(
                                      fontSize: 12, fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada mentor',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'Poppins'),
                      ),
                    ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Artikel Mingguan',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 5),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 200, // Sesuaikan dengan ukuran gambar Artikel.png
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Artikel.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 250,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00E6AB),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArtikelView()),
                        );
                      },
                      child: const Text('Baca',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins')),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Riwayat Laporan',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Aduan>>(
                future: _controller.fetchAduan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada data aduan"),
                    );
                  } else {
                    var aduanList = snapshot.data!;
                    return ListView.builder(
                      itemCount: aduanList.length,
                      itemBuilder: (context, index) {
                        var aduan = aduanList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Container(
                            width: 380,
                            height: 53,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFE87C5F),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/icons.png',
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    aduan.jenisPelecehan,
                                    style: const TextStyle(
                                        color: Color(0xFFE87C5F),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${aduan.tanggalKejadian.day} ${_getMonthName(aduan.tanggalKejadian.month)} ${aduan.tanggalKejadian.year}',
                                    style: const TextStyle(
                                      color: Color(0xFFE87C5F),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return monthNames[month - 1];
  }

  void _showMentorDetails(BuildContext context, Mentor mentor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(mentor.fotoUrl),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mentor.nama,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            mentor.asal,
                            style: const TextStyle(
                                color: Color(0xFFF8A083),
                                fontFamily: 'Poppins'),
                          ),
                          Text(mentor.email),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    mentor.deskripsi,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF8A083),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatView(mentor: mentor)),
                        );
                      },
                      icon: const Icon(Icons.chat, color: Colors.white),
                      label: const Text(
                        'Chat Sekarang',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
