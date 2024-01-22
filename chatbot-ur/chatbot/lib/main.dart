import 'package:chatbot/firebase_options.dart';
import 'package:chatbot/helper/theme_helper.dart';
import 'package:chatbot/views/chat/provider/chat_provider.dart';
import 'package:chatbot/views/login/login_provider.dart';
import 'package:chatbot/views/signup/provider/signup_provider.dart';
import 'package:chatbot/views/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:galli_text_to_speech/text_to_speech.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SpeechToText _speechToText = SpeechToText();
  await _speechToText.initialize();
  // FlutterTts tts = FlutterTts();
  // await tts.setLanguage('ur_PK');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Chat Bot',
        debugShowCheckedModeBanner: false,
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
        home: const SplashView(),
      ),
    );
  }
}
