import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/bottom_nav_bar/provider/nav_bar_provider.dart';
import 'package:activity_owner/view/my_activity/provider/my_activity_provider.dart';
import 'package:activity_owner/view/my_bookings/provider/my_bookings_provider.dart';
import 'package:activity_owner/view/privacy_policy/provider/privacy_policy_provider.dart';
import 'package:activity_owner/view/splash/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(const MyApp());

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => MyActivityProvider()),
        ChangeNotifierProvider(create: (_) => MyBookingsProvider()),
        ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()),
      ],
      child: MaterialApp(
        title: 'Activity Owner App',
        // locale: const Locale('ar'),
        locale: const Locale('en'),
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
        home: const SplashScreen(),
      ),
    );
  }
}
