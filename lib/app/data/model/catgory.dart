// To parse this JSON data, do
//
//     final catgories = catgoriesFromJson(jsonString);

import 'dart:convert';

List<Catgories> catgoriesFromJson(List<dynamic> str) => List<Catgories>.from(str.map((x) => Catgories.fromJson(x)));

String catgoriesToJson(List<Catgories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Catgories {
    int id;
    String nameEn;
    String image;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic subId;
    String nameAr;

    List<SubCatgory> subCatgories;

    Catgories({
        required this.id,
        required this.nameEn,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        this.subId,
        required this.nameAr,

        required this.subCatgories,
    });

    factory Catgories.fromJson(Map<String, dynamic> json) => Catgories(
        id: json["id"],
        nameEn: json["name"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subId: json["sub_id"],
        nameAr: json["name_ar"],
 
        subCatgories: //check null
            json["sub_catgories"] == null ? [] : List<SubCatgory>.from(json["sub_catgories"].map((x) => SubCatgory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sub_id": subId,
        "name_ar": nameAr,
        "sub_catgories": List<dynamic>.from(subCatgories.map((x) => x.toJson())),
    };
}

class SubCatgory {
    int id;
    String nameEn;
    int point;
    DateTime createdAt;
    DateTime updatedAt;
    int categoryId;
    String nameAr;


    SubCatgory({
        required this.id,
        required this.nameEn,
        required this.point,
        required this.createdAt,
        required this.updatedAt,
        required this.categoryId,
        required this.nameAr,
 
    });

    factory SubCatgory.fromJson(Map<String, dynamic> json) => SubCatgory(
        id: json["id"],
        nameEn: json["name"],
        point: json["point"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        nameAr: json["name_ar"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "point": point,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId,
        "name_ar": nameAr,
    
    };
}
