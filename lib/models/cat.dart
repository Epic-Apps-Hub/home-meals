// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';

List<Cat> catFromJson(String str) => List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

String catToJson(List<Cat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cat {
    Cat({
        this.name,
        this.catId,
        this.slug,
        this.data,
    });

    String name;
    int catId;
    String slug;
    List<Datum> data;

    factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        name: json["name"],
        catId: json["cat_id"],
        slug: json["slug"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "cat_id": catId,
        "slug": slug,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.itemName,
        this.price,
        this.hasOptions,
        this.options,
    });

    int id;
    String itemName;
    int price;
    int hasOptions;
    List<Option> options;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
        hasOptions: json["has_options"],
        options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "has_options": hasOptions,
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class Option {
    Option({
        this.id,
        this.optionName,
        this.price,
        this.itemId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String optionName;
    int price;
    int itemId;
    dynamic createdAt;
    dynamic updatedAt;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionName: json["option_name"],
        price: json["price"],
        itemId: json["item_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "option_name": optionName,
        "price": price,
        "item_id": itemId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
