import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_made/models/cartItem.dart';
import 'package:home_made/repositories/hive.dart';
import 'package:home_made/views/orderScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';

class MealDetailsScreen extends StatefulWidget {
  final data;
  final double width;
  final double height;
  final String address;
  final String resturantId;
  final String resturantName;
  const MealDetailsScreen(
      {Key key,
      this.data,
      this.width,
      this.height,
      this.address,
      this.resturantId,
      this.resturantName})
      : super(key: key);
  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int count = 1;
  int price = 0;
  int indexx;
  bool isOtherResturant;
  Box priceAndQuantityBox;

  @override
  void initState() {
    priceAndQuantityBox = Hive.box("name");

    if (priceAndQuantityBox.get("resturant") == null) {
      priceAndQuantityBox.put("resturant", "");
    }

    if (priceAndQuantityBox.get("resturantName") == null) {
      priceAndQuantityBox.put("resturantName", "");
    }
    checkResturant();

    super.initState();
  }

  void checkResturant() {
    if (priceAndQuantityBox.get("resturant") == "") {
      setState(() {
        isOtherResturant = false;
      });
    }
    if (priceAndQuantityBox.get("resturant") != widget.resturantId &&
        priceAndQuantityBox.get("resturant") != "") {
      setState(() {
        isOtherResturant = true;
      });
    }
    if (priceAndQuantityBox.get("resturant") == widget.resturantId) {
      setState(() {
        isOtherResturant = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: Column(
          children: [
            Container(
              height: widget.height * .35,
              width: widget.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://images.pexels.com/photos/2613471/pexels-photo-2613471.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 9.0, top: 20),
                child: Text(
                  widget.data.itemName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'tajwal',
                      fontSize: 22),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 9.0, top: 10),
                child: Text(
                  widget.address,
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'tajwal', fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        child: Icon(
                          LineariconsFree.circle_minus,
                          color: count > 1 ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        count.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'tajwal',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: Icon(
                          LineariconsFree.plus_circle_1,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 9.0, top: 20),
                child: Text(
                  "الاختيارات المتاحة",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'tajwal',
                      fontSize: 22),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.data.options.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          indexx = index;
                        });
                        setState(() {
                          price = widget.data.options[index].price;
                        });
                      },
                      title: Text(widget.data.options[index].optionName),
                      trailing: Container(
                        width: widget.width * .25,
                        child: Row(
                          children: [
                            Radio(
                              groupValue: price,
                              value: widget.data.options[index].price,
                              onChanged: (val) {
                                setState(() {
                                  price = val;
                                });
                              },
                            ),
                            Text(widget.data.options[index].price.toString()),
                            Text("دأ")
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 20),
              child: WatchBoxBuilder(
                box: Hive.box<CartItem>("cartItems"),
                builder: (ctx, box) {
                  List<int> items = new List<int>();
                  for (var i = 0; i < box.length; i++) {
                    var item = box.getAt(i);

                    items.add(item.itemId);
                  }

                  bool isAdded = items.contains(widget.data.id);
                  print(isAdded);
                  return InkWell(
                    onTap: () {
                      checkResturant();

                      if (price != 0) {
                        if (isOtherResturant) {
                          Alert(
                              context: context,
                              title: "الغاء السلة الحالية؟",
                              desc:
                                  "لا يمكنك اضافة طلبات من اكثر من مطعم بنفس الوقت",
                              buttons: [
                                DialogButton(
                                    color: yellow,
                                    child: Text(
                                      "افرغ السلة",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      HiveRepo().deleteCartItems();
                                      Navigator.pop(context);
                                    })
                              ]).show();
                        } else {
                          if (!isAdded) {
                            HiveRepo().addToCart(CartItem(
                                itemId: widget.data.id,
                                name: widget.data.itemName,
                                optionId: indexx,
                                price: price,
                                quantity: count));
                            int quant = Hive.box("name").get("quantity");
                            Hive.box("name").put("quantity", count + quant);

                            int pricee = Hive.box("name").get("totalPrice");
                            Hive.box("name")
                                .put("totalPrice", (pricee + (price * count)));
                            Hive.box("name")
                                .put("resturant", widget.resturantId);
                            Hive.box("name")
                                .put("resturantName", widget.resturantName);
                            checkResturant();
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: OrdersScreen(),
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.bottomCenter));
                          }
                        }
                      } else {
                        Fluttertoast.showToast(msg: "اختر احد الاختيارات",backgroundColor: Color(0xff333333),textColor: Colors.white);
                      }

                      checkResturant();
                    },
                    child: !isAdded
                        ? Container(
                            height: 60,
                            width: widget.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "اضف الي السلة",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'tajwal',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20),
                                  ),
                                  Text((price * count).toString() + "دأ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'tajwal',
                                          fontSize: 22))
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: yellow,
                                borderRadius: BorderRadius.circular(12)),
                          )
                        : Container(
                            height: 60,
                            width: widget.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "مضافه الي السلة",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'tajwal',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: yellow,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
