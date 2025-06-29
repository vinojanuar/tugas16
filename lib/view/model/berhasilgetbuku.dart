// To parse this JSON data, do
//
//     final berhasilGetBuku = berhasilGetBukuFromJson(jsonString);

import 'dart:convert';

BerhasilGetBuku berhasilGetBukuFromJson(String str) =>
    BerhasilGetBuku.fromJson(json.decode(str));

String berhasilGetBukuToJson(BerhasilGetBuku data) =>
    json.encode(data.toJson());

class BerhasilGetBuku {
  String message;
  List<GetBuku> data;

  BerhasilGetBuku({required this.message, required this.data});

  factory BerhasilGetBuku.fromJson(Map<String, dynamic> json) =>
      BerhasilGetBuku(
        message: json["message"],
        data: List<GetBuku>.from(json["data"].map((x) => GetBuku.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetBuku {
  int id;
  String title;
  String author;
  String stock;
  String createdAt;
  String updatedAt;

  GetBuku({
    required this.id,
    required this.title,
    required this.author,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetBuku.fromJson(Map<String, dynamic> json) => GetBuku(
    id: json["id"],
    title: json["title"],
    author: json["author"],
    stock: json["stock"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "author": author,
    "stock": stock,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
