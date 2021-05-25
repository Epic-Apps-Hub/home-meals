import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/views/404.dart';
import 'package:home_made/views/widgets/kitchen.dart';
import 'package:shimmer/shimmer.dart';

class OurKitchens extends StatefulWidget {
  @override
  _OurKitchensState createState() => _OurKitchensState();
}

class _OurKitchensState extends State<OurKitchens> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: yellow,
          title: Text(
            "افضل المطابخ",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'tajwal',
                fontWeight: FontWeight.w900,
                fontSize: 26),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(child: BlocBuilder<KitchensBloc, KitchensState>(
            builder: (context, state) {
              if (state is KitchensLoaded) {
                return GridView.builder(
                  itemCount: state.kitchens.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.45),
                  itemBuilder: (BuildContext context, int index) {
                    return kitchenCard(state.kitchens[index].id.toString(),
                        MediaQuery.of(context).size.width,
                        state.kitchens[index].picturePath,
                        state.kitchens[index].name,
                        state.kitchens[index].discount.toString(),
                        state.kitchens[index].averageRating,
                        state.kitchens[index].address,
                        context,
                        state.kitchens[index].id.toString(),
                        state.kitchens[index].slug);
                  },
                );
              } else if (state is KitchensLoading) {
                return Shimmer(
                  enabled: true,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1 / 1.45),
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 263,
                            child: Center(
                                child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey,
                                            spreadRadius: 2,
                                            offset: Offset(.5, 1))
                                      ]),
                                  width: 180,
                                  height: 160,
                                ),
                              ],
                            )),
                            width: 150,
                          ),
                        );
                      }),
                  period: Duration(seconds: 1),
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.transparent]),
                  //   period: Duration(milliseconds: 300),
                );
              } else if (state is KitchenLoadFailed) {
                return Error404Screen();
              }
              return Container();
            },
          )),
        ),
      ),
    );
  }
}
