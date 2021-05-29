import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/meals.dart';
import 'package:home_made/views/ourKitchens.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../offers.dart';

Widget drawer(double fullWidth, double fullHeight, BuildContext context) {
  return Container(
    color: Colors.white,
    width: fullWidth * .8,
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: fullHeight * .1,
          ),

          /*    InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Offers(),
                      type: PageTransitionType.rightToLeft,
                      ctx: context));
            },
            child: Container(
              width: 120,
              height: 40,
              child: Center(
                child: Text(
                  "عروضنا",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'tajwal',
                      fontSize: 26,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        */
          SizedBox(
            height: fullHeight * .06,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: BlocProvider(
                        create: (context) => KitchensBloc(FetchAllKitchens())
                          ..add(FetchKitchens()),
                        child: OurKitchens(),
                      ),
                      type: PageTransitionType.rightToLeft,
                      ctx: context));
            },
            child: Container(
              width: 120,
              height: 40,
              child: Center(
                child: Text(
                  "مطابخنا",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'tajwal',
                      fontSize: 26,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          SizedBox(
            height: fullHeight * .06,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: OurMeals(),
                      type: PageTransitionType.rightToLeft,
                      ctx: context));
            },
            child: Container(
              width: 120,
              height: 40,
              child: Center(
                child: Text(
                  "ماكولاتنا",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'tajwal',
                      fontSize: 26,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
