import 'package:hive/hive.dart';
part 'cartItem.g.dart';

@HiveType(typeId:0)
class CartItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int price;

  @HiveField(2)
  int itemId;

  @HiveField(3)
  int optionId;

  @HiveField(4)
  int quantity;

CartItem({this.itemId,this.name,this.optionId,this.price,this.quantity});


}