import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/constants.dart';

Widget mealOfferCard(double fullWidth, String picUrl, String name,
    String discount, double rating, String kitchen, String description) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 260,
        width: 170,
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
                      picUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 75,
                    child: Center(
                        child: Text(
                      discount,
                      style: TextStyle(color: yellow, fontFamily: 'tajwal'),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(18))),
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
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'tajwal',
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    textDirection: TextDirection.ltr,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    updateOnDrag: false,
                    ignoreGestures: true,
                    glowColor: yellow,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                kitchen,
                style: TextStyle(
                    color: Colors.black,
                    //  fontWeight: FontWeight.bold,
                    fontFamily: 'tajwal'),
              ),
            ),

            /*  Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "المطبخ الأميري للمشوياتداون تاون ديرة , ديرة ديرة دبي",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'tajwal',
                  ),
                ),
              )*/
          ],
        )),
      ),
    ),
  );
}
