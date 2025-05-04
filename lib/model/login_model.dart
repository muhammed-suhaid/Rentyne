import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) =>
    json.encode(data.toJson());

class LoginModel {
  final int? id;
  final String? success;

  LoginModel({
    this.id,
    this.success,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "success": success,
      };
}

class LoginErrorModel {
  final String? error;

  LoginErrorModel({this.error});

  factory LoginErrorModel.fromJson(Map<String, dynamic> json) =>
      LoginErrorModel(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
