import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/views/admin/listmentor.dart';
import 'package:flutter_application_1/views/admin/tambahmentor_view.dart';

class HomepageAdmin extends StatelessWidget {
  const HomepageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Verry Wardana',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/saya.JPG'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/mask.png',
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 35,
                  child: Text(
                    'Tambah Mentor',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 35,
                  child: Text(
                    'Klik tanda + untuk menambah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TambahmentorView()),
                      );
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE87C5F),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'List Mentor',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListMentor()),
                );
              },
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 35,
                        color: Color(0xFFE87C5F),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                          color: Color(0xFFE87C5F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(), // This will push the icon to the far right
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFE87C5F),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'List Laporan Pelecehan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
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
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                            color: const Color(0xFFE87C5F),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        '12 Juli 2003',
                        style: TextStyle(
                          color: const Color(0xFFE87C5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
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
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                            color: const Color(0xFFE87C5F),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        '12 Juli 2003',
                        style: TextStyle(
                          color: const Color(0xFFE87C5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
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
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                            color: const Color(0xFFE87C5F),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        '12 Juli 2003',
                        style: TextStyle(
                          color: const Color(0xFFE87C5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
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
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                            color: const Color(0xFFE87C5F),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        '12 Juli 2003',
                        style: TextStyle(
                          color: const Color(0xFFE87C5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE87C5F),
                  ),
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
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'nasigoreng',
                        style: TextStyle(
                            color: const Color(0xFFE87C5F),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        '12 Juli 2003',
                        style: TextStyle(
                          color: const Color(0xFFE87C5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
