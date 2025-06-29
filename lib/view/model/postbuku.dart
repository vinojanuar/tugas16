// To parse this JSON data, do
//
//     final postBuku = postBukuFromJson(jsonString);

import 'dart:convert';

PostBuku postBukuFromJson(String str) => PostBuku.fromJson(json.decode(str));

String postBukuToJson(PostBuku data) => json.encode(data.toJson());

class PostBuku {
  String message;
  DataBuku data;

  PostBuku({required this.message, required this.data});

  factory PostBuku.fromJson(Map<String, dynamic> json) =>
      PostBuku(message: json["message"], data: DataBuku.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class DataBuku {
  String title;
  String author;
  int stock;
  String updatedAt;
  String createdAt;
  int id;

  DataBuku({
    required this.title,
    required this.author,
    required this.stock,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DataBuku.fromJson(Map<String, dynamic> json) => DataBuku(
    title: json["title"],
    author: json["author"],
    stock: int.parse(json["stock"].toString()),
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "stock": stock,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
