// To parse this JSON data, do
//
//     final appSettings = appSettingsFromJson(jsonString);

import 'dart:convert';

List<AppSettings> appSettingsFromJson(List<dynamic> str) => List<AppSettings>.from(str.map((x) => AppSettings.fromJson(x)));

String appSettingsToJson(List<AppSettings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppSettings {
    int id;
    String key;
    String value;
    dynamic createdAt;
    dynamic updatedAt;

    AppSettings({
        required this.id,
        required this.key,
        required this.value,
        required this.createdAt,
        required this.updatedAt,
    });

    factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
