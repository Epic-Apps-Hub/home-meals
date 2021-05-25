// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
    Rating({
        this.data,
    });

    List<Datum> data;

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.kitchen,
        this.user,
        this.kitchenId,
        this.id,
        this.foodQuality,
        this.service,
        this.delivery,
        this.averageRating,
        this.titleOfReview,
        this.review,
        this.status,
        this.since,
    });

    Kitchenn kitchen;
    User user;
    int kitchenId;
    int id;
    int foodQuality;
    int service;
    int delivery;
    String averageRating;
    String titleOfReview;
    String review;
    dynamic status;
    String since;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kitchen: Kitchenn.fromJson(json["kitchen"]),
        user: User.fromJson(json["user"]),
        kitchenId: json["kitchen_id"],
        id: json["id"],
        foodQuality: json["food_quality"],
        service: json["service"],
        delivery: json["delivery"],
        averageRating: json["average_rating"],
        titleOfReview: json["title_of_review"],
        review: json["review"],
        status: json["status"],
        since: json["since"],
    );

    Map<String, dynamic> toJson() => {
        "kitchen": kitchen.toJson(),
        "user": user.toJson(),
        "kitchen_id": kitchenId,
        "id": id,
        "food_quality": foodQuality,
        "service": service,
        "delivery": delivery,
        "average_rating": averageRating,
        "title_of_review": titleOfReview,
        "review": review,
        "status": status,
        "since": since,
    };
}

class Kitchenn {
    Kitchenn({
        this.name,
        this.kitchenUrl,
    });

    String name;
    String kitchenUrl;

    factory Kitchenn.fromJson(Map<String, dynamic> json) => Kitchenn(
        name: json["name"],
        kitchenUrl: json["kitchen_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "kitchen_url": kitchenUrl,
    };
}

class User {
    User({
        this.name,
        this.email,
        this.phoneNumber,
    });

    String name;
    String email;
    String phoneNumber;

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
    };
}
