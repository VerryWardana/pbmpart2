import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/aduan_controller.dart';
import 'package:flutter_application_1/models/aduan.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';
import 'package:intl/intl.dart';

class ListAduan extends StatefulWidget {
  ListAduan({Key? key}) : super(key: key);

  @override
  _ListAduan createState() => _ListAduan();
}

class _ListAduan extends State<ListAduan> {
  final AduanController _controller = AduanController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        leading: IconButton(
          icon: const Icon(Icons.assignment_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarAdmin()),
            );
          },
        ),
        title: const Center(
          child: Text(
            'Laporan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF88A65),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Aduan>>(
        future: _controller.getAllAduan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada laporan aduan saat ini'));
          } else {
            List<Aduan> aduanList = snapshot.data!;
            return ListView.builder(
              itemCount: aduanList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 380,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE87C5F)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal: ${DateFormat('dd/MM/yyyy').format(aduanList[index].tanggalKejadian)}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tempat Kejadian: ${aduanList[index].lokasi}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kronologi: ${aduanList[index].kronologi}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
