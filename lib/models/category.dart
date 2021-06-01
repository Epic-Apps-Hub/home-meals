// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        this.data,
    });

    List<Datum> data;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.categoryName,
        this.slug,
        this.imagePath,
        this.lowPrice,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String categoryName;
    String slug;
    String imagePath;
    int lowPrice;
    dynamic createdAt;
    dynamic updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"],
        slug: json["slug"],
        imagePath: json["image_path"],
        lowPrice: json["low_price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "slug": slug,
        "image_path": imagePath,
        "low_price": lowPrice,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
