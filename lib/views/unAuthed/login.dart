import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/localization/APP_LOCAL.dart';
import 'package:home_made/views/homepage.dart';
import 'package:home_made/views/unAuthed/forgetPassword.dart';
import 'package:home_made/views/unAuthed/signup.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: _height * .06,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).translate('login'),
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
                  height: 20,
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
                          prefixIcon: Icon(Icons.email_outlined, color: yellow),
                          labelText:
                              AppLocalizations.of(context).translate('email')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                          prefixIcon: Icon(Icons.lock_outline, color: yellow),
                          labelText: AppLocalizations.of(context)
                              .translate('password')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ForgetPassword(),
                            type: PageTransitionType.fade));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: yellow,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).translate('forget'),
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'tajwal'),
                          ),
                        ],
                      ),
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
                                AppLocalizations.of(context).translate('login'),
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
                  height: 20,
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
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: Signup(),
                                    duration: Duration(milliseconds: 240)));
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).translate('signup'),
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
                )
              ],
            ),
          ),
        ));
  }
}
