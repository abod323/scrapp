// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(Map<String,dynamic> map) => Orders.fromJson(map);

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
    bool status;
    List<Order> orders;
    User user;

    Orders({
        required this.status,
        required this.orders,
        required this.user,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        status: json["status"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "user": user.toJson(),
    };
}

class Order {
    int id;
    int userId;
    String paymentMethod;
    double total;
    String status;
    DateTime updatedAt;
    DateTime createdAt;
    String vehicleType;
    String products;

    Order({
        required this.id,
        required this.userId,
        required this.paymentMethod,
        required this.total,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.vehicleType,
        required this.products,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        total: json["total"]?.toDouble(),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        vehicleType: json["vehicle_type"],
        products: json["products"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "payment_method": paymentMethod,
        "total": total,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "vehicle_type": vehicleType,
        "products": products,
    };
}

class User {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    int isVerified;
    Customer customer;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.isVerified,
        required this.customer,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isVerified: json["is_verified"],
        customer: Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_verified": isVerified,
        "customer": customer.toJson(),
    };
}

class Customer {
    int id;
    int userId;
    String name;
    String phone;
    String address;
    String city;
    DateTime createdAt;
    DateTime updatedAt;
    String country;

    Customer({
        required this.id,
        required this.userId,
        required this.name,
        required this.phone,
        required this.address,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
        required this.country,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        country: json["country"],
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
        "country": country,
    };
}
