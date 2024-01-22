import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nawaz_salon/Screens/splash/splash_view.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:nawaz_salon/providers/bottom_nav_%20bar_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nawaz Saloon',
        theme: ThemeData(
          fontFamily: 'Josefin Sans',
          primarySwatch: Palette.palette1,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
