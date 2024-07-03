// To parse this JSON data, do
//
//     final modelSiswa = modelSiswaFromJson(jsonString);

import 'dart:convert';

ModelSiswa modelSiswaFromJson(String str) => ModelSiswa.fromJson(json.decode(str));

String modelSiswaToJson(ModelSiswa data) => json.encode(data.toJson());

class ModelSiswa {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelSiswa({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelSiswa.fromJson(Map<String, dynamic> json) => ModelSiswa(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String idSiswa;
    String nis;
    String nama;
    String alamat;
    String jenisKelamin;
    DateTime tanggalLahir;
    String email;
    String idKelas;
    DateTime createdAt;
    DateTime updatedAt;
    String kelas;

    Datum({
        required this.idSiswa,
        required this.nis,
        required this.nama,
        required this.alamat,
        required this.jenisKelamin,
        required this.tanggalLahir,
        required this.email,
        required this.idKelas,
        required this.createdAt,
        required this.updatedAt,
        required this.kelas,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idSiswa: json["id_siswa"],
        nis: json["nis"],
        nama: json["nama"],
        alamat: json["alamat"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        email: json["email"],
        idKelas: json["id_kelas"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        kelas: json["kelas"],
    );

    Map<String, dynamic> toJson() => {
        "id_siswa": idSiswa,
        "nis": nis,
        "nama": nama,
        "alamat": alamat,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
        "email": email,
        "id_kelas": idKelas,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "kelas": kelas,
    };
}
