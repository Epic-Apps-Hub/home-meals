import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/views/widgets/ourMeals.dart';

class OurMeals extends StatefulWidget {
  @override
  _OurMealsState createState() => _OurMealsState();
}

class _OurMealsState extends State<OurMeals> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 28,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        "ماكولاتنا",
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: 'tajwal',
                            fontWeight: FontWeight.w900,
                            fontSize: 26),
                      ),
                    ],
                  ),
                ),
                mealCard(
                    MediaQuery.of(context).size.width,
                    "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "كلاود",
                    "بأسعار تبدأ من 20 د.أ"),
                mealCard(
                  MediaQuery.of(context).size.width,
                  "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  "كشري",
                  "بأسعار تبدأ من 20 د.أ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
