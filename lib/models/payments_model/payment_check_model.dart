// To parse this JSON data, do
//
//     final paymentCheckModel = paymentCheckModelFromJson(jsonString);

import 'dart:convert';

PaymentCheckModel paymentCheckModelFromJson(String str) =>
    PaymentCheckModel.fromJson(json.decode(str));

String paymentCheckModelToJson(PaymentCheckModel data) =>
    json.encode(data.toJson());

class PaymentCheckModel {
  PaymentCheckModel({
    this.success,
    this.status,
    this.order,
  });

  bool? success;
  String? status;
  Order? order;

  factory PaymentCheckModel.fromJson(Map<String, dynamic> json) =>
      PaymentCheckModel(
        success: json["success"] == null ? null : json["success"],
        status: json["status"] == null ? null : json["status"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "status": status == null ? null : status,
        "order": order == null ? null : order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.userId,
    this.amount,
    this.pollUrl,
    this.paymentMethod,
    this.phoneNumber,
    this.status,
    this.used,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? amount;
  String? pollUrl;
  String? paymentMethod;
  String? phoneNumber;
  String? status;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        amount: json["amount"] == null ? null : json["amount"],
        pollUrl: json["poll_url"] == null ? null : json["poll_url"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        status: json["status"] == null ? null : json["status"],
        used: json["used"] == null ? null : json["used"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "amount": amount == null ? null : amount,
        "poll_url": pollUrl == null ? null : pollUrl,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "status": status == null ? null : status,
        "used": used == null ? null : used,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
