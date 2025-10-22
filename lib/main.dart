import 'package:flutter/material.dart';
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
        primaryColor: const Color(0xFF1565C0), // koyu mavi
        scaffoldBackgroundColor: const Color(0xFFE3F2FD), // açık mavi-gri arka plan
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0), // tüm appbar’lar mavi
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0), // mavi buton
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blue.shade700,
          contentTextStyle: const TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF42A5F5), // açık mavi ton
        ),
      ),
      home: const AnaEkran(),
    );
  }
}
