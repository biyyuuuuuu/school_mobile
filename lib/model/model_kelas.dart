// To parse this JSON data, do
//
//     final modelKelas = modelKelasFromJson(jsonString);

import 'dart:convert';

ModelKelas modelKelasFromJson(String str) => ModelKelas.fromJson(json.decode(str));

String modelKelasToJson(ModelKelas data) => json.encode(data.toJson());

class ModelKelas {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelKelas({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelKelas.fromJson(Map<String, dynamic> json) => ModelKelas(
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
    String idKelas;
    String kelas;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.idKelas,
        required this.kelas,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idKelas: json["id_kelas"],
        kelas: json["kelas"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kelas": kelas,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
