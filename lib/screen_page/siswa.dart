import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_mobile/model/model_siswa.dart';
import 'package:school_mobile/model/model_kelas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siswa App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageSiswa(),
    );
  }
}

class PageSiswa extends StatefulWidget {
  @override
  _PageSiswaState createState() => _PageSiswaState();
}

class _PageSiswaState extends State<PageSiswa> {
  List<Map<String, dynamic>> siswaList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8080//sistem_akademik/get_siswa.php'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          siswaList = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        print('Gagal menampilkan siswa: ${responseData['message']}');
      }
    } else {
      print('Gagal terhubung ke server: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Siswa'),
      ),
      body: ListView.builder(
        itemCount: siswaList.length,
        itemBuilder: (BuildContext context, int index) {
          final siswa = siswaList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(siswa['nama'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NIS: ${siswa['nis'] ?? ''}'),
                  Text('Kelas: ${siswa['kelas'] ?? ''}'),
                  Text('Alamat: ${siswa['alamat'] ?? ''}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
