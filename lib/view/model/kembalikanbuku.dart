// To parse this JSON data, do
//
//     final kembalikanbuku = kembalikanbukuFromJson(jsonString);

import 'dart:convert';

Kembalikanbuku kembalikanbukuFromJson(String str) =>
    Kembalikanbuku.fromJson(json.decode(str));

String kembalikanbukuToJson(Kembalikanbuku data) => json.encode(data.toJson());

class Kembalikanbuku {
  String message;
  databalikbuku data;

  Kembalikanbuku({required this.message, required this.data});

  factory Kembalikanbuku.fromJson(Map<String, dynamic> json) => Kembalikanbuku(
    message: json["message"],
    data: databalikbuku.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class databalikbuku {
  int id;
  String userId;
  String bookId;
  DateTime borrowDate;
  String returnDate;
  String createdAt;
  String updatedAt;

  databalikbuku({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory databalikbuku.fromJson(Map<String, dynamic> json) => databalikbuku(
    id: json["id"],
    userId: json["user_id"],
    bookId: json["book_id"],
    borrowDate: DateTime.parse(json["borrow_date"]),
    returnDate: json["return_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "book_id": bookId,
    "borrow_date":
        "${borrowDate.year.toString().padLeft(4, '0')}-${borrowDate.month.toString().padLeft(2, '0')}-${borrowDate.day.toString().padLeft(2, '0')}",
    "return_date": returnDate,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
