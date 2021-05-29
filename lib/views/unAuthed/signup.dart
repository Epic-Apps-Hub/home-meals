import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/localization/APP_LOCAL.dart';
import 'package:home_made/views/homepage.dart';
import 'package:page_transition/page_transition.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isSecured = true;

  buildTextFiled(
    double width,
    BuildContext context,
    String title,
    IconData iconData,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        width: width,
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
              prefixIcon: Icon(iconData, color: yellow),
              labelText: title),
        ),
      ),
    );
  }

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
            child: ListView(
              //   mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context).translate('signup'),
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
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextFiled(_width, context, 'الاسم', Icons.person_outline),
                SizedBox(
                  height: 10,
                ),
                buildTextFiled(
                    _width, context, 'البريد الالكتروني', Icons.email_outlined),
                SizedBox(
                  height: 10,
                ),
                buildTextFiled(_width, context, 'رقم الهاتف',
                    Icons.phone_in_talk_outlined),
                SizedBox(
                  height: 10,
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
                      obscureText: isSecured,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: isSecured
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesome5.eye_slash,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecured = !isSecured;
                                        });
                                      }),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesome5.eye,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecured = !isSecured;
                                        });
                                      }),
                                ),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'tajwal',
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                          prefixIcon: Icon(Icons.lock_outlined, color: yellow),
                          labelText: "كلمة المرور"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                      obscureText: isSecured,
                      decoration: InputDecoration(
                          suffixIcon: isSecured
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesome5.eye_slash,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecured = !isSecured;
                                        });
                                      }),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesome5.eye,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecured = !isSecured;
                                        });
                                      }),
                                ),
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'tajwal',
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                          prefixIcon: Icon(Icons.lock_outlined, color: yellow),
                          labelText: "تاكيد كلمة المرور"),
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
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => HomePage()));
                            },
                            child: Center(
                              child: Text(
                                'تسجيل حساب جديد',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      width: _width,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          hoverColor: mainColor,
                          onTap: () {
                            //     Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>Signup()));
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  fontFamily: 'tajwal'),
                            ),
                          ),
                        ),
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'هل انت مسجل بالفعل؟',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'tajwal',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            color: yellow,
                            decoration: TextDecoration.underline,
                            fontFamily: 'tajwal',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: _width,
                  height: 60,
                  child: Stack(
                    children: [
                      Center(
                        child: Divider(
                          thickness: 1.2,
                          color: Colors.black,
                        ),
                      ) //
                      ,
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Text(
                            AppLocalizations.of(context).translate('or'),
                            style: TextStyle(
                                color: yellow,
                                fontFamily: 'tajwal',
                                fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/facebook.svg',
                      height: 40,
                      color: yellow,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      'assets/images/google.svg',
                      height: 40,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
