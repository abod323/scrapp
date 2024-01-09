// To parse this JSON data, do
//
//     final subcatgories = subcatgoriesFromJson(jsonString);

import 'dart:convert';

List<Subcatgories> subcatgoriesFromJson(List<dynamic> str) => List<Subcatgories>.from(str.map((x) => Subcatgories.fromJson(x)));

String subcatgoriesToJson(List<Subcatgories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcatgories {
    int id;
    String nameEn;
    int point;
    DateTime createdAt;
    DateTime updatedAt;
    int categoryId;
    String nameAr;
    String nameUrdo;
    String nameBang;

    Subcatgories({
        required this.id,
        required this.nameEn,
        required this.point,
        required this.createdAt,
        required this.updatedAt,
        required this.categoryId,
        required this.nameAr,
        required this.nameUrdo,
        required this.nameBang,
    });

    factory Subcatgories.fromJson(Map<String, dynamic> json) => Subcatgories(
        id: json["id"],
        nameEn: json["name"],
        point: json["point"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        nameAr: json["name_ar"],
        nameUrdo: json["name_ur"]??'',
        nameBang: json["name_bn"]??'',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameEn,
        "point": point,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId,
        "name_ar": nameAr,
        "name_ur": nameUrdo,
        "name_bn": nameBang,
    };
}
