import 'package:flutter/material.dart';
import 'package:school_mobile/screen_page/flashscreen.dart'; // Import FlashScreen
import 'package:school_mobile/screen_page/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashScreen(), // Menggunakan FlashScreen sebagai home
    );
  }
}
