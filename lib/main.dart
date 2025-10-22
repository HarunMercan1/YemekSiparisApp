import 'package:flutter/material.dart';
import 'package:repoyukle/presentation/screens/ana_ekran.dart';
import 'presentation/screens/anasayfa.dart';
import 'presentation/screens/ana_ekran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Yemek Sipariş Uygulaması",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
      ),
      home: const AnaEkran(),
    );
  }
}
