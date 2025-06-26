// To parse this JSON data, do
//
//     final responsEror = registerErorFromJson(jsonString);

import 'dart:convert';

ResponsEror registerErorFromJson(String str) =>
    ResponsEror.fromJson(json.decode(str));

String responsErorToJson(ResponsEror data) => json.encode(data.toJson());

class ResponsEror {
  String? message;
  Errors? errors;

  ResponsEror({this.message, this.errors});

  factory ResponsEror.fromJson(Map<String, dynamic> json) => ResponsEror(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? email;

  Errors({this.email});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: json["email"] == null
        ? []
        : List<String>.from(json["email"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
  };
}
