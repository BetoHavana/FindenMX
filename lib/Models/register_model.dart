import 'dart:convert';

class RegisterModel {
  RegisterModel({
    required this.user,
  });

  User user;

  factory RegisterModel.fromJson(String str) =>
      RegisterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
  });

  String name;
  String lastName;
  String email;
  DateTime updatedAt;
  DateTime createdAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}

class RegisterErrorsModel {
  RegisterErrorsModel({
    required this.errors,
  });

  Errors errors;

  factory RegisterErrorsModel.fromJson(String str) =>
      RegisterErrorsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterErrorsModel.fromMap(Map<String, dynamic> json) =>
      RegisterErrorsModel(
        errors: Errors.fromMap(json["errors"]),
      );

  Map<String, dynamic> toMap() => {
        "errors": errors.toMap(),
      };
}

class Errors {
  Errors({this.name, this.lastName, this.email, this.password});

  List<String>? name;
  List<String>? lastName;
  List<String>? email;
  List<String>? password;

  factory Errors.fromJson(String str) => Errors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Errors.fromMap(Map<String, dynamic> json) => Errors(
        name: json.containsKey("name")
            ? List<String>.from(json["name"].map((x) => x))
            : [],
        lastName: json.containsKey("last_name")
            ? List<String>.from(json["last_name"].map((x) => x))
            : [],
        email: json.containsKey("email")
            ? List<String>.from(json["email"].map((x) => x))
            : [],
        password: json.containsKey("password")
            ? List<String>.from(json["password"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "name": List<dynamic>.from(name!.map((x) => x)),
        "last_name": List<dynamic>.from(lastName!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "password": List<dynamic>.from(password!.map((x) => x)),
      };
}
