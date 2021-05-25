// To parse this JSON data, do
//
//     final kitchen = kitchenFromJson(jsonString);

import 'dart:convert';

List<Kitchen> kitchenFromJson(String str) => List<Kitchen>.from(json.decode(str).map((x) => Kitchen.fromJson(x)));

String kitchenToJson(List<Kitchen> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kitchen {
    Kitchen({
        this.id,
        this.name,
        this.slug,
        this.picturePath,
        this.category,
        this.averagePrice,
        this.averageRating,
        this.address,
        this.discount,
        this.city,
        this.visible,
        this.workFrom,
        this.workTill,
        this.closed,
        this.alwaysOpen,
        this.betweenHours,
        this.isOpen,
    });

    int id;
    String name;
    String slug;
    String picturePath;
    String category;
    int averagePrice;
    double averageRating;
    String address;
    int discount;
    City city;
    int visible;
    String workFrom;
    String workTill;
    int closed;
    int alwaysOpen;
    bool betweenHours;
    bool isOpen;

    factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        picturePath: json["picture_path"],
        category: json["category"],
        averagePrice: json["average_price"],
        averageRating: json["average_rating"].toDouble(),
        address: json["address"],
        discount: json["discount"] == null ? null : json["discount"],
        city: City.fromJson(json["city"]),
        visible: json["visible"],
        workFrom: json["work_from"],
        workTill: json["work_till"],
        closed: json["closed"],
        alwaysOpen: json["always_open"],
        betweenHours: json["between_hours"],
        isOpen: json["is_open"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "picture_path": picturePath,
        "category": category,
        "average_price": averagePrice,
        "average_rating": averageRating,
        "address": address,
        "discount": discount == null ? null : discount,
        "city": city.toJson(),
        "visible": visible,
        "work_from": workFrom,
        "work_till": workTill,
        "closed": closed,
        "always_open": alwaysOpen,
        "between_hours": betweenHours,
        "is_open": isOpen,
    };
}

class City {
    City({
        this.id,
        this.cityName,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String cityName;
    String slug;
    DateTime createdAt;
    DateTime updatedAt;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        cityName: json["city_name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
