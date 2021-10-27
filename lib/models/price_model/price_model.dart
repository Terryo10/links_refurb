// To parse this JSON data, do
//
//     final priceModel = priceModelFromJson(jsonString);

import 'dart:convert';

PriceModel priceModelFromJson(String str) => PriceModel.fromJson(json.decode(str));

String priceModelToJson(PriceModel data) => json.encode(data.toJson());

class PriceModel {
    PriceModel({
        this.success,
        this.price,
    });

    bool? success;
    Price? price;

    factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        success: json["success"] == null ? null : json["success"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "price": price == null ? null : price!.toJson(),
    };
}

class Price {
    Price({
        this.id,
        this.subscriptionPrice,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? subscriptionPrice;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"] == null ? null : json["id"],
        subscriptionPrice: json["subscription_price"] == null ? null : json["subscription_price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "subscription_price": subscriptionPrice == null ? null : subscriptionPrice,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
