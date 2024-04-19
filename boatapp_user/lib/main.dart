import 'package:boat_app/global.dart';
import 'package:boat_app/notifications/notification_services.dart';
import 'package:boat_app/notifications/push_notification.dart';
import 'package:boat_app/provider/BottomBarUser_provider.dart';
import 'package:boat_app/provider/Date_Provider_class.dart';
import 'package:boat_app/provider/carousel_provider.dart';
import 'package:boat_app/provider/countdownProvider.dart';
import 'package:boat_app/provider/date_provider.dart';
import 'package:boat_app/provider/fav_provider.dart';
import 'package:boat_app/provider/filter_provider.dart';
import 'package:boat_app/provider/loader_view_provider.dart';
import 'package:boat_app/view/auth/signin/provider/obsecure_provider.dart';
import 'package:boat_app/view/auth/signup/provider/signup_obscure_provider.dart';
import 'package:boat_app/view/home/homescreen/provider/homescreen_tile_provider.dart';
import 'package:boat_app/provider/loading_provider/loading.dart';
import 'package:boat_app/provider/loading_provider/loading_provider.dart';
import 'package:boat_app/provider/loading_provider/time_slot_provider.dart';
import 'package:boat_app/provider/order_provider.dart';
import 'package:boat_app/provider/rating_tiles_provider.dart';
import 'package:boat_app/provider/reviewProvider.dart';
import 'package:boat_app/provider/select_package_provider.dart';
import 'package:boat_app/provider/switch_provider.dart';
import 'package:boat_app/provider/time_slider_provider.dart';
import 'package:boat_app/splash_screen.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes.dart';
import 'package:boat_app/view/my_bookings/my_bookings.dart';
import 'package:boat_app/view/my_bookings/provider/mybooking_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'languages/LocaleString.dart';

Future FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "BoatApp",
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB85Iktan8sJkHRrTYHvedmGbpmwYvavh4',
        appId: '1:564754992714:ios:2e0dbcfd0ccbdb1ddce0b3',
        messagingSenderId: '564754992714',
        projectId: 'boatapp-e2f43',
        storageBucket: "boatapp-e2f43.appspot.com",
      ));
      // its not created
  Stripe.merchantIdentifier =
      'merchant.com.boatuser';
  Stripe.publishableKey =
      "pk_test_51MgPVSFirPYpsqNHjbcjqWeyfpvpJMuvqIATOvrDPdkewBbQOjzSEcZZt7ThXwW6jq3CbPiAA0d5LbR3765MPacr00VNQbe1N2";
  await Stripe.instance.applySettings();
  runApp(
    DevicePreview(
      enabled: false,
       // !kReleaseMode,
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
    notificationServices.requestAndRegisterNotification();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => bottomBarUserProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => RatingTileProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenTileProvider()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CarouselProvider()),
        ChangeNotifierProvider(create: (_) => SwitchProvider()),
        ChangeNotifierProvider(create: (_) => NotificationServices()),
        ChangeNotifierProvider(create: (_) => RangeDatePickerValueModel()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => TimeSlotProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider2()),
        ChangeNotifierProvider(create: (_) => CountDownProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => MyBookingProvider()),
        ChangeNotifierProvider(create: (_) => LoaderViewProvider()),
        ChangeNotifierProvider(create: (_) => ObscureProvider()),
        ChangeNotifierProvider(create: (_) => SignUpObscureProvider()),


      ],
      child: OverlaySupport.global(
        child: LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);

            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            return MaterialApp(
              supportedLocales: localization.supportedLocales,
              localizationsDelegates: localization.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
                  useMaterial3: true,
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  )),
              home: const SplashScreen(),
            );
          });
        }),
      ),
    );
  }
}
