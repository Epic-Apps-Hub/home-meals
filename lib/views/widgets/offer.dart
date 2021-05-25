

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/constants.dart';

Widget offersCard(double fullWidth, String picUrl, String name, String discount,
    double rating, String location, String kitchen, String description) {
  return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18, top: 18),
        child: Container(
          height: 300,
          width: fullWidth,
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
                    width: fullWidth,
                    height: 190,
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
                      width: 105,
                      child: Center(
                          child: Text(
                        discount,
                        style: TextStyle(
                            color: yellow,
                            fontFamily: 'tajwal',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(18))),
                      height: 50,
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
                          color: Color(0xff4C5C69),
                          fontFamily: 'tajwal',
                          fontSize: 28,
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
                      glowColor: yellow,
                      ignoreGestures: true,
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
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      kitchen,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'tajwal',
                          fontSize: 16),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff4C5C69),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'tajwal',
                              fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [Text(description)],
                  ))
            ],
          )),
        ),
      ),
    
  );
}
