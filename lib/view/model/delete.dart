// To parse this JSON data, do
//
//     final deletebuku = deletebukuFromJson(jsonString);

import 'dart:convert';

Deletebuku deletebukuFromJson(String str) =>
    Deletebuku.fromJson(json.decode(str));

String deletebukuToJson(Deletebuku data) => json.encode(data.toJson());

class Deletebuku {
  String message;
  dynamic data;

  Deletebuku({required this.message, required this.data});

  factory Deletebuku.fromJson(Map<String, dynamic> json) =>
      Deletebuku(message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}
