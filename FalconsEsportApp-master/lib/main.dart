import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/bottom_nav_bar/bottom_nav_bar_provider.dart';
import 'package:falconsesportsapp/views/onboarding/onboarding_provider.dart';
import 'package:falconsesportsapp/views/splash/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Falcons Esports App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ThemeColors.mainColor,
          primarySwatch: Palette.palette1,
          fontFamily: "JosefinSans-Regular",
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: ThemeColors.mainColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: ThemeColors.grey1,
            ),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: ThemeColors.bgColor,
            ),
          ),
        ),
        home: const SplashView(),
      ),
    );
  }
}
