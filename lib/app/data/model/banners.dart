// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'dart:convert';

Banners bannersFromJson(Map<String,dynamic> str) => Banners.fromJson(str);

String bannersToJson(Banners data) => json.encode(data.toJson());

class Banners {

    List<Banner> banners;

    Banners({
   
        required this.banners,
    });

    factory Banners.fromJson(Map<String, dynamic> json) => Banners(
   
        banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {

        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    };
}

class Banner {
    int id;
    String image;

    DateTime createdAt;
    DateTime updatedAt;

    Banner({
        required this.id,
        required this.image,
     
        required this.createdAt,
        required this.updatedAt,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
    
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
