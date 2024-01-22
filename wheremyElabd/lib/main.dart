import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';

import 'package:wheremyelabd/View/splashscreen.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wheremyelabd/models/storage_model.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  // Register adapters
  Hive.registerAdapter(StorageModelAdapter());
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(editprofileAdapter());

  // Open boxes after registering adapters
  await Hive.openBox<StorageModel>('StoragePlace');
  await Hive.openBox<ItemModel>('ItemModel');
  await Hive.openBox<editprofile>('editprofile');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final ThemeData customTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.appbackgroundColor,
    // Add other theme properties as needed
  );


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home:
      const SplashScreen(),


    );
  }
}
