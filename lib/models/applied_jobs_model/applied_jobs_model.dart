// To parse this JSON data, do
//
//     final appliedJobsModel = appliedJobsModelFromJson(jsonString);

import 'dart:convert';

AppliedJobsModel appliedJobsModelFromJson(String str) => AppliedJobsModel.fromJson(json.decode(str));

String appliedJobsModelToJson(AppliedJobsModel data) => json.encode(data.toJson());

class AppliedJobsModel {
    AppliedJobsModel({
        this.success,
        this.applications,
    });

    bool? success;
    List<Application>? applications;

    factory AppliedJobsModel.fromJson(Map<String, dynamic> json) => AppliedJobsModel(
        success: json["success"] == null ? null : json["success"],
        applications: json["applications"] == null ? null : List<Application>.from(json["applications"].map((x) => Application.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "applications": applications == null ? null : List<dynamic>.from(applications!.map((x) => x.toJson())),
    };
}

class Application {
    Application({
        this.job,
    });

    Job? job;

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
    );

    Map<String, dynamic> toJson() => {
        "job": job == null ? null : job!.toJson(),
    };
}

class Job {
    Job({
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
    String?type;
    int? expertisesId;
    String? description;
    String? tasks;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"] == null ? null : json["id"],
        organisationId: json["organisation_id"] == null ? null : json["organisation_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        expertisesId: json["expertises_id"] == null ? null : json["expertises_id"],
        description: json["description"] == null ? null : json["description"],
        tasks: json["tasks"] == null ? null : json["tasks"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
