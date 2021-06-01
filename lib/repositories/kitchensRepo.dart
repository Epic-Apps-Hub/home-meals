import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_made/models/category.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/models/cat.dart';
import 'package:home_made/models/rating.dart';
import 'package:home_made/models/specificKitchen.dart';

import '../constants.dart';

abstract class KitechensRepo {
  getAllKitchens();
  getNewKitchens();
  getNearKitchens();
  getPopularKitchens();
  getDessert();
  getDiscount();
  getSpecificKitchen(String slug);
  getSpecificKitchenRating(String id);
  getKitchenMenu(String slug);
  getCategories();
}

class FetchAllKitchens extends KitechensRepo {
  @override
  getNewKitchens() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?type=new");
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
      EasyLoading.show();

      SpecificKitchen kitchen;
      Response res =
          await Dio().post("https://homemeals.ae/api/mobile/kitchen/$slug");
      print(res.realUri);
      if (res.statusCode == 200) {
        kitchen = SpecificKitchen.fromJson(res.data);
      }
      EasyLoading.dismiss();

      return kitchen;
    } catch (e) {
      EasyLoading.dismiss();

      print(e);
    }
  }

  @override
  getKitchenMenu(String slug) async {
    try {
      List<Cat> menu;
      Response res = await Dio()
          .post("https://www.homemeals.ae/api/mobile/getMenuCatItemsMob/$slug");
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
      Response res = await Dio()
          .post("https://homemeals.ae/api/mobile/getCookReviews?kitchen=$id");

      if (res.statusCode == 200) {
        rating = Rating.fromJson(res.data);
      }
      return rating;
    } catch (e) {
      print(e);
    }
  }

  @override
  getCategories() async {
    try {
      Category category;
      Response res = await Dio()
          .post("https://www.homemeals.ae/api/mobile/getKitchenCategories");
      if (res.statusCode == 200) {
        category = Category.fromJson(res.data);
      }

      return category;
    } catch (e) {
      print(e);
    }
  }

  @override
  getDessert() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?type=dessert");
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
  getDiscount() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?type=discount");
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
  getNearKitchens() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?type=near");
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
  getPopularKitchens() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens?type=popular");
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
  getAllKitchens() async {
    try {
      List<Kitchen> items = [];

      Response res = await Dio().post("$baseUrl/kitchens");
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
}
