// To parse this JSON data, do
//
//     final riwayatpinjambuku = riwayatpinjambukuFromJson(jsonString);

import 'dart:convert';

Riwayatpinjambuku riwayatpinjambukuFromJson(String str) =>
    Riwayatpinjambuku.fromJson(json.decode(str));

String riwayatpinjambukuToJson(Riwayatpinjambuku data) =>
    json.encode(data.toJson());

class Riwayatpinjambuku {
  String message;
  List<Datum> data;

  Riwayatpinjambuku({required this.message, required this.data});

  factory Riwayatpinjambuku.fromJson(Map<String, dynamic> json) =>
      Riwayatpinjambuku(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String userId;
  String bookId;
  DateTime borrowDate;
  dynamic returnDate;
  String createdAt;
  String updatedAt;
  Book book;

  Datum({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    bookId: json["book_id"],
    borrowDate: DateTime.parse(json["borrow_date"]),
    returnDate: json["return_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    book: Book.fromJson(json["book"]),
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
    "book": book.toJson(),
  };
}

class Book {
  int id;
  String title;
  String author;
  String stock;
  String createdAt;
  String updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
