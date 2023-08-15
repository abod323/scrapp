// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
    SettingsClass settings;

    Settings({
        required this.settings,
    });

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        settings: SettingsClass.fromJson(json["settings"]),
    );

    Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
    };
}

class SettingsClass {
    int id;
    int maxOrderPrice;
    int minOrderPrice;

    SettingsClass({
        required this.id,
        required this.maxOrderPrice,
        required this.minOrderPrice,
    });

    factory SettingsClass.fromJson(Map<String, dynamic> json) => SettingsClass(
        id: json["id"],
        maxOrderPrice: json["max_order_price"],
        minOrderPrice: json["min_order_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "max_order_price": maxOrderPrice,
        "min_order_price": minOrderPrice,
    };
}
