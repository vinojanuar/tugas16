// To parse this JSON data, do
//
//     final pinjambuku = pinjambukuFromJson(jsonString);

import 'dart:convert';

Pinjambuku pinjambukuFromJson(String str) =>
    Pinjambuku.fromJson(json.decode(str));

String pinjambukuToJson(Pinjambuku data) => json.encode(data.toJson());

class Pinjambuku {
  String message;
  Datapinjambuku data;

  Pinjambuku({required this.message, required this.data});

  factory Pinjambuku.fromJson(Map<String, dynamic> json) => Pinjambuku(
    message: json["message"],
    data: Datapinjambuku.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Datapinjambuku {
  int userId;
  int bookId;
  String borrowDate;
  String updatedAt;
  String createdAt;
  int id;

  Datapinjambuku({
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Datapinjambuku.fromJson(Map<String, dynamic> json) => Datapinjambuku(
    userId: json["user_id"],
    bookId: json["book_id"],
    borrowDate: json["borrow_date"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "book_id": bookId,
    "borrow_date": borrowDate,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
