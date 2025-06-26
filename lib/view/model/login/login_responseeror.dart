// To parse this JSON data, do
//
//     final loginEror = loginErorFromJson(jsonString);

import 'dart:convert';

LoginEror loginErorFromJson(String str) => LoginEror.fromJson(json.decode(str));

String loginErorToJson(LoginEror data) => json.encode(data.toJson());

class LoginEror {
  String? message;
  dynamic data;

  LoginEror({this.message, this.data});

  factory LoginEror.fromJson(Map<String, dynamic> json) =>
      LoginEror(message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}
