import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class SearchPage extends StatefulWidget {
  final BuildContext mainPageCtx;

  const SearchPage({Key key, this.mainPageCtx}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
              height: _height,
              width: _width,
              child: Container(
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: _height * .05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        width: _width,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(6)),
                        child: TextField(
                          controller: textEditingController,
                          autofocus: false,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          onSubmitted: (value) {
                            if (value != null || value.length != 0) {
                              /*BlocProvider.of<SearchproductsBloc>(context)
                  .add(SearchProducts(value));*/
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(Typicons.cancel_circled_outline),
                                  onPressed: () {
                                    textEditingController.clear();
                                  }),
                              prefixIcon: Icon(
                                Linecons.search,
                                color: Colors.black,
                              ),
                              hintText: "ابحث عن افضل المطاعم",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.6),
                              )),
                        ),
                      ),
                    ),
                    /*   TextField(
              controller: textEditingController,
              autofocus: false,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                if (value != null || value.length != 0) {
                  /*BlocProvider.of<SearchproductsBloc>(context)
                  .add(SearchProducts(value));*/
                }
              },
              decoration: InputDecoration(
                  hintText: "ابحث هنا...",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.6),
                  )),
            )*/
                  ],
                )),
              )),
        ));
  }
}
