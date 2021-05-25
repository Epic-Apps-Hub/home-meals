import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/views/widgets/offer.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Linecons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
            )
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: yellow,
          title: Text(
            "العروض",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'tajwal',
                fontWeight: FontWeight.w900,
                fontSize: 26),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: ListView(
              children: [
                offersCard(
                    MediaQuery.of(context).size.width,
                    "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "كلاود",
                    "تخفيض15%",
                    4,
                    "حي الشيخ ذايد",
                    "المطبخ الاميري للمشويات",
                    "داون تاون ديرة , ديرة ديرة دب"),
                offersCard(
                    MediaQuery.of(context).size.width,
                    "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "كلاود",
                    "تخفيض15%",
                    4,
                    "حي الشيخ ذايد",
                    "المطبخ الاميري للمشويات",
                    "داون تاون ديرة , ديرة ديرة دب"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
