import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas16/helper/preference.dart';
import 'package:tugas16/view/endpoint.dart';
import 'package:tugas16/view/model/berhasilgetbuku.dart';

class bookservice {
  // ✅ Fungsi Get Book dari API
  Future<List<GetBuku>> getBooks() async {
    String? token = await PreferenceHandler.getToken();

    final response = await http.get(
      Uri.parse(Endpoint.getBuku),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    print("Response Buku: ${response.body}");

    if (response.statusCode == 200) {
      final hasil = berhasilGetBukuFromJson(response.body);
      return hasil.data;
    } else {
      throw Exception("Gagal ambil data buku: ${response.statusCode}");
    }
  }
}
