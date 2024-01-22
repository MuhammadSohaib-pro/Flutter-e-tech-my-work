import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/providers/add_employe_provider.dart';
import 'package:elabd_ems_admin/providers/add_task_provider.dart';
import 'package:elabd_ems_admin/providers/attendance_provider.dart';
import 'package:elabd_ems_admin/providers/auth_provider.dart';
import 'package:elabd_ems_admin/providers/check_internet_connection.dart';
import 'package:elabd_ems_admin/routes/routes.dart';
import 'package:elabd_ems_admin/services/pick_image.dart';
import 'package:elabd_ems_admin/services/select_dropdown.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Upgrader.clearSavedSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PickImage()),
          ChangeNotifierProvider(create: (context) => AddEmployeProvider()),
          ChangeNotifierProvider(create: (context) => AddTaskProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => InternetStatusProvider()),
          ChangeNotifierProvider(create: (context) => SelectDropdown()),
          ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Elabd EMS Admin',
          builder: FlutterSmartDialog.init(),
          theme: ThemeData(
            dialogBackgroundColor: whiteColor,
            scaffoldBackgroundColor: whiteColor,
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: routes,

          // home: Test(),
        ),
      ),
    );
  }
}
