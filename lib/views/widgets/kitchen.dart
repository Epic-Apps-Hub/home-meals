import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/menu/menu_bloc.dart';
import 'package:home_made/blocs/reviews/reviewsbloc_bloc.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/DetailsScreen.dart';
import 'package:page_transition/page_transition.dart';

Widget kitchenCard(
    String id,
    double fullWidth,
    String picUrl,
    String name,
    String discount,
    double rating,
    String location,
    //String description,
    BuildContext context,
    String tag,
    String slug) {
  return Center(
    child: InkWell(
      onTap: () {
       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark));
            EasyLoading.show(
              
            );

        Navigator.push(
            context,
            PageTransition(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<KitchensBloc>(
                        create: (context) => KitchensBloc(FetchAllKitchens())
                          ..add(
                            FetchSpecificKitchen(slug),
                          )),
                    BlocProvider<MenuBloc>(
                      create: (context) =>
                          MenuBloc(FetchAllKitchens())..add(FetchMenu(slug)),
                    ),
                    BlocProvider<ReviewsblocBloc>(
                      create: (context) => ReviewsblocBloc(FetchAllKitchens())
                        ..add(FetchSpecificKitchenComments(id)),
                    )
                  ],
                  child: DetailsScreen(
                    id: id,
                    picUrl: picUrl,
                    name: name,
                  ),
                ),
                type: PageTransitionType.fade));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 269,
          width: 180,
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
                    child: Hero(
                      tag: tag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: CachedNetworkImage(
                          imageUrl: picUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 75,
                      child: Center(
                          child: Text(
                        "%$discount خصم",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'tajwal',
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RatingBar.builder(
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
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  location,
                  style: TextStyle(
                      color: Colors.black,
                      //  fontWeight: FontWeight.bold,
                      fontFamily: 'tajwal'),
                ),
              ),
            ],
          )),
        ),
      ),
    ),
  );
}
