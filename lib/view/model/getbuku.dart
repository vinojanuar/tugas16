// berhasilgetbuku.dart
class BerhasilGetBuku {
  List<GetBuku> data;

  BerhasilGetBuku({required this.data});

  factory BerhasilGetBuku.fromJson(Map<String, dynamic> json) =>
      BerhasilGetBuku(
        data: List<GetBuku>.from(json["data"].map((x) => GetBuku.fromJson(x))),
      );
}

class GetBuku {
  int id;
  String title;
  String author;
  int stock;

  GetBuku({
    required this.id,
    required this.title,
    required this.author,
    required this.stock,
  });

  factory GetBuku.fromJson(Map<String, dynamic> json) => GetBuku(
    id: json["id"],
    title: json["title"],
    author: json["author"],
    stock: json["stock"],
  );
}
