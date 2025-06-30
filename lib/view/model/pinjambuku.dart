import 'dart:convert';

PinjamBukuResponse pinjamBukuFromJson(String str) =>
    PinjamBukuResponse.fromJson(json.decode(str));

String pinjamBukuToJson(PinjamBukuResponse data) => json.encode(data.toJson());

class PinjamBukuResponse {
  final String message;
  final DataPinjamBuku data;

  PinjamBukuResponse({required this.message, required this.data});

  factory PinjamBukuResponse.fromJson(Map<String, dynamic> json) =>
      PinjamBukuResponse(
        message: json["message"],
        data: DataPinjamBuku.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class DataPinjamBuku {
  final int userId;
  final int bookId;
  final String borrowDate;
  final String updatedAt;
  final String createdAt;
  final int id;

  DataPinjamBuku({
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DataPinjamBuku.fromJson(Map<String, dynamic> json) => DataPinjamBuku(
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
