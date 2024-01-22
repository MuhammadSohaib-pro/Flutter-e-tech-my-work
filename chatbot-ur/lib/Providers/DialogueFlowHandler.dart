import 'dart:io';

import 'package:chatbot/core/app_export.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../Models/chat.dart';
import '../widgets/customDialogueBox.dart';

class DialogueFlowHandler extends ChangeNotifier {
  List<Chat> messsages = [];
  FlutterTts flutterTts = FlutterTts();

  addMessage(
      {required query, bool isAudio = false, required String audio}) async {
    try {
      await getAudio(query);

      messsages.add(Chat(isVoice: true, message: query, fromUser: true));
      notifyListeners();
      if (!(await chechIfToNavigate(query))) {
        AuthGoogle authGoogle =
            await AuthGoogle(fileJson: "assets/shahid-bgyn-b8598ecd1a08.json")
                .build();
        DialogFlow dialogflow =
            DialogFlow(authGoogle: authGoogle, language: "en");

        AIResponse aiResponse = await dialogflow.detectIntent(query);
        print(aiResponse.getListMessage()![0]["text"]["text"][0].toString());
        messsages.add(Chat(
            isVoice: false,
            message:
                aiResponse.getListMessage()![0]["text"]["text"][0].toString(),
            fromUser: false));
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getAudio(text) async {
    try {
      await flutterTts.speak(text);
      var res = await flutterTts.synthesizeToFile(
          text, Platform.isAndroid ? "$text.wav" : "$text.caf");
      print(res);
    } catch (e) {}
  }
}

Future<bool> chechIfToNavigate(String query) async {
  if (query.toLowerCase().contains('youtube') ||
      query.toLowerCase().contains('google')) {
    bool isYoutube = query.toLowerCase().contains('youtube');
    await AwesomeDialog(
        context: Get.context!,
        // title: 'Permission Required',
        // desc:
        //     'You are being redirected to ${isYoutube ? 'www.youtube.com' : 'www.google.com'}',
        body: CustomDialogBox(
          isYoutube: isYoutube,
          query: query,
        ),
        customHeader: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
            isYoutube ? ImageConstant.youtubeImage : ImageConstant.googleImage,
          ),
        )).show();

    return true;
  }
  return false;
}
