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
          "التقييمات والمراجعات",
          style: TextStyle(
            color: Colors.black
            //    decoration: TextDecoration.underline,
            ,
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
                        padding: const EdgeInsets.only(top: 20, bottom: 11),
                        child: Container(
                          //       height: _height * .2,
                          width: _width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating:
                                    double.parse(statee.kitchen.reviews.total),
                                minRating: 1,
                                textDirection: TextDirection.ltr,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  (statee.kitchen.reviews.total),
                                  style: TextStyle(
                                      color: Colors.black,
                                      //  fontFamily: 'tajwal',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "استنادا الي ${statee.kitchen.reviews.count} تقييم",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'tajwal',
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "جودة الطعام",
                                      style: TextStyle(fontFamily: 'tajwal'),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              statee.kitchen.reviews.foodQuality),
                                          minRating: 1,
                                          textDirection: TextDirection.rtl,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 17,
                                          updateOnDrag: false,
                                          ignoreGestures: true,
                                          glowColor: yellow,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: yellow,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(statee.kitchen.reviews.foodQuality),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "التوصيل",
                                      style: TextStyle(fontFamily: 'tajwal'),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              statee.kitchen.reviews.delivery),
                                          minRating: 1,
                                          textDirection: TextDirection.rtl,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 17,
                                          updateOnDrag: false,
                                          ignoreGestures: true,
                                          glowColor: yellow,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: yellow,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(statee.kitchen.reviews.delivery),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "الخدمة",
                                      style: TextStyle(fontFamily: 'tajwal'),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              statee.kitchen.reviews.service),
                                          minRating: 1,
                                          textDirection: TextDirection.rtl,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 17,
                                          updateOnDrag: false,
                                          ignoreGestures: true,
                                          glowColor: yellow,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: yellow,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(statee.kitchen.reviews.service),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),SizedBox(
                        height: 30,
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
