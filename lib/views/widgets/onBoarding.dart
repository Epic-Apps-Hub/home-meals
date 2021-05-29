import 'package:dots_indicator/dots_indicator.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/homepage.dart';

import '../../constants.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  var currentIndexPage = 0.0;

  Widget buildPages(double width, double height, String picPath, int pageNumber,
      String description, String descriptionn) {
    return Container(
      height: height,
      width: width,
      child: Center(
          child: Column(
        children: [
          Image.asset(picPath),
          SizedBox(
            height: 20,
          ),
          Container(
            width: width * .75,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'tajwal',
                  fontWeight: FontWeight.w900,
                  color: Colors.orange,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: width * .85,
            child: Text(
              descriptionn,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'tajwal', fontSize: 20),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          pageNumber != 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                      width: width,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          hoverColor: Colors.white,
                          onTap: () {
                            pageController.animateToPage(pageNumber + 1,
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 300));
                          },
                          child: Center(
                            child: Text(
                              'التالي',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  fontFamily: 'tajwal'),
                            ),
                          ),
                        ),
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainColor,
                      )))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                      width: width,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          hoverColor: Colors.white,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BlocProvider(
                                        create: (context) =>
                                            KitchensBloc(FetchAllKitchens())
                                              ..add(FetchKitchens()),
                                        child: DoubleBack(
                                            message:
                                                "Press back again to close",
                                            child: HomePage()))));
                          },
                          child: Center(
                            child: Text(
                              'سجل الان',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  fontFamily: 'tajwal'),
                            ),
                          ),
                        ),
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainColor,
                      ))),
          SizedBox(height: 20),
          pageNumber != 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    width: width,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: mainColor,
                        onTap: () {
                          pageController.animateToPage(2,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 300));
                        },
                        child: Center(
                          child: Text(
                            "تخطي",
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                fontFamily: 'tajwal'),
                          ),
                        ),
                      ),
                    ),
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ))
              : Container(),
        ],
      )),
    );
  }
@override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  currentIndexPage = index.toDouble();
                });
              },
              children: [
                buildPages(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                    "assets/images/avatar.png",
                    0,
                    "اضف الطعام المفضل الي سلة المشتريات",
                    "ببساطة يمكنك اخيار طباخك المفضل واضافة الطعام الي السلة"),
                buildPages(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                    "assets/images/avatar.png",
                    1,
                    "اضف الطعام المفضل الي سلة المشتريات",
                    "ببساطة يمكنك اخيار طباخك المفضل واضافة الطعام الي السلة"),
                buildPages(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                    "assets/images/avatar.png",
                    2,
                    "اضف الطعام المفضل الي سلة المشتريات",
                    "ببساطة يمكنك اخيار طباخك المفضل واضافة الطعام الي السلة"),
              ],
              controller: pageController,
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * .25,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new DotsIndicator(
                      dotsCount: 3,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        color: Colors.grey,
                        activeColor: Colors.orange,
                        size: const Size.square(12.0),
                        activeSize: const Size.square(12.0),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
