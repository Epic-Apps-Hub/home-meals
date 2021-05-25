import 'package:animate_do/animate_do.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:hive/hive.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/meals.dart';
import 'package:home_made/views/offers.dart';
import 'package:home_made/views/orderScreen.dart';
import 'package:home_made/views/ourKitchens.dart';
import 'package:home_made/views/searchPage.dart';
import 'package:home_made/views/widgets/drawer.dart';
import 'package:home_made/views/widgets/kitchen.dart';
import 'package:home_made/views/widgets/mealOffer.dart';
import 'package:home_made/views/widgets/ourMeals.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Hive.openBox("orderItems");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: yellow,
        title: FadeInDownBig(
          child: Text(
            "الرئيسية",
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'tajwal',
                fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          FadeInRight(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: IconButton(
                    hoverColor: Colors.white,
                    icon: Icon(
                      Typicons.basket,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: OrdersScreen(),
                              type: PageTransitionType.fade));
                    }),
              ),
            ),
          )
        ],
        leading: FadeInLeft(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                icon: Icon(
                  MfgLabs.menu,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                }),
          ),
        ),
      ),
      key: scaffoldKey,
      drawer: drawer(_width, _height, context),
      body: Container(
        child: ListView(
          children: [
            FadeInDownBig(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          alignment: Alignment.topCenter,
                          child: SearchPage()));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ابحث عن الاكلات",
                            style: TextStyle(
                                color: Colors.grey.withOpacity(.7),
                                fontFamily: 'tajwal',
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80,
                            height: 55,
                            decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "بحث",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'tajwal',
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    width: _width,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(.5, 1),
                              blurRadius: 2,
                              color: Colors.grey.withOpacity(.2),
                              spreadRadius: 2),
                          BoxShadow(
                              blurRadius: .5,
                              color: Colors.grey.withOpacity(.5),
                              spreadRadius: .1)
                        ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                "هل تريد: مكبوس, برجر, حلويات, بيتزا, كشري",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'tajwal',
                    fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: _height * .35,
                width: _width,
                // color: Colors.blue,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "عن ماذا تبحث؟",
                              style: TextStyle(
                                  color: mainColor,
                                  fontFamily: 'tajwal',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: OurMeals(),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: yellow)),
                                height: 20,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    "عرض الكل",
                                    style: TextStyle(
                                        fontFamily: 'tajwal',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: _width,
                        height: _height * .3 - 30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            mealCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "باسعار تبدا من 20 دا"),
                            mealCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "باسعار تبدا من 20 دا"),
                            mealCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "باسعار تبدا من 20 دا"),
                            mealCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "باسعار تبدا من 20 دا")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: _height * .36,
                width: _width,
                // color: Colors.blue,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "العروض",
                              style: TextStyle(
                                  color: mainColor,
                                  fontFamily: 'tajwal',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: Offers(),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: yellow)),
                                height: 20,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    "عرض الكل",
                                    style: TextStyle(
                                        fontFamily: 'tajwal',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: _width,
                        height: _height * .31 - 5,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            mealOfferCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "خصم15%",
                                3.5,
                                "ابو ظبي",
                                "ماكولات الشرق"
                                    "باسعار تبدا من 20 دا"),
                            mealOfferCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "خصم15%",
                                3.5,
                                "ابو ظبي",
                                "ماكولات الشرق"
                                    "باسعار تبدا من 20 دا"),
                            mealOfferCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "خصم15%",
                                3.5,
                                "ابو ظبي",
                                "ماكولات الشرق"
                                    "باسعار تبدا من 20 دا"),
                            mealOfferCard(
                                _width,
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                "كشري",
                                "خصم15%",
                                3.5,
                                "ابو ظبي",
                                "ماكولات الشرق"
                                    "باسعار تبدا من 20 دا"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                //      height: _height * .367,
                width: _width,
                // color: Colors.blue,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "افضل المطابخ",
                              style: TextStyle(
                                  color: mainColor,
                                  fontFamily: 'tajwal',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: BlocProvider(
                                          create: (context) =>
                                              KitchensBloc(FetchAllKitchens())
                                                ..add(FetchKitchens()),
                                          child: OurKitchens(),
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: yellow)),
                                height: 20,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    "عرض الكل",
                                    style: TextStyle(
                                        fontFamily: 'tajwal',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<KitchensBloc, KitchensState>(
                        builder: (context, state) {
                          if (state is KitchensLoaded) {
                            return Container(
                              //     color: Colors.red,
                              width: _width,
                              height: _height * .33,
                              child: ListView.builder(
                                itemCount: state.kitchens.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return kitchenCard(
                                    state.kitchens[index].id.toString(),
                                    _width,
                                    state.kitchens[index].picturePath,
                                    state.kitchens[index].name,
                                    state.kitchens[index].discount.toString(),
                                    state.kitchens[index].averageRating,
                                    state.kitchens[index].address,
                                    context,
                                    state.kitchens[index].slug,
                                    state.kitchens[index].slug,
                                  );
                                },
                                
                              ),
                            );
                          } else if (state is KitchensLoading) {
                            return Container(
                              width: _width,
                              height: _height * .32,
                              child: Shimmer(
                                enabled: true,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 263,
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                width: 180,
                                                height: 160,
                                              ),
                                            ],
                                          )),
                                          width: 150,
                                        ),
                                      );
                                    }),
                                period: Duration(seconds: 1),
                                gradient: LinearGradient(
                                    colors: [Colors.white, Colors.grey]),
                                //   period: Duration(milliseconds: 300),
                              ),
                            );
                          } else if (state is KitchenLoadFailed) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*      Center(
                  child: Container(
                    height: 260,
                    width: 180,
                    child: Center(
                        child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.withOpacity(.2),
                                        spreadRadius: 2,
                                        offset: Offset(.5, 1))
                                  ]),
                              width: 180,
                              height: 160,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  'https://images.pexels.com/photos/7334366/pexels-photo-7334366.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                width: 75,
                                child: Center(
                                    child: Text(
                                  "تخفيض15%",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'tajwal'),
                                )),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(18))),
                                height: 30,
                              ),
                              bottom: 0,
                              left: 0,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "كشري",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajwal',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              RatingBar.builder(
                                ///TO DO // ADD RATING ARRGUEMENT
                                initialRating: 3,
                                minRating: 1,
                                textDirection: TextDirection.ltr,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                updateOnDrag: false,
                                ignoreGestures: true,
                                glowColor: Color(0xff3CAF67),
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Color(0xff3CAF67),
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "المطبخ الأميري للمشوياتداون تاون ديرة , ديرة ديرة دبي",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'tajwal',
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
          */
