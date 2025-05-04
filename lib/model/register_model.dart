import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModeltoJson(RegisterModel data) =>
    json.encode(data.toJson());

/// Success Model
class RegisterModel {
  final int? id;
  final String? user;
  final String? phone;
  final String? email;

  RegisterModel({
    this.id,
    this.user,
    this.phone,
    this.email,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      RegisterModel(
        id: json["id"],
        user: json["user"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "phone": phone,
        "email": email,
      };
}

/// Error Model
class RegisterErrorModel {
  final Map<String, List<String>> errors;

  RegisterErrorModel({required this.errors});

  factory RegisterErrorModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> parsedErrors = {};
    json.forEach((key, value) {
      parsedErrors[key] = List<String>.from(value);
    });

    return RegisterErrorModel(errors: parsedErrors);
  }

  Map<String, dynamic> toJson() => errors;
}
