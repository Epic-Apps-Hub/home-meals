import 'package:hive/hive.dart';
import '../models/cartItem.dart';

class HiveRepo {
  Future<void> addToCart(CartItem product) async {
    var box = Hive.box<CartItem>('cartItems');

    box.add(product);
  }

  Future<void> deleteCartItem(int index) async {
    var box = Hive.box<CartItem>('cartItems');

    box.deleteAt(index);
  }

  Future<void> deleteCartItems() async {
    var box = Hive.box<CartItem>('cartItems');

    box.clear();

    Hive.box("name").put("quantity", 0);

    Hive.box("name").put("totalPrice", (0));

    Hive.box("name").put("resturant", "");
        Hive.box("name").put("resturantName", "");

  }

  Future<void> updateCount(int index, CartItem product, count) async {
    var box = Hive.box<CartItem>('cartItems');

    box.putAt(index, product);
  }
}
