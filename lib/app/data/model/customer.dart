// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    bool status;
    String message;
    CustomerClass customer;

    Customer({
        required this.status,
        required this.message,
        required this.customer,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        status: json["status"],
        message: json["message"],
        customer: CustomerClass.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "customer": customer.toJson(),
    };
}

class CustomerClass {
    int id;
    int userId;
    String name;
    String phone;
    String address;
    String city;
    DateTime createdAt;
    DateTime updatedAt;

    CustomerClass({
        required this.id,
        required this.userId,
        required this.name,
        required this.phone,
        required this.address,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CustomerClass.fromJson(Map<String, dynamic> json) => CustomerClass(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
