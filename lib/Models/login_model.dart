import 'dart:convert';

class LoginModel {
  LoginModel({
    this.token,
    this.tokenType,
    this.expiresIn,
    this.message
  });

  String? token;
  String? tokenType;
  int? expiresIn;
  String ? message;

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        token: json["token"] == null ? null : json["token"],
        tokenType: json["token_type"]== null ? null : json["token_type"],
        expiresIn: json["expires_in"]== null ? null : json["expires_in"],
        message: json["message"]== null ? null : json["message"]
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "message":message
      };
}
