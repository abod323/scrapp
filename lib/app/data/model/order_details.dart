// To parse this JSON data, do
//
//     final ordersDetails = ordersDetailsFromJson(jsonString);

import 'dart:convert';

OrdersDetails ordersDetailsFromJson(Map<String,dynamic> str) => OrdersDetails.fromJson(str);

String ordersDetailsToJson(OrdersDetails data) => json.encode(data.toJson());

class OrdersDetails {
    bool status;
    Order order;
    User user;
    List<Product> products;

    OrdersDetails({
        required this.status,
        required this.order,
        required this.user,
        required this.products,
    });

    factory OrdersDetails.fromJson(Map<String, dynamic> json) => OrdersDetails(
        status: json["status"],
        order: Order.fromJson(json["order"]),
        user: User.fromJson(json["user"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "order": order.toJson(),
        "user": user.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Order {
    int id;
    int userId;
    String paymentMethod;
    double total;
    String status;
    String address;
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
        required this.address,
        required this.updatedAt,
        required this.createdAt,
        required this.vehicleType,
        required this.products,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: int.parse(json["user_id"].toString()),
        paymentMethod: json["payment_method"],
        total: double.parse(json["total"].toString()),
        status: json["status"],
        address: json["address"]??'',
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
        'address':address,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "vehicle_type": vehicleType,
        "products": products,
    };
}

class Product {
    int id;
    String name;
    String nameAr;
    dynamic nameUr;
    dynamic nameBn;
    String image;
    String description;
    String descriptionAr;
    dynamic descriptionUr;
    dynamic descriptionBn;
    String price;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    int subcategoryId;
    int categoryId;
    int quantity;

    Product({
        required this.id,
        required this.name,
        required this.nameAr,
        required this.nameUr,
        required this.nameBn,
        required this.image,
        required this.description,
        required this.descriptionAr,
        required this.descriptionUr,
        required this.descriptionBn,
        required this.price,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.subcategoryId,
        required this.categoryId,
        required this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        nameAr: json["name_ar"],
        nameUr: json["name_ur"],
        nameBn: json["name_bn"],
        image: json["image"],
        description: json["description"],
        descriptionAr: json["description_ar"],
        descriptionUr: json["description_ur"],
        descriptionBn: json["description_bn"],
        price: json["price"],
        status: int.parse(json["status"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subcategoryId: int.parse(json["subcategory_id"].toString()),
        categoryId: int.parse(json["category_id"].toString()),
        quantity:int.parse(json["quantity"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "name_ur": nameUr,
        "name_bn": nameBn,
        "image": image,
        "description": description,
        "description_ar": descriptionAr,
        "description_ur": descriptionUr,
        "description_bn": descriptionBn,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subcategory_id": subcategoryId,
        "category_id": categoryId,
        "quantity": quantity,
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
        isVerified: int.parse(json["is_verified"].toString()),
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
        userId: int.parse(json["user_id"].toString()),
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
