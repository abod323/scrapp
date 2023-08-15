// To parse this JSON data, do
//
//     final ordersDetails = ordersDetailsFromJson(jsonString);

import 'dart:convert';

OrdersDetails ordersDetailsFromJson(Map<String,dynamic> str) => OrdersDetails.fromJson(str);

Map<String,dynamic> ordersDetailsToJson(OrdersDetails data) => data.toJson();

class OrdersDetails {
    bool status;
    Order order;
    User user;
    List<Product> products;
    ConfirmCart confirmCart;

    OrdersDetails({
        required this.status,
        required this.order,
        required this.user,
        required this.products,
        required this.confirmCart,
    });

    factory OrdersDetails.fromJson(Map<String, dynamic> json) => OrdersDetails(
        status: json["status"],
        order: Order.fromJson(json["order"]),
        user: User.fromJson(json["user"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        confirmCart: ConfirmCart.fromJson(json["confirm_cart"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "order": order.toJson(),
        "user": user.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "confirm_cart": confirmCart.toJson(),
    };
}

class ConfirmCart {
    int id;
    int userId;
    String totalPrice;
    DateTime updatedAt;
    DateTime createdAt;

    ConfirmCart({
        required this.id,
        required this.userId,
        required this.totalPrice,
        required this.updatedAt,
        required this.createdAt,
    });

    factory ConfirmCart.fromJson(Map<String, dynamic> json) => ConfirmCart(
        id: json["id"],
        userId: json["user_id"],
        totalPrice: json["total_price"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_price": totalPrice,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}

class Order {
    int id;
    int userId;
    int cartId;
    dynamic paymentMethod;
    int total;
    String status;
    DateTime updatedAt;
    DateTime createdAt;

    Order({
        required this.id,
        required this.userId,
        required this.cartId,
        this.paymentMethod,
        required this.total,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        cartId: json["cart_id"],
        paymentMethod: json["payment_method"],
        total: json["total"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "cart_id": cartId,
        "payment_method": paymentMethod,
        "total": total,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}

class Product {
    int id;
    String name;
    dynamic nameAr;
    dynamic nameUr;
    dynamic nameBn;
    String image;
    String description;
    dynamic descriptionAr;
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
        this.nameAr,
        this.nameUr,
        this.nameBn,
        required this.image,
        required this.description,
        this.descriptionAr,
        this.descriptionUr,
        this.descriptionBn,
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
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subcategoryId: json["subcategory_id"],
        categoryId: json["category_id"],
        quantity: json["quantity"],
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
    Customer customer;

    User({
        required this.id,
        required this.name,
        required this.email,
        this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.customer,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

    Customer({
        required this.id,
        required this.userId,
        required this.name,
        required this.phone,
        required this.address,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
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
