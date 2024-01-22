import 'package:device_preview/device_preview.dart';
import 'package:elabd_tms_app/providers/pick_image.dart';
import 'package:elabd_tms_app/services/user_report_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:elabd_tms_app/screens/attendence/attendence_screen_provider.dart';
import 'package:elabd_tms_app/screens/home/home_screen_provider.dart';
import 'package:elabd_tms_app/screens/splash/splash_screen.dart';
import 'package:elabd_tms_app/screens/task_details/task_details_provider.dart';
import 'package:elabd_tms_app/services/auth_services.dart';
import 'models/select_index_controller.dart';
import 'models/shared_preferences_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initDependencyInjection();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

var uuid = const Uuid();

Future<void> initDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesModel>(
      SharedPreferencesModel(sharedPreferences));
  getIt.registerSingleton<HomeScreenProvider>(HomeScreenProvider());
  getIt.registerSingleton<SelectIndexController>(SelectIndexController());
  getIt.registerSingleton<AuthServiceProvider>(AuthServiceProvider());
  getIt.registerLazySingleton<UserReportService>(() => UserReportService());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendenceScreenProvider()),
        ChangeNotifierProvider(create: (_) => TaskDetailsProvider()),
        ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => PickImage()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black)),
                useMaterial3: true,
                fontFamily: 'Poppins',
              ),
              home: child);
        },
        child: const SplashScreen(),
      ),
    );
  }
}
