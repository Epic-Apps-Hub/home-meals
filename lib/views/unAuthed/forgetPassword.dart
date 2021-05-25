import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/localization/APP_LOCAL.dart';
import 'package:home_made/views/unAuthed/signup.dart';
import 'package:page_transition/page_transition.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: yellow, size: 45),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: _height * .07,
                ),
                Center(
                  child: Text(
                  "نسيت كلمة المرور",
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: 'tajwal',
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/transparent.png',
                    ),
                    height: 130,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    width: _width,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.grey.withOpacity(.2)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'tajwal',
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                          prefixIcon:
                              Icon(Icons.email_outlined, color:yellow),
                          labelText:
                              AppLocalizations.of(context).translate('email')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                        width: _width,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            hoverColor: Colors.white,
                            onTap: () {},
                            child: Center(
                              child: Text(
                                "ارسال",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
          ),
        ));
  }
}
