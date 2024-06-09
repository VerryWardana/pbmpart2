import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/HomePageAdmin.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';
import 'package:flutter_application_1/views/mentor/homepage.dart';
import 'package:flutter_application_1/views/user/aduan_view.dart';
import 'package:flutter_application_1/views/user/homepage_view.dart';
import 'package:flutter_application_1/views/user/navbar_bawah.dart';
import 'views/user/splashscreen.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/user/navbar_bawah.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
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
        '/homepageuser': (context) => NavbarBawah(),
        '/homepageadmin': (context) => NavbarAdmin(),
        '/homepagementor': (context) => HomepageMentor(),
        '/register': (context) => Register(),
        '/logout': (context) => Login(),
      },
    );
  }
}
