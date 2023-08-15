// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(Map<String, dynamic> str) => Cart.fromJson(str);

Map<String, dynamic> cartToJson(Cart data) => data.toJson();

class Cart {
    bool status;
    List<CartElement> cart;
    int totalPrices;

    Cart({
        required this.status,
        required this.cart,
        required this.totalPrices,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        status: json["status"],
        cart: List<CartElement>.from(json["cart"].map((x) => CartElement.fromJson(x))),
        totalPrices: json["total_prices"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "total_prices": totalPrices,
    };
}

class CartElement {
    int id;
    int userId;
    int productId;
    DateTime updatedAt;
    DateTime createdAt;
    int quantity;
    int price;
    Product product;

    CartElement({
        required this.id,
        required this.userId,
        required this.productId,
        required this.updatedAt,
        required this.createdAt,
        required this.price,
        required this.quantity,
        required this.product,
    });

    factory CartElement.fromJson(Map<String, dynamic> json) => CartElement(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "quantity": quantity,
        "price": price,
        "product": product.toJson(),
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
    };
}
