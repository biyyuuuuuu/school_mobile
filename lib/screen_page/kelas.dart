import 'package:flutter/material.dart';

class PageKelas extends StatefulWidget {
  const PageKelas({Key? key}) : super(key: key);

  @override
  State<PageKelas> createState() => _PageKelasState();
}

class _PageKelasState extends State<PageKelas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Kelas'),
      ),
      body: Center(
        child: Text(
          'Halaman Kelas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
