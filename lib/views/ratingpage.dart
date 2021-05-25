import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/reviews/reviewsbloc_bloc.dart';
import 'package:home_made/views/widgets/comment.dart';

import '../constants.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "التقييمات",
          style: TextStyle(
            color: yellow,
            decoration: TextDecoration.underline,
            fontFamily: 'tajwal',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body:
          BlocBuilder<KitchensBloc, KitchensState>(builder: (context, statee) {
        if (statee is KitchenLoaded) {
          return BlocBuilder<ReviewsblocBloc, ReviewsblocState>(
            builder: (context, state) {
              if (state is ReviewsFetched) {
                return Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Container(
                          height: _height * .1,
                          width: _width,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      (statee.kitchen.reviews.total),
                                      style: TextStyle(
                                          color: yellow,
                                          fontFamily: 'tajwal',
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RatingBar.builder(
                                    initialRating: double.parse(
                                        statee.kitchen.reviews.total),
                                    minRating: 1,
                                    textDirection: TextDirection.ltr,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    updateOnDrag: false,
                                    ignoreGestures: true,
                                    glowColor: yellow,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
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
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "جودة الطعام",
                                  style: TextStyle(fontFamily: 'tajwal'),
                                ),
                                IgnorePointer(
                                    child: Container(
                                  width: _width * .4,
                                  child: Slider(
                                    activeColor: yellow,
                                    value: double.parse(
                                        statee.kitchen.reviews.foodQuality),
                                    onChanged: (c) {},
                                    min: 0,
                                    max: 5,
                                    inactiveColor: Colors.grey.withOpacity(.6),
                                  ),
                                )),
                                Text(statee.kitchen.reviews.foodQuality)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "    التوصيل",
                                  style: TextStyle(fontFamily: 'tajwal'),
                                ),
                                IgnorePointer(
                                    child: Container(
                                  width: _width * .4,
                                  child: Slider(
                                    activeColor: yellow,
                                    value: double.parse(
                                        statee.kitchen.reviews.delivery),
                                    onChanged: (c) {},
                                    min: 0,
                                    max: 5,
                                    inactiveColor: Colors.grey.withOpacity(.6),
                                  ),
                                )),
                                Text(statee.kitchen.reviews.delivery)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "     الخدمة",
                                  style: TextStyle(fontFamily: 'tajwal'),
                                ),
                                IgnorePointer(
                                    child: Container(
                                  width: _width * .4,
                                  child: Slider(
                                    activeColor: yellow,
                                    value: double.parse(
                                        statee.kitchen.reviews.service),
                                    onChanged: (c) {},
                                    min: 0,
                                    max: 5,
                                    inactiveColor: Colors.grey.withOpacity(.6),
                                  ),
                                )),
                                Text(statee.kitchen.reviews.service)
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.rating.data.length,
                          itemBuilder: (ctx, index) {
                            return buildCommentBox(
                                context,
                                state.rating.data[index].user.name,
                                state.rating.data[index].titleOfReview,
                                state.rating.data[index].review,
                                state.rating.data[index].since,
                                double.parse(
                                    state.rating.data[index].averageRating));
                          }),
                    ],
                  ),
                );
              } else if (state is ReviewsFailed) {
                return Center(
                  child: Text("fetching failed"),
                );
              } else if (state is ReviewsLoading) {
                return Container(
                  height: _height,
                  width: _width,
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              }
              return Container();
            },
          );
        } else if (statee is KitchensLoading) {
          return Container(
            height: _height,
            width: _width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
