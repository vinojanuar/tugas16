class Endpoint {
  static const String baseUrl = "https://appperpus.mobileprojp.com";
  static const String baseUrlApi = "$baseUrl/api";
  static const String register = "$baseUrl/api/register";
  static const String login = "$baseUrl/api/login";
  static const String getBuku = "$baseUrlApi/books";
  static const String postbuku = "$baseUrlApi/books";
  static const String pinjamBuku = "$baseUrlApi/borrow";
  static const String kembalikanbuku = "$baseUrlApi/return/borrow";
  static const String riwayatpinjambuku = "$baseUrlApi/history";
  static const String deletebuku = "$baseUrlApi/books/borrow";
}
