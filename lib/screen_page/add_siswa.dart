import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:school_mobile/model/model_siswa.dart' as siswa;
import 'package:school_mobile/model/model_kelas.dart' as kelas;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddSiswaScreen(),
    );
  }
}

class AddSiswaScreen extends StatefulWidget {
  @override
  _AddSiswaScreenState createState() => _AddSiswaScreenState();
}

class _AddSiswaScreenState extends State<AddSiswaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nisController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedKelas;
  List<kelas.Datum> kelasList = [];

  @override
  void initState() {
    super.initState();
    _fetchKelas();
  }

  Future<void> _fetchKelas() async {
    final String apiUrl = "http://127.0.0.1:8080/sistem_akademik/get_kelas.php";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final kelas.ModelKelas modelKelas =
            kelas.modelKelasFromJson(response.body);
        setState(() {
          kelasList = modelKelas.data;
        });
        print('Data Kelas: ${kelasList.map((k) => k.kelas).toList()}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengambil data kelas")),
        );
      }
    } catch (e) {
      print('Error fetching kelas: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching kelas")),
      );
    }
  }

  Future<void> _addSiswa() async {
    final String apiUrl = "http://127.0.0.1:8080/sistem_akademik/add_siswa.php";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "nis": nisController.text,
          "nama": namaController.text,
          "alamat": alamatController.text,
          "jenis_kelamin": jenisKelaminController.text,
          "tanggal_lahir": tanggalLahirController.text,
          "email": emailController.text,
          "id_kelas": selectedKelas,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        siswa.ModelSiswa modelSiswa = siswa.ModelSiswa.fromJson(data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(modelSiswa.message)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menambahkan siswa")),
        );
      }
    } catch (e) {
      print('Error adding siswa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding siswa")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Siswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nisController,
                decoration: InputDecoration(labelText: 'NIS'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan NIS';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Alamat';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                value: null,
                items: [
                  DropdownMenuItem(
                      child: Text("Laki-laki"), value: "Laki-laki"),
                  DropdownMenuItem(
                      child: Text("Perempuan"), value: "Perempuan"),
                ],
                onChanged: (value) {
                  jenisKelaminController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon pilih Jenis Kelamin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tanggalLahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    tanggalLahirController.text =
                        pickedDate.toString().substring(0, 10);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Tanggal Lahir';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Email';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Kelas'),
                value: selectedKelas,
                items:
                    kelasList.map<DropdownMenuItem<String>>((kelas.Datum kls) {
                  return DropdownMenuItem<String>(
                    value: kls.idKelas,
                    child: Text(kls.kelas),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedKelas = value;
                  });
                  print('Selected Kelas: $selectedKelas');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon pilih Kelas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addSiswa();
                  }
                },
                child: Text('Tambah Siswa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
