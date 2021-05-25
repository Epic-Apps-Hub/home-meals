import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:home_made/blocs/blocObserver.dart';
import 'package:home_made/blocs/kitchens/kitchens_bloc.dart';
import 'package:home_made/blocs/language/language_bloc.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/localization/APP_LOCAL.dart';
import 'package:home_made/localization/sharedPrefs.dart';
import 'package:home_made/models/cartItem.dart';
import 'package:home_made/repositories/kitchensRepo.dart';
import 'package:home_made/views/choseCountry.dart';
import 'package:home_made/views/homepage.dart';
import 'package:home_made/views/unAuthed/login.dart';
import 'package:home_made/views/unAuthed/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  final sharedPrefService = await SharedPreferencesService.instance;

  sharedPrefService.setLanguage("ar");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: yellow, statusBarBrightness: Brightness.dark));
  final appDocumentDirectory = await path.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartItems');
await Hive.openBox("name");
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
            home: BlocProvider(
              create: (context) =>
                  KitchensBloc(FetchAllKitchens())..add(FetchKitchens()),
              child: HomePage(),
            ));
      },
    );
  }
}
