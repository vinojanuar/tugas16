import 'package:http/http.dart' as http;
import 'package:tugas16/view/endpoint.dart';
import 'package:tugas16/view/model/login/login_responseberhasil.dart'; // ✅ tambahkan model login
import 'package:tugas16/view/model/login/login_responseeror.dart'; // ✅ tambahkan model error login
import 'package:tugas16/view/model/register/register_responseberhasil.dart';
import 'package:tugas16/view/model/register/register_responseror.dart';

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
}
