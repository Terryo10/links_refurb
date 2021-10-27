// To parse this JSON data, do
//
//     final expertiseListModel = expertiseListModelFromJson(jsonString);

import 'dart:convert';

ExpertiseListModel expertiseListModelFromJson(String str) =>
    ExpertiseListModel.fromJson(json.decode(str));

String expertiseListModelToJson(ExpertiseListModel data) =>
    json.encode(data.toJson());

class ExpertiseListModel {
  ExpertiseListModel({
    this.success,
    this.expertise,
  });

  bool? success;
  List<Expertise>? expertise;

  factory ExpertiseListModel.fromJson(Map<String, dynamic> json) =>
      ExpertiseListModel(
        success: json["success"] == null ? null : json["success"],
        expertise: json["expertise"] == null
            ? null
            : List<Expertise>.from(
                json["expertise"].map((x) => Expertise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "expertise": expertise == null
            ? null
            : List<dynamic>.from(expertise!.map((x) => x.toJson())),
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
