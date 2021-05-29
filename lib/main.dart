import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:home_made/blocs/blocObserver.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/language/language_bloc.dart';
import 'package:home_made/localization/APP_LOCAL.dart';
import 'package:home_made/localization/sharedPrefs.dart';
import 'package:home_made/models/cartItem.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './views/widgets/onBoarding.dart';

import 'package:path_provider/path_provider.dart' as path;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 40000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  final sharedPrefService = await SharedPreferencesService.instance;

  sharedPrefService.setLanguage("ar");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  final appDocumentDirectory = await path.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartItems');
  await Hive.openBox("name");
  await Hive.openBox("address");
  if (Hive.box("name").get("onBoard") == null) {
    Hive.box("name").put("onBoard", true);
  }
  configLoading();

  runApp(
    new BlocProvider(
      create: (_) => LanguageBloc()..add(LanguageLoadStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: 'Home Meals',
          locale: languageState.locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'AR'),
          ],
          home: Hive.box("name").get("onBoard")
              ? OnBoarding()
              : BlocProvider(
                  create: (context) =>
                      KitchensBloc(FetchAllKitchens())..add(FetchKitchens()),
                  child: DoubleBack(
                      message: "Press back again to close", child: HomePage())),
        );
      },
    );
  }
}
