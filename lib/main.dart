import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/HomePageAdmin.dart';
import 'package:flutter_application_1/views/mentor/homepage.dart';
import 'package:flutter_application_1/views/user/formaduan.dart';
import 'package:flutter_application_1/views/user/homepage_view.dart';
import 'package:flutter_application_1/views/user/navbar_bawah.dart';
import 'views/user/splashscreen.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/user/navbar_bawah.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAoDZpXHCr0BZ22aigVNsEOjRzVxjpuYBU",
        authDomain: "pbmproject-ee93a.firebaseapp.com",
        projectId: "pbmproject-ee93a",
        storageBucket: "pbmproject-ee93a.appspot.com",
        messagingSenderId: "972986084505",
        appId: "1:972986084505:web:628210a18bd31c74b19c08",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Atur rute aplikasi
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/homepageuser': (context) => HomepageUser(),
        '/homepageadmin': (context) => HomepageAdmin(),
        '/homepagementor': (context) => HomepageMentor(),
        '/register': (context) => Register(),
      },
    );
  }
}
