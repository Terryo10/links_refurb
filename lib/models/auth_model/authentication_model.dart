// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) => AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) => json.encode(data.toJson());

class AuthenticationModel {
    AuthenticationModel({
        this.user,
        this.token,
        this.success,
        this.message,
    });

    User? user ;
    String? token;
    bool? success;
    String? message;

    factory AuthenticationModel.fromJson(Map<String, dynamic> json) => AuthenticationModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"] == null ? null : json["token"],
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "token": token == null ? null : token,
        "success": success == null ? null : success,
        "message": message == null ? null : message,
    };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? email;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
