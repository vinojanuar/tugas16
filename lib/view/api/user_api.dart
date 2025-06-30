import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas16/helper/preference.dart';
import 'package:tugas16/view/endpoint.dart';
import 'package:tugas16/view/model/berhasilgetbuku.dart';
import 'package:tugas16/view/model/delete.dart';
import 'package:tugas16/view/model/kembalikanbuku.dart';
import 'package:tugas16/view/model/login/login_responseberhasil.dart'; // ✅ tambahkan model login
import 'package:tugas16/view/model/login/login_responseeror.dart'; // ✅ tambahkan model error login
import 'package:tugas16/view/model/pinjambuku.dart';
import 'package:tugas16/view/model/postbuku.dart';
import 'package:tugas16/view/model/register/register_responseberhasil.dart';
import 'package:tugas16/view/model/register/register_responseror.dart';
import 'package:tugas16/view/model/riwayatpinjambuku.dart';

class UserService {
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoint.register),
      headers: {"Accept": "application/json"},
      body: {"name": name, "email": email, "password": password},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return registerBerhasilFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErorFromJson(response.body).toJson();
    } else {
      throw Exception("Gagal register: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoint.login),
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return loginBerhasilFromJson(response.body).toJson(); // ✅ ini model login
    } else if (response.statusCode == 422) {
      return loginErorFromJson(
        response.body,
      ).toJson(); // ✅ ini model login error
    } else {
      throw Exception("Gagal login: ${response.statusCode}");
    }
  }

  Future<List<GetBuku>> daftarbuku() async {
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
      print("Gagal ambil data buku: ${response.statusCode}");
      throw Exception("Gagal ambil data buku: ${response.statusCode}");
    }
  }

  Future<DataBuku> postbuku({
    required String title,
    required String author,
    required String stock,
  }) async {
    String? token = await PreferenceHandler.getToken();
    final response = await http.post(
      Uri.parse(Endpoint.postbuku),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {"title": title, "author": author, "stock": stock},
    );

    print("Response Buku: ${response.body}");

    if (response.statusCode == 200) {
      final hasil = postBukuFromJson(response.body);
      return hasil.data;
    } else {
      print("Gagal Post Buku: ${response.statusCode}");
      throw Exception("Gagal post buku: ${response.statusCode}");
    }
  }

  Future<PinjamBukuResponse> pinjamBuku({required int bookId}) async {
    final token = await PreferenceHandler.getToken();

    final response = await http.post(
      Uri.parse(Endpoint.pinjamBuku),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: jsonEncode({'book_id': bookId}),
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return pinjamBukuFromJson(response.body);
    } else {
      throw Exception('Gagal meminjam buku: ${response.body}');
    }
  }

  Future<Kembalikanbuku> kembalikanBuku({
    required int borrowId,
    required String returnDate,
    required int bookId,
  }) async {
    String? token = await PreferenceHandler.getToken();

    final response = await http.put(
      Uri.parse("${Endpoint.baseUrlApi}/return/$borrowId"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "book_id": bookId.toString(),
        "return_date": returnDate,
      }),
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return kembalikanbukuFromJson(response.body);
    } else {
      throw Exception("Gagal mengembalikan buku: ${response.body}");
    }
  }

  Future<Riwayatpinjambuku> getRiwayatPeminjaman() async {
    final token = await PreferenceHandler.getToken();

    final response = await http.get(
      Uri.parse('${Endpoint.riwayatpinjambuku}'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return riwayatpinjambukuFromJson(response.body);
    } else {
      throw Exception('Gagal mengambil riwayat peminjaman: ${response.body}');
    }
  }

  Future<Deletebuku> deleteBuku({required int id}) async {
    final token = await PreferenceHandler.getToken();

    final response = await http.delete(
      Uri.parse(
        '${Endpoint.baseUrlApi}/books/$id',
      ), // sesuaikan endpoint hapus buku
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return deletebukuFromJson(response.body);
    } else {
      throw Exception('Gagal menghapus buku: ${response.body}');
    }
  }
}
