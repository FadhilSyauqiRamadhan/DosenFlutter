import 'package:flutter/material.dart';
import 'pages/splash_screen_page.dart';
import 'pages/list_dosen_page.dart';
import 'pages/tambah_dosen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreenPage(),
        '/list': (_) => ListDosenPage(),
        '/tambah': (_) => TambahDosenPage(),
      },
    );
  }
}