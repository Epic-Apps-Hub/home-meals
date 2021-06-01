import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/constants.dart';

Widget mealCard(
    double fullWidth, String picUrl, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Center(
      child: Container(
        height: 150,
        width: 170,
        child: Stack(
          children: [
            Center(
                child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.orange.withOpacity(.3),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey.withOpacity(.2),
                                spreadRadius: 2,
                                offset: Offset(.5, 1))
                          ]),
                      width: 180,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          picUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            shadows: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                            fontFamily: 'tajwal',
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      ),
                      bottom: 15,
                      right: 15,
                    )
                  ],
                ),

                /*   Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'tajwal',
                        ),
                      ),
                    ),
                  )*/
              ],
            )),
          ],
        ),
      ),
    ),
  );
}
