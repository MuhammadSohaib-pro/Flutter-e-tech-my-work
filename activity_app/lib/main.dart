import 'package:activityapp/firebase_options.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/provider/switch_provider.dart';
import 'package:activityapp/screens/booking_screens/store_screen.dart';
import 'package:activityapp/screens/home/controller/home_controller.dart';
import 'package:activityapp/screens/nav_bar/nav_bar_screren.dart';
import 'package:activityapp/screens/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import 'languages/LocaleString.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
      ],
      initLanguageCode: 'en',
    );
    // notificationServices.requestAndRegisterNotification();
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeCtrl()),
            ChangeNotifierProvider(create: (_) => SwitchProvider()),
          ],
          child: OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);

            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            return MaterialApp(
              supportedLocales: localization.supportedLocales,
              localizationsDelegates: localization.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                // useMaterial3: true,
                //  visualDensity: VisualDensity.adaptivePlatformDensity,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
              ),
              // title: 'Flutter Demo',
              // builder: (context, child) {
              //   return Scaffold(
              //     // Additional global settings for your scaffold can be added here
              //     // appBar: AppBar(...),
              //     // drawer: Drawer(...),
              //     // ...
              //     body: child,
              //   );
              // },
              // home: const NavBarScreen(),
              // home: StoreScreen(),
              home: const SplashScreen(),
            );
          }),
        );
      });
    });
  }
}
