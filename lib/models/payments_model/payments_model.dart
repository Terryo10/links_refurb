// To parse this JSON data, do
//
//     final paynowResponseModel = paynowResponseModelFromJson(jsonString);

import 'dart:convert';

PaynowResponseModel paynowResponseModelFromJson(String str) => PaynowResponseModel.fromJson(json.decode(str));

String paynowResponseModelToJson(PaynowResponseModel data) => json.encode(data.toJson());

class PaynowResponseModel {
    PaynowResponseModel({
        this.success,
        this.message,
        this.order,
    });

    bool? success;
    String? message;
    Order? order;

    factory PaynowResponseModel.fromJson(Map<String, dynamic> json) => PaynowResponseModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        order: json["Order"] == null ? null : Order.fromJson(json["Order"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "Order": order == null ? null : order!.toJson(),
    };
}

class Order {
    Order({
        this.userId,
        this.paymentMethod,
        this.amount,
        this.pollUrl,
        this.status,
        this.phoneNumber,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int? userId;
    String? paymentMethod;
    int? amount;
    String? pollUrl;
    String? status;
    String? phoneNumber;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["user_id"] == null ? null : json["user_id"],
        paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
        amount: json["amount"] == null ? null : json["amount"],
        pollUrl: json["poll_url"] == null ? null : json["poll_url"],
        status: json["status"] == null ? null : json["status"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "amount": amount == null ? null : amount,
        "poll_url": pollUrl == null ? null : pollUrl,
        "status": status == null ? null : status,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
    };
}
