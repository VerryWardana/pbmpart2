import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/user/artikel_view.dart';
import 'package:flutter_application_1/views/user/homepage_view.dart';
import 'package:flutter_application_1/views/user/listpesan.dart';

class NavbarBawah extends StatefulWidget {
  const NavbarBawah({Key? key}) : super(key: key);

  @override
  State<NavbarBawah> createState() => _NavbarBawah();
}

class _NavbarBawah extends State<NavbarBawah> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomepageuserView(),
    ArtikelView(),
    ListpesanView()
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
            label: 'Artikel',
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