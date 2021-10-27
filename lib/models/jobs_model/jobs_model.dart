// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

JobsModel jobsModelFromJson(String str) => JobsModel.fromJson(json.decode(str));

String jobsModelToJson(JobsModel data) => json.encode(data.toJson());

class JobsModel {
    JobsModel({
        this.success,
        this.jobs,
    });

    bool? success;
    List<Job>? jobs;

    factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
        success: json["success"] == null ? null : json["success"],
        jobs: json["jobs"] == null ? null : List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "jobs": jobs == null ? null : List<dynamic>.from(jobs!.map((x) => x.toJson())),
    };
}

class Job {
    Job({
        this.id,
        this.name,
        this.type,
        this.expertise,
        this.organisation,
        this.description,
        this.tasks,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? type;
    Expertise? expertise;
    Organisation? organisation;
    String? description;
    String? tasks;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        expertise: json["expertise"] == null ? null : Expertise.fromJson(json["expertise"]),
        organisation: json["organisation"] == null ? null : Organisation.fromJson(json["organisation"]),
        description: json["description"] == null ? null : json["description"],
        tasks: json["tasks"] == null ? null : json["tasks"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "expertise": expertise == null ? null : expertise!.toJson(),
        "organisation": organisation == null ? null : organisation!.toJson(),
        "description": description == null ? null : description,
        "tasks": tasks == null ? null : tasks,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}

class Organisation {
    Organisation({
        this.id,
        this.name,
        this.location,
        this.imagePath,
        this.numberOfEmployees,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? location;
    String? imagePath;
    String? numberOfEmployees;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        location: json["Location"] == null ? null : json["Location"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        numberOfEmployees: json["number_of_employees"] == null ? null : json["number_of_employees"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "Location": location == null ? null : location,
        "image_path": imagePath == null ? null : imagePath,
        "number_of_employees": numberOfEmployees == null ? null : numberOfEmployees,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
