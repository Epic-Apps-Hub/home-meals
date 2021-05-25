import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../views/widgets/bottomSheetContainer.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';
import 'package:hive/hive.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/menu/menu_bloc.dart';
import 'package:home_made/blocs/reviews/reviewsbloc_bloc.dart';
import 'package:home_made/models/cartItem.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/mealDetails.dart';
import 'package:home_made/views/orderScreen.dart';
import 'package:home_made/views/ratingpage.dart';
import 'package:home_made/views/searchPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:hive_flutter/hive_flutter.dart' as hflut;
import '../constants.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final String picUrl;
  final String name;
  const DetailsScreen({
    @required this.id,
    this.picUrl,
    this.name,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  bool isOrdered = false;
  var isFavorite = false;
  List titles;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  var top = 0.0;
  TabController tabController;

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
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light, statusBarColor: yellow));
    tabController = TabController(length: 2, vsync: this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Material(
      child: GFFloatingWidget(
        verticalPosition: _height * .9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // ignore: deprecated_member_use
          child: hflut.WatchBoxBuilder(
              box: Hive.box<CartItem>('cartItems'),
              builder: (ctx, box) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: OrdersScreen(),
                            type: PageTransitionType.scale,
                            alignment: Alignment.bottomCenter));
                  },
                  child: Container(
                    height: _height * .07,
                    width: _width - 40,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                priceAndQuantityBox
                                        .get("quantity")
                                        .toString() ??
                                    "0",
                                style: TextStyle(color: mainColor),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                  priceAndQuantityBox
                                          .get("totalPrice")
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'tajwal',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text("دأ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'tajwal',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        body: BlocBuilder<KitchensBloc, KitchensState>(
          builder: (ctx, state) {
            if (state is KitchenLoaded) {
              String address = state.kitchen.data.address;
              return NestedScrollView(
                headerSliverBuilder: (ctx, d) {
                  return [
                    SliverAppBar(
                      brightness: Brightness.light,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          height: 40,
                          width: _width,
                          child: BlocBuilder<MenuBloc, MenuState>(
                            builder: (context, state) {
                              if (state is MenuLoaded) {
                                List<String> titles = [];
                                for (int i = 0;
                                    i < state.categories.length;
                                    i++) {
                                  titles.add(state.categories[i].name);
                                }
                                ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.builder(
                                    itemCount: titles.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 56,
                                        width: 100,
                                        child: Text(
                                          titles[index] ?? "",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      expandedHeight: _height * .65,
                      automaticallyImplyLeading: false,
                      flexibleSpace: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          top = constraints.biggest.height;

                          return FlexibleSpaceBar(
                              centerTitle: true,
                              title: AnimatedOpacity(
                                  duration: Duration(milliseconds: 300),
                                  opacity:
                                      top == 138.36363636363637 ? 1.0 : 0.0,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 40.0),
                                    child: Text(
                                      widget.name ?? "",
                                      style: TextStyle(
                                          fontFamily: 'tajwal',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )), ////////////////////////////////////////remove )+;
                              background: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      width: _width,
                                      height: _height * .18,
                                      child: Image.network(
                                        widget.picUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.kitchen.data.name ?? "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'tajwal',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 95,
                                            child: Center(
                                                child: Text(
                                              state.kitchen.data.discount
                                                      .toString() ??
                                                  "" + "خصم %",
                                              style: TextStyle(
                                                  color: yellow,
                                                  fontFamily: 'tajwal',
                                                  fontWeight: FontWeight.w800),
                                            )),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    color: Colors.grey
                                                        .withOpacity(.5),
                                                    offset: Offset(.5, 1))
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2)),
                                            ),
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.kitchen.data.address ?? "",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'tajwal',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Container(
                                            width: 105,
                                            child: Center(
                                                child: Row(
                                              children: [
                                                state.kitchen.data.isOpen
                                                    ? CircleAvatar(
                                                        backgroundColor: yellow,
                                                        radius: 6,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        radius: 6,
                                                      ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                state.kitchen.data.isOpen
                                                    ? Text(
                                                        "المطبخ مفتوح",
                                                        style: TextStyle(
                                                            color: yellow,
                                                            fontFamily:
                                                                'tajwal',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      )
                                                    : Text(
                                                        "المطبخ غير مفتوح",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                'tajwal',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                              ],
                                            )),
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28.0),
                                      child: Container(
                                        width: _width,
                                        height: _height * .05,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                      state.kitchen.reviews
                                                          .total),
                                                  minRating: 1,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                  updateOnDrag: false,
                                                  ignoreGestures: true,
                                                  glowColor: yellow,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: yellow,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Text(
                                                  state.kitchen.reviews.total ??
                                                      "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                    '(${state.kitchen.reviews.count})')
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider<
                                                                    KitchensBloc>(
                                                                create: (context) =>
                                                                    KitchensBloc(
                                                                        FetchAllKitchens())
                                                                      ..add(
                                                                        FetchSpecificKitchen(state
                                                                            .kitchen
                                                                            .data
                                                                            .slug),
                                                                      )),
                                                            BlocProvider<
                                                                ReviewsblocBloc>(
                                                              create: (context) =>
                                                                  ReviewsblocBloc(
                                                                      FetchAllKitchens())
                                                                    ..add(FetchSpecificKitchenComments(state
                                                                        .kitchen
                                                                        .data
                                                                        .id
                                                                        .toString())),
                                                            )
                                                          ],
                                                          child: RatingPage(),
                                                        ),
                                                        type: PageTransitionType
                                                            .rightToLeft));
                                              },
                                              child: Text(
                                                "التقييمات",
                                                style: TextStyle(
                                                    color: yellow,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontFamily: 'tajwal',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0),
                                          child: Text(
                                            "معلومات عن المطبخ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: yellow,
                                                fontSize: 17,
                                                fontFamily: 'tajwal',
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0),
                                      child: Text(
                                        state.kitchen.data.description ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                          fontFamily: 'tajwal',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                      pinned: true,
                      backgroundColor: yellow,
                      floating: false,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(.3),
                              radius: 20,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Linecons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (ctx) => SearchPage()));
                                },
                              )),
                        )
                      ],
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(.3),
                            radius: 15,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ),
                    )
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<MenuBloc, MenuState>(
                    builder: (context, state) {
                      if (state is MenuLoading) {
                        return Container(
                          height: _height * .2,
                          width: _width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is MenuLoaded) {
                        List<String> titles = [];
                        for (int i = 0; i < state.categories.length; i++) {
                          titles.add(state.categories[i].name);
                        }

                        return ScrollablePositionedList.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.categories[index].name ?? "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'tajwal',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            state.categories[index].data.length,
                                        itemBuilder: (ctx, ind) {
                                          return InkWell(
                                            onTap: () {
                                              state.categories[index].data[ind]
                                                          .hasOptions ==
                                                      0
                                                  ? showMaterialModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: true,
                                                      isDismissible: false,
                                                      context: context,
                                                      builder: (ctx) {
                                                        return BottomSheetContainer(
                                                          data: state
                                                              .categories[index]
                                                              .data[ind],
                                                          height: _height,
                                                          width: _width,
                                                          address: address,
                                                          ctx: ctx,
                                                          resturantId:
                                                              widget.id,
                                                          resturantName:
                                                              widget.name,
                                                        );
                                                      })
                                                  : Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          child: MealDetailsScreen(
                                                              address: address,
                                                              data: state
                                                                  .categories[
                                                                      index]
                                                                  .data[ind],
                                                              height: _height,
                                                              width: _width,
                                                              resturantId:
                                                                  widget.id,
                                                              resturantName:
                                                                  widget.name),
                                                          type:
                                                              PageTransitionType
                                                                  .bottomToTop));
                                            },
                                            child: Container(
                                              height: _height * .15,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        state
                                                                .categories[
                                                                    index]
                                                                .data[ind]
                                                                .itemName ??
                                                            "",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'tajwal',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      state
                                                                  .categories[
                                                                      index]
                                                                  .data[ind]
                                                                  .hasOptions ==
                                                              0
                                                          ? Text(state
                                                                  .categories[
                                                                      index]
                                                                  .data[ind]
                                                                  .price
                                                                  .toString() +
                                                              "دأ")
                                                          : Text(
                                                              "السعر حسب النوع")
                                                    ],
                                                  ),
                                                  Container(
                                                    height: _height * .11,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://images.pexels.com/photos/2613471/pexels-photo-2613471.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ))
                                ],
                              ),
                            );
                          },
                          itemScrollController: itemScrollController,
                          itemPositionsListener: itemPositionsListener,
                        );
                      }

                      if (state is MenuError) {
                        return Container(
                          child: Center(
                            child: Text("menu is not available"),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
