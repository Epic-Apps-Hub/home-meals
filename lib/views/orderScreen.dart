import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/models/cartItem.dart';
import 'package:home_made/repositories/hive.dart';
import 'package:home_made/views/addAdress.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Box priceAndQuantityBox;

  @override
  void initState() {
    priceAndQuantityBox = Hive.box("name");
    if (priceAndQuantityBox.get("totalPrice") == null) {
      priceAndQuantityBox.put("totalPrice", 0);
    }

    if (priceAndQuantityBox.get("quantity") == null) {
      priceAndQuantityBox.put("quantity", 0);
    }

    if (priceAndQuantityBox.get("resturant") == null) {
      priceAndQuantityBox.put("resturant", "");
    }

    if (priceAndQuantityBox.get("resturantName") == null) {
      priceAndQuantityBox.put("resturant", "");
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xffF1F1F4),
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(priceAndQuantityBox.get("resturantName"),
                    style: TextStyle(
                        fontFamily: 'tajwal',
                        color: Colors.black,
                        fontSize: 20,
                        letterSpacing: 1)),
              ),
            ),
            preferredSize: Size.fromHeight(20),
          ),
          title: Column(
            children: [
              Text(
                "السلة",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'tajwal',
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          brightness: Brightness.dark,
          backgroundColor: yellow, //Color(0xffd29760),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  width: _width,
                  height: _height * .08,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: _width * .07),
                          child: Text(
                            "العنصر",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'tajwal',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: _width * .40),
                          child: Text(
                            "الكمية",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'tajwal',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: _width * .13),
                          child: Text(
                            "السعر",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'tajwal',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    //    height: _height * .5,
                    width: _width,
                    child:

                        // ignore: deprecated_member_use
                        WatchBoxBuilder(
                      box: Hive.box<CartItem>("cartItems"),
                      builder: (ctx, box) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              int quant;

                              quant = box.getAt(index).quantity;

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5, top: 5),
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Column(
                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image(
                                                      image: CachedNetworkImageProvider(
                                                          'https://images.pexels.com/photos/2613471/pexels-photo-2613471.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                                                      height: 100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0),
                                                child: Container(
                                                  width: _width * .2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          box.getAt(index).name,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),

                                                      /*   Text(
                                                        'دأ ${box.getAt(index).price}',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 0),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (quant > 1) {
                                                                  var quantityy =
                                                                      priceAndQuantityBox
                                                                          .get(
                                                                              "quantity");
                                                                  priceAndQuantityBox.put(
                                                                      "quantity",
                                                                      quantityy - 1);
                                                                  var pricee =
                                                                      priceAndQuantityBox
                                                                          .get(
                                                                              "totalPrice");
                                                                  priceAndQuantityBox.put(
                                                                      "quantity",
                                                                      pricee -
                                                                          (box
                                                                              .getAt(
                                                                                  index)
                                                                              .price));
                                                                  setState(() {
                                                                    quant--;
                                                                  });
                                                                  box.putAt(
                                                                      index,
                                                                      CartItem(
                                                                          itemId: box
                                                                              .getAt(
                                                                                  index)
                                                                              .itemId,
                                                                          name: box
                                                                              .getAt(
                                                                                  index)
                                                                              .name,
                                                                          optionId: box
                                                                              .getAt(
                                                                                  index)
                                                                              .optionId,
                                                                          price: box
                                                                              .getAt(
                                                                                  index)
                                                                              .price,
                                                                          quantity:
                                                                              quant));
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    color: Colors.white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: quant > 1
                                                                        ? yellow
                                                                        : Colors.grey,
                                                                    border: Border.all(
                                                                        color:
                                                                            Colors.white,
                                                                        width: .4)),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              child: Center(
                                                                child: Text(
                                                                    quant.toString()),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors.grey,
                                                                      width: .4)),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                var quantityy =
                                                                    priceAndQuantityBox
                                                                        .get("quantity");
                                                                priceAndQuantityBox.put(
                                                                    "quantity",
                                                                    quantityy + 1);
                                                                var pricee =
                                                                    priceAndQuantityBox
                                                                        .get(
                                                                            "totalPrice");
                                                                priceAndQuantityBox.put(
                                                                    "totalPrice",
                                                                    pricee +
                                                                        box
                                                                            .getAt(index)
                                                                            .price);
                                                                setState(() {
                                                                  quant = quant + 1;
                                                                });
                                                                box.putAt(
                                                                    index,
                                                                    CartItem(
                                                                        itemId: box
                                                                            .getAt(index)
                                                                            .itemId,
                                                                        name: box
                                                                            .getAt(index)
                                                                            .name,
                                                                        optionId: box
                                                                            .getAt(index)
                                                                            .optionId,
                                                                        price: box
                                                                            .getAt(index)
                                                                            .price,
                                                                        quantity: quant));
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors.white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: yellow,
                                                                    border: Border.all(
                                                                        color: Colors.grey
                                                                            .withOpacity(
                                                                                .8),
                                                                        width: .4)),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                var decresedPrice = box
                                                                        .getAt(index)
                                                                        .price *
                                                                    box
                                                                        .getAt(index)
                                                                        .quantity;
                                                                var oldPrice =
                                                                    priceAndQuantityBox
                                                                        .get(
                                                                            "totalPrice");
                                                                priceAndQuantityBox.put(
                                                                    "totalPrice",
                                                                    (oldPrice -
                                                                        decresedPrice));
                                                                var oldQuant =
                                                                    priceAndQuantityBox
                                                                        .get("quantity");
                                                                var decresedQuant = box
                                                                    .getAt(index)
                                                                    .quantity;
                                                                priceAndQuantityBox.put(
                                                                    "quantity",
                                                                    (oldQuant -
                                                                        decresedQuant));
                                                                HiveRepo().deleteCartItem(
                                                                    index);

                                                                setState(() {});
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .only(
                                                                            left: 4.0,
                                                                            right: 4),
                                                                    child: Icon(
                                                                      FontAwesome5.trash,
                                                                      color: Colors.grey
                                                                          .withOpacity(
                                                                              .8),
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "حذف",
                                                                    style: TextStyle(
                                                                        color:
                                                                            Colors.grey),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                   */
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      var quantityy =
                                                          priceAndQuantityBox
                                                              .get("quantity");
                                                      priceAndQuantityBox.put(
                                                          "quantity",
                                                          quantityy + 1);
                                                      var pricee =
                                                          priceAndQuantityBox
                                                              .get(
                                                                  "totalPrice");
                                                      priceAndQuantityBox.put(
                                                          "totalPrice",
                                                          pricee +
                                                              box
                                                                  .getAt(index)
                                                                  .price);
                                                      setState(() {
                                                        quant = quant + 1;
                                                      });
                                                      box.putAt(
                                                          index,
                                                          CartItem(
                                                              itemId: box
                                                                  .getAt(index)
                                                                  .itemId,
                                                              name: box
                                                                  .getAt(index)
                                                                  .name,
                                                              optionId: box
                                                                  .getAt(index)
                                                                  .optionId,
                                                              price: box
                                                                  .getAt(index)
                                                                  .price,
                                                              quantity: quant));
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.green),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          FontAwesome5.plus,
                                                          color: Colors.green,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    quant.toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        //  fontFamily: 'tajwal',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (quant > 1) {
                                                        var quantityy =
                                                            priceAndQuantityBox
                                                                .get(
                                                                    "quantity");
                                                        priceAndQuantityBox.put(
                                                            "quantity",
                                                            quantityy - 1);
                                                        var pricee =
                                                            priceAndQuantityBox
                                                                .get(
                                                                    "totalPrice");
                                                        priceAndQuantityBox.put(
                                                            "quantity",
                                                            pricee -
                                                                (box
                                                                    .getAt(
                                                                        index)
                                                                    .price));
                                                        setState(() {
                                                          quant--;
                                                        });
                                                        box.putAt(
                                                            index,
                                                            CartItem(
                                                                itemId: box
                                                                    .getAt(
                                                                        index)
                                                                    .itemId,
                                                                name: box
                                                                    .getAt(
                                                                        index)
                                                                    .name,
                                                                optionId: box
                                                                    .getAt(
                                                                        index)
                                                                    .optionId,
                                                                price: box
                                                                    .getAt(
                                                                        index)
                                                                    .price,
                                                                quantity:
                                                                    quant));
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: quant > 1
                                                              ? Colors.green
                                                              : Colors.grey,
                                                        ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          FontAwesome5.minus,
                                                          color: quant > 1
                                                              ? Colors.green
                                                              : Colors.grey,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: _width * .1,
                                              ),
                                              Text(
                                                '${box.getAt(index).price}دأ ',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: 'tajwal',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      height: _height * .143,
                                      width: _width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          var decresedPrice =
                                              box.getAt(index).price *
                                                  box.getAt(index).quantity;
                                          var oldPrice = priceAndQuantityBox
                                              .get("totalPrice");
                                          priceAndQuantityBox.put("totalPrice",
                                              (oldPrice - decresedPrice));
                                          var oldQuant = priceAndQuantityBox
                                              .get("quantity");
                                          var decresedQuant =
                                              box.getAt(index).quantity;
                                          priceAndQuantityBox.put("quantity",
                                              (oldQuant - decresedQuant));
                                          HiveRepo().deleteCartItem(index);

                                          setState(() {});
                                        },
                                        child: Container(
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: box.length // box.toMap().length
                            );
                      },
                    )),
                SizedBox(
                  height: _height * .3,
                )
              ],
            ),
            Positioned(
              child: Container(
                height: _height * .28,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: _height * .2,
                        width: _width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "التكلفة",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontFamily: 'tajwal',
                                    ),
                                  ),
                                  Text(
                                    (priceAndQuantityBox.get("totalPrice"))
                                            .toString() +
                                        "دأ",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'tajwal',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الشحن",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontFamily: 'tajwal',
                                    ),
                                  ),
                                  Text(
                                    "10دأ",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'tajwal',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "كوبون",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontFamily: 'tajwal',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Alert(
                                          context: context,
                                          title: "ادخل كود الخصم",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "تم",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              color: yellow,
                                            )
                                          ],
                                          content: Center(
                                            child: TextField(),
                                          )).show();
                                    },
                                    child: Text(
                                      "تفعيل كود الخصم",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'tajwal',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الاجمالي",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontFamily: 'tajwal',
                                    ),
                                  ),
                                  Text(
                                    (priceAndQuantityBox.get("totalPrice") + 10)
                                            .toString() +
                                        "دأ",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'tajwal',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Container(
                        height: _height * .08,
                        width: _width,
                        child: Center(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  HiveRepo().deleteCartItems();
                                  setState(() {});
                                },
                                child: Container(
                                  width: _width * .4,
                                  color: Color(0xff333333),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          LineariconsFree.trash,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "افراغ السلة",
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 1.5,
                                              fontFamily: 'tajwal'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddAddress()));
                                },
                                child: Container(
                                  width: _width * .6,
                                  color: Color(0xffd29760),
                                  child: Center(
                                    child: Text(
                                      "اكمال الطلب",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'tajwal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottom: 0,
            )
          ],
        ));
  }
}
/*  */
