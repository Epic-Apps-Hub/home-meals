import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/constants.dart';

Widget buildCommentBox(BuildContext context, String name, String title,
    String content, String date, double rating) {
  final _height = MediaQuery.of(context).size.height;
  final _width = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
    child: Container(
      height: _height * .2,
      width: _width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: mainColor,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                  radius: 27,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'tajwal',
                            fontSize: 18),
                      ),SizedBox(
                        width: 20,
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
                  Text(date),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '"$title"',
                    style: TextStyle(fontFamily: 'tajwal', fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(content)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
