// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
  });

  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.cvFile,
    this.profile,
    this.expertise,
    this.wishlist,
    this.appliedJobs,
    this.subscription,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  CvFile? cvFile;
  Profile? profile;
  Expertise? expertise;
  List<List<Wishlist>>? wishlist;
  List<CvFile>? appliedJobs;
  CvFile? subscription;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        cvFile:
            json["cv_file"] == null ? null : CvFile.fromJson(json["cv_file"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        expertise: json["expertise"] == null
            ? null
            : Expertise.fromJson(json["expertise"]),
        wishlist: json["wishlist"] == null
            ? null
            : List<List<Wishlist>>.from(json["wishlist"].map((x) =>
                List<Wishlist>.from(x.map((x) => Wishlist.fromJson(x))))),
        appliedJobs: json["applied_jobs"] == null
            ? null
            : List<CvFile>.from(
                json["applied_jobs"].map((x) => CvFile.fromJson(x))),
        subscription: json["subscription"] == null
            ? null
            : CvFile.fromJson(json["subscription"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "cv_file": cvFile == null ? null : cvFile!.toJson(),
        "profile": profile == null ? null : profile!.toJson(),
        "expertise": expertise == null ? null : expertise!.toJson(),
        "wishlist": wishlist == null
            ? null
            : List<dynamic>.from(wishlist!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "applied_jobs": appliedJobs == null
            ? null
            : List<dynamic>.from(appliedJobs!.map((x) => x.toJson())),
        "subscription": subscription == null ? null : subscription!.toJson(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class CvFile {
  CvFile({
    this.id,
    this.userId,
    this.jobId,
    this.createdAt,
    this.updatedAt,
    this.filePath,
    this.expiresAt,
  });

  int? id;
  int? userId;
  int? jobId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? filePath;
  DateTime? expiresAt;

  factory CvFile.fromJson(Map<String, dynamic> json) => CvFile(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        jobId: json["job_id"] == null ? null : json["job_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        filePath: json["file_path"] == null ? null : json["file_path"],
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "job_id": jobId == null ? null : jobId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "file_path": filePath == null ? null : filePath,
        "expires_at": expiresAt == null ? null : expiresAt!.toIso8601String(),
      };
}

class Expertise {
  Expertise({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Profile {
  Profile({
    this.id,
    this.phoneNumber,
    this.imagePath,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? phoneNumber;
  String? imagePath;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "image_path": imagePath == null ? null : imagePath,
        "user_id": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Wishlist {
  Wishlist({
    this.id,
    this.organisationId,
    this.name,
    this.type,
    this.expertisesId,
    this.description,
    this.tasks,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? organisationId;
  String? name;
  String? type;
  int? expertisesId;
  String? description;
  String? tasks;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"] == null ? null : json["id"],
        organisationId:
            json["organisation_id"] == null ? null : json["organisation_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        expertisesId:
            json["expertises_id"] == null ? null : json["expertises_id"],
        description: json["description"] == null ? null : json["description"],
        tasks: json["tasks"] == null ? null : json["tasks"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "organisation_id": organisationId == null ? null : organisationId,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "expertises_id": expertisesId == null ? null : expertisesId,
        "description": description == null ? null : description,
        "tasks": tasks == null ? null : tasks,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
