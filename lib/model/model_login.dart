// To parse this JSON data, do
//
//     final modellogin = modelloginFromJson(jsonString);

import 'dart:convert';

Modellogin modelloginFromJson(String str) => Modellogin.fromJson(json.decode(str));

String modelloginToJson(Modellogin data) => json.encode(data.toJson());

class Modellogin {
    int value;
    String message;
    String username;
    String email;
    String id;

    Modellogin({
        required this.value,
        required this.message,
        required this.username,
        required this.email,
        required this.id,
    });

    factory Modellogin.fromJson(Map<String, dynamic> json) => Modellogin(
        value: json["value"],
        message: json["message"],
        username: json["username"],
        email: json["email"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "username": username,
        "email": email,
        "id": id,
    };
}
