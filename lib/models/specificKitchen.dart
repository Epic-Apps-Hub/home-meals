// To parse this JSON data, do
//
//     final specificKitchen = specificKitchenFromJson(jsonString);

import 'dart:convert';

SpecificKitchen specificKitchenFromJson(String str) => SpecificKitchen.fromJson(json.decode(str));

String specificKitchenToJson(SpecificKitchen data) => json.encode(data.toJson());

class SpecificKitchen {
    SpecificKitchen({
        this.data,
        this.reviews,
    });

    Data data;
    Reviews reviews;

    factory SpecificKitchen.fromJson(Map<String, dynamic> json) => SpecificKitchen(
        data: Data.fromJson(json["data"]),
        reviews: Reviews.fromJson(json["reviews"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "reviews": reviews.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.slug,
        this.picturePath,
        this.categoryId,
        this.catSlug,
        this.catName,
        this.userId,
        this.deliveryTo,
        this.address,
        this.discount,
        this.averagePrice,
        this.workFrom,
        this.workTill,
        this.workFromTime,
        this.workTillTime,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.city,
        this.cityId,
        this.visible,
        this.closed,
        this.alwaysOpen,
        this.betweenHours,
        this.isOpen,
    });

    int id;
    String name;
    String slug;
    String picturePath;
    int categoryId;
    String catSlug;
    String catName;
    int userId;
    String deliveryTo;
    String address;
    int discount;
    int averagePrice;
    String workFrom;
    String workTill;
    int workFromTime;
    int workTillTime;
    String description;
    dynamic createdAt;
    dynamic updatedAt;
    City city;
    int cityId;
    int visible;
    int closed;
    int alwaysOpen;
    bool betweenHours;
    bool isOpen;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        picturePath: json["picture_path"],
        categoryId: json["category_id"],
        catSlug: json["cat_slug"],
        catName: json["cat_name"],
        userId: json["user_id"],
        deliveryTo: json["delivery_to"],
        address: json["address"],
        discount: json["discount"],
        averagePrice: json["average_price"],
        workFrom: json["work_from"],
        workTill: json["work_till"],
        workFromTime: json["work_from_time"],
        workTillTime: json["work_till_time"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        city: City.fromJson(json["city"]),
        cityId: json["city_id"],
        visible: json["visible"],
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
        "category_id": categoryId,
        "cat_slug": catSlug,
        "cat_name": catName,
        "user_id": userId,
        "delivery_to": deliveryTo,
        "address": address,
        "discount": discount,
        "average_price": averagePrice,
        "work_from": workFrom,
        "work_till": workTill,
        "work_from_time": workFromTime,
        "work_till_time": workTillTime,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "city": city.toJson(),
        "city_id": cityId,
        "visible": visible,
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

class Reviews {
    Reviews({
        this.foodQuality,
        this.service,
        this.delivery,
        this.total,
        this.count,
    });

    String foodQuality;
    String service;
    String delivery;
    String total;
    int count;

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        foodQuality: json["food_quality"],
        service: json["service"],
        delivery: json["delivery"],
        total: json["total"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "food_quality": foodQuality,
        "service": service,
        "delivery": delivery,
        "total": total,
        "count": count,
    };
}
