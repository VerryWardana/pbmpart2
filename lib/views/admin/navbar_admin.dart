import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/HomePageAdmin.dart';
import 'package:flutter_application_1/views/admin/tambahmentor_view.dart';
import 'package:flutter_application_1/views/user/aduan_view.dart';


class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({Key? key}) : super(key: key);

  @override
  State<NavbarAdmin> createState() => _NavbarAdmin();
}

class _NavbarAdmin extends State<NavbarAdmin> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomepageAdmin(),
    TambahmentorView(),
    FormaduanView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Mentor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey, // Tambahkan warna untuk item yang tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}