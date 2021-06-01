import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:hive/hive.dart';
import 'package:home_made/blocs/category/bloc/category_bloc.dart';
import 'package:home_made/blocs/dessert/dessert_bloc.dart';
import 'package:home_made/blocs/discount/discount_bloc.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/near/near_bloc.dart';
import 'package:home_made/blocs/popular/popular_bloc.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/meals.dart';
import 'package:home_made/views/offers.dart';
import 'package:home_made/views/orderScreen.dart';
import 'package:home_made/views/ourKitchens.dart';
import 'package:home_made/views/searchPage.dart';
import 'package:home_made/views/widgets/KitchenNarrow.dart';
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

  bool selected = false;

  Widget buildListTile(String name, IconData icon, Function tab) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        onTap: tab,
        title: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'tajwal',
          ),
        ),
        leading: Icon(
          icon,
          size: 30,
          color: mainColor,
        ),
      ),
    );
  }

  Widget _buildMenuScreen(double width, double height) {
    return Container(
        width: width * .8,
        height: height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(children: [
              SizedBox(
                height: height * .09,
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      "مرحبا بك",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'tajwal',
                          fontWeight: FontWeight.w800),
                    ),
                    Text("مصر")
                  ],
                )
              ]),
              SizedBox(
                height: 20,
              ),
              buildListTile("الملف الشخصي", Typicons.user, () {}),
              buildListTile("طلباتي", Icons.backpack, () {}),
              buildListTile("الاعدادات", Typicons.cog_outline, () {}),
              buildListTile("عن التطبيق", Icons.info, () {}),
              buildListTile("سياسة الخصوصية", Entypo.newspaper, () {}),
              buildListTile("مشاركة التطبيق", Elusive.share, () {}),
              buildListTile("تقييم التطبيق", Icons.rate_review, () {}),
              buildListTile("تسجيل الخروج", Entypo.logout, () {}),
              /*  Padding(
                padding: const EdgeInsets.only(left:55.0,top: 40),
                child: Image(
                  image: AssetImage("assets/images/transparent.png"),  height: height*.12,
                ),
              ),*/
            ]),
          ),
        ));
  }

  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Material(
      child: ZoomDrawer(
        clipMainScreen: true,
        disableGesture: true,
        showShadow: true,
        style: DrawerStyle.Style1,
        angle: 0,
        backgroundColor: mainColor,
        controller: zoomDrawerController,
        slideWidth: _width * .65,
        menuScreen: _buildMenuScreen(_width, _height),
        isRtl: true,
        mainScreen: Scaffold(
          appBar: AppBar(
            elevation: .8,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "الرئيسية",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'tajwal',
                  fontWeight: FontWeight.w900),
            ),
            actions: [
              Padding(
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
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(
                  MfgLabs.menu,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  zoomDrawerController.toggle.call();
                },
              ),
            ),
          ),
          key: scaffoldKey,
          //drawer: drawer(_width, _height, context),
          body: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 3),
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
                          /*       InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: OurMeals(),
                                            type:
                                                PageTransitionType.rightToLeft,
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
                         */
                        ],
                      ),
                    ),
                    Container(
                      width: _width,
                      height: _height * .2,
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoading) {
                            return SizedBox(
                              width: _width,
                              child: Shimmer.fromColors(
                                period: Duration(milliseconds: 500),
                                baseColor: Colors.orange.withOpacity(.3),
                                highlightColor: Colors.orange.withOpacity(.6),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 20),
                                      child: Container(
                                        height: 150,
                                        width: 170,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 20),
                                      child: Container(
                                        height: 150,
                                        width: 170,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 20),
                                      child: Container(
                                        height: 150,
                                        width: 170,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (state is CategoryLoaded) {
                            return ListView.builder(
                              itemBuilder: (ctx, ind) {
                                return mealCard(
                                    _width,
                                    "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                                    state.category.data[ind].categoryName);
                              },
                              itemCount: state.category.data.length,
                              scrollDirection: Axis.horizontal,
                            );
                          } else if (state is CategoryLoadFailed) {
                            return Center(
                              child: Text("an error occured, sorry"),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<NearBloc, NearState>(
                  listener: (context, state) {
                    if (state is NearLoaded) {
                      Timer(Duration(milliseconds: 200), () {
                        setState(() {
                          selected = true;
                        });
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is NearEmpty) {
                      return Container();
                    } else if (state is NearLoaded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                          //      height: _height * .367,
                          width: selected ? _width : 0,
                          height: selected ? 315 : 0,
                          // color: Colors.blue,
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "بالقرب منك",
                                        style: TextStyle(
                                            color: mainColor,
                                            fontFamily: 'tajwal',
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  //     color: Colors.red,
                                  width: _width,
                                  height: _height * .33,
                                  child: ListView.builder(
                                    itemCount: state.kitchens.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return kitchenCard(
                                        state.kitchens[index].id.toString(),
                                        _width,
                                        state.kitchens[index].picturePath,
                                        state.kitchens[index].name,
                                        state.kitchens[index].discount
                                            .toString(),
                                        state.kitchens[index].averageRating,
                                        state.kitchens[index].address,
                                        context,
                                        state.kitchens[index].slug,
                                        state.kitchens[index].slug,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Container(
                    //      height: _height * .367,
                    width: _width,
                    // color: Colors.blue,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "الاكثر شيوعا",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'tajwal',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<PopularBloc, PopularState>(
                            builder: (context, state) {
                              if (state is PopularLoaded) {
                                return Container(
                                  //     color: Colors.red,
                                  width: _width,
                                  height: _height * .33,
                                  child: ListView.builder(
                                    itemCount: state.kitchens.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return kitchenCard(
                                        state.kitchens[index].id.toString(),
                                        _width,
                                        state.kitchens[index].picturePath,
                                        state.kitchens[index].name,
                                        state.kitchens[index].discount
                                            .toString(),
                                        state.kitchens[index].averageRating,
                                        state.kitchens[index].address,
                                        context,
                                        state.kitchens[index].slug,
                                        state.kitchens[index].slug,
                                      );
                                    },
                                  ),
                                );
                              } else if (state is PopularLoading) {
                                return SizedBox(
                                  width: _width,
                                  height: _height * .23,
                                  child: Shimmer.fromColors(
                                    period: Duration(milliseconds: 500),
                                    baseColor: Colors.orange.withOpacity(.3),
                                    highlightColor:
                                        Colors.orange.withOpacity(.6),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .7,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state is PopularFailed) {
                                return Center(
                                  child: Text("fetch failed"),
                                );
                              } else if (state is PopularEmpty) {
                                return Container();
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Container(
                    //      height: _height * .367,
                    width: _width,
                    // color: Colors.blue,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "جديد",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'tajwal',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return kitchenCard(
                                        state.kitchens[index].id.toString(),
                                        _width,
                                        state.kitchens[index].picturePath,
                                        state.kitchens[index].name,
                                        state.kitchens[index].discount
                                            .toString(),
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
                                return SizedBox(
                                  width: _width,
                                  height: _height * .23,
                                  child: Shimmer.fromColors(
                                    period: Duration(milliseconds: 500),
                                    baseColor: Colors.orange.withOpacity(.3),
                                    highlightColor:
                                        Colors.orange.withOpacity(.6),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Container(
                    //      height: _height * .367,
                    width: _width,
                    // color: Colors.blue,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "تحلية",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'tajwal',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<DessertBloc, DessertState>(
                            builder: (context, state) {
                              if (state is DessertLoaded) {
                                return Container(
                                  //     color: Colors.red,
                                  width: _width,
                                  height: _height * .33,
                                  child: ListView.builder(
                                    itemCount: state.kitchens.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return kitchenCard(
                                        state.kitchens[index].id.toString(),
                                        _width,
                                        state.kitchens[index].picturePath,
                                        state.kitchens[index].name,
                                        state.kitchens[index].discount
                                            .toString(),
                                        state.kitchens[index].averageRating,
                                        state.kitchens[index].address,
                                        context,
                                        state.kitchens[index].slug,
                                        state.kitchens[index].slug,
                                      );
                                    },
                                  ),
                                );
                              } else if (state is DessertLoading) {
                                return SizedBox(
                                  width: _width,
                                  height: _height * .23,
                                  child: Shimmer.fromColors(
                                    period: Duration(milliseconds: 500),
                                    baseColor: Colors.orange.withOpacity(.3),
                                    highlightColor:
                                        Colors.orange.withOpacity(.6),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state is DessertFailed) {
                                return Center(
                                  child: Text("loading failed"),
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Container(
                    //      height: _height * .367,
                    width: _width,
                    // color: Colors.blue,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "خصومات",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'tajwal',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<DiscountBloc, DiscountState>(
                            builder: (context, state) {
                              if (state is DiscountLoaded) {
                                return Container(
                                  //     color: Colors.red,
                                  width: _width,
                                  height: _height * .33,
                                  child: ListView.builder(
                                    itemCount: state.kitchens.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return kitchenCard(
                                        state.kitchens[index].id.toString(),
                                        _width,
                                        state.kitchens[index].picturePath,
                                        state.kitchens[index].name,
                                        state.kitchens[index].discount
                                            .toString(),
                                        state.kitchens[index].averageRating,
                                        state.kitchens[index].address,
                                        context,
                                        state.kitchens[index].slug,
                                        state.kitchens[index].slug,
                                      );
                                    },
                                  ),
                                );
                              } else if (state is DiscountLoading) {
                                return SizedBox(
                                  width: _width,
                                  height: _height * .23,
                                  child: Shimmer.fromColors(
                                    period: Duration(milliseconds: 500),
                                    baseColor: Colors.orange.withOpacity(.3),
                                    highlightColor:
                                        Colors.orange.withOpacity(.6),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, bottom: 20),
                                          child: Container(
                                            height: _height * .9,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state is DiscountFailed) {
                                return Center(
                                  child: Text("discount fetch failed"),
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:20,horizontal: 25),
                  child: Container(
                    height: 60,
                    width: 120,child: Center(
                      child: 
                      Text("عرض جميع المطاعم",style: TextStyle(
                        color: Colors.white,fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
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
