import 'package:flutter/material.dart';
import 'package:chatbot/presentation/splash_screen/splash_screen.dart';
import 'package:chatbot/presentation/Auth/sign_in_screens.dart';
import 'package:chatbot/presentation/Auth/sign_up_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String signUpScreen = '/signUpScreen';

  static const String signInScreen = '/sign_in_screen';

  static const String chatScreen = '/chat_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    signUpScreen: (context) => SignUpScreen(),
    signInScreen: (context) => SignInScreens(),
  };
}
