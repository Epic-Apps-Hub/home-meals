import 'package:dio/dio.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/models/cat.dart';
import 'package:home_made/models/rating.dart';
import 'package:home_made/models/specificKitchen.dart';

import '../constants.dart';

abstract class KitechensRepo {
  getAllKitchens();
  getSpecificKitchen(String slug);
  getSpecificKitchenRating(String id);
  getKitchenMenu(String slug);
}

class FetchAllKitchens extends KitechensRepo {
  @override
  getAllKitchens() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?page=1");
      print("items are   $items");
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('anything');
        res.data['data'].forEach((item) {
          print(item);
          items.add(Kitchen.fromJson(item));
        });
      }

      print('dsasadsd');

      return items;
    } catch (e) {
      print(e);
    }
  }

  @override
  getSpecificKitchen(String slug) async {
    try {
      SpecificKitchen kitchen;
      Response res = await Dio().post("$baseUrl/kitchen/$slug");
      if (res.statusCode == 200) {
        kitchen = SpecificKitchen.fromJson(res.data);
      }

      return kitchen;
    } catch (e) {
      print(e);
    }
  }

  @override
  getKitchenMenu(String slug) async {
    try {
      List<Cat> menu;
      Response res = await Dio().post("$baseUrl/getMenuCatItemsMob/$slug");
      if (res.statusCode == 200) {
        print(res.data);

        menu = catFromJson(res.data);
        //  menu = Cat.fromJson(res.data);
      }
      return menu;
    } catch (e) {
      print(e);
    }
  }

  @override
  getSpecificKitchenRating(String id) async {
    try {
      Rating rating;
      Response res = await Dio().post("$baseUrl/getCookReviews?kitchen=$id");

      if (res.statusCode == 200) {
        rating = Rating.fromJson(res.data);
      }
      return rating;
    } catch (e) {
      print(e);
    }
  }
}
