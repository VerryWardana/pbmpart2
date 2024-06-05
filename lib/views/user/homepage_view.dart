// lib/views/homepage_user.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/homepage_controller.dart';
import 'package:flutter_application_1/models/aduan.dart';
import 'package:flutter_application_1/views/user/aduan_view.dart';

class HomepageUser extends StatefulWidget {
  const HomepageUser({Key? key}) : super(key: key);

  @override
  _HomepageUserState createState() => _HomepageUserState();
}

class _HomepageUserState extends State<HomepageUser> {
  final HomepageuserController _controller = HomepageuserController();
  List<Aduan> aduanList = [];

  @override
  void initState() {
    super.initState();
    _controller.getCurrentUser().then((_) {
      setState(() {}); // Update the UI when data is fetched
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
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/saya.JPG'),
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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/images/saya.JPG'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Dr.Verry',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/images/saya.JPG'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'fasjfhbajfhjfna',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/images/saya.JPG'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'fasjfhbajfhjfna',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/mask2.png',
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 15,
                  child: Image.asset(
                    'assets/images/animasi.png',
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormaduanView()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE87C5F),
                    ),
                    child: const Text(
                      'ayo main',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  // Text(
                                  //   '${aduan.tanggal.day} ${_getMonthName(aduan.tanggal.month)} ${aduan.tanggal.year}',
                                  //   style: const TextStyle(
                                  //     color: Color(0xFFE87C5F),
                                  //   ),
                                  // ),
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
}
