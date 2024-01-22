import 'package:device_preview/device_preview.dart';
import 'package:event_app/helper/theme_helper.dart';
import 'package:event_app/screens/bottom_nav_bar/bottomnavbar_provider.dart';
import 'package:event_app/provider/home_provider.dart';
import 'package:event_app/provider/kitchen_provider.dart';
import 'package:event_app/provider/language_provider.dart';
import 'package:event_app/provider/service_provider.dart';
import 'package:event_app/screens/login/login_provider.dart';
import 'package:event_app/screens/menu/menu_provider.dart';
import 'package:event_app/screens/profile/profile_provider.dart';
import 'package:event_app/screens/signup/signup_provider.dart';
import 'package:event_app/screens/splash/splash_provider.dart';
import 'package:event_app/screens/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language_code') ?? '';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(
        locale: languageCode,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguage()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => KitchenProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, provider, child) {
          if (provider.appLocal == null) {
            if (locale.isEmpty) {
              provider.changeLanguage(const Locale('en'));
            } else {
              provider.changeLanguage(Locale(locale));
            }
          }
          return MaterialApp(
            title: 'Event App',
            locale: locale == ''
                ? const Locale('en')
                : provider.appLocal == null
                    ? Locale(locale)
                    : Provider.of<AppLanguage>(context).appLocal,

            // locale: locale == ''
            //     ? const Locale('en')
            //     : provider.appLocal ?? Locale(locale),

            // locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: ThemeData(
              scaffoldBackgroundColor: ThemeColors.bgColor,
              primarySwatch: Palette.palette1,
              fontFamily: "Inter",
              appBarTheme: const AppBarTheme(
                backgroundColor: ThemeColors.mainColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: ThemeColors.black1,
                ),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: ThemeColors.black1,
                ),
              ),
            ),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
