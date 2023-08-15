// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(List<dynamic> str) => List<Products>.from(str.map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    int id;
    String titleEn;
    String descriptionEn;
    String image;
    String price;
    int categoryId;
    String? titleAr;
    String? titleUrdo;
    String? titleBang;
    String? descriptionAr;
    String? descriptionUrdo;
    String? descriptionBang;
    String publish;
    DateTime createdAt;
    DateTime updatedAt;

    Products({
        required this.id,
        required this.titleEn,
        required this.descriptionEn,
        required this.image,
        required this.price,
        required this.categoryId,
        this.titleAr,
        this.titleUrdo,
        this.titleBang,
        this.descriptionAr,
        this.descriptionUrdo,
        this.descriptionBang,
        required this.publish,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        titleEn: json["name"],
        descriptionEn: json["description"],
        image: json["image"],
        price: json["price"],
        categoryId: json["category_id"],
        titleAr: json["name_ar"]??json["name"],
        titleUrdo: json["name_ur"]??json["name"],
        titleBang: json["name_bn"]??json["name"],
        descriptionAr: json["description_ar"]??json["description"],
        descriptionUrdo: json["description_ur"]??json["description"],
        descriptionBang: json["description_bn"]??json["description"],
        publish: json["publish"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": titleEn,
        "description": descriptionEn,
        "image": image,
        "price": price,
        "category_id": categoryId,
        "name_ar": titleAr,
        "name_ur": titleUrdo,
        "name_bn": titleBang,
        "description_ar": descriptionAr,
        "description_ur": descriptionUrdo,
        "description_bn": descriptionBang,
        "publish": publish,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
