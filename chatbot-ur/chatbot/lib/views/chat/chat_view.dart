// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:chatbot/helper/constant.dart';
import 'package:chatbot/helper/mySize.dart';
import 'package:chatbot/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chatbot/helper/theme_helper.dart';
import 'package:chatbot/views/chat/provider/chat_provider.dart';
import 'package:chatbot/widgets/custom_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

final ref = FirebaseDatabase.instance
    .ref(FirebaseAuth.instance.currentUser!.uid)
    .child("Chats")
    .child("messages")
    .get();

class _ChatViewState extends State<ChatView> {
  List<MessageModel> msgList = [];

  @override
  void initState() {
    final ref = FirebaseDatabase.instance
        .ref(FirebaseAuth.instance.currentUser!.uid)
        .child("Chats")
        .child("messages")
        .get();
    ref.then((value) {
      if (value.exists) {
        List<dynamic> s = value.children.toList();
        for (var i = 0; i < s.length; i++) {
          msgList.add(
            MessageModel(
              message: s[i].value['message'],
              sentByMe: s[i].value['sentByMe'],
              dateTime: s[i].value['dateTime'],
            ),
          );
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final ref = FirebaseDatabase.instance
            .ref(FirebaseAuth.instance.currentUser!.uid)
            .child("Chats");
        List<Map<String, dynamic>> mp = [];
        msgList.forEach((element) {
          mp.add(element.toJson());
          print(element.toJson());
        });
        await ref.set(
          {
            "messages": mp,
          },
        ).then((value) {
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
          print("added");
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        });
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size50),
              Padding(
                padding: Spacing.horizontal(MySize.size30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chat Bot',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Listening ',
                          style: TextStyle(
                            color: const Color(0xFC8FCECA),
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        final ref = FirebaseDatabase.instance
                            .ref(FirebaseAuth.instance.currentUser!.uid)
                            .child("Chats");
                        List<Map<String, dynamic>> mp = [];
                        msgList.forEach((element) {
                          mp.add(element.toJson());
                        });
                        await ref.set(
                          {
                            "messages": mp,
                          },
                        ).then((value) {
                          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                          print("added");
                          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                        });

                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Icon(
                        Icons.logout_outlined,
                        color: ThemeColors.grey2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                    // child:

                    // StreamBuilder(
                    //   stream: ref.onValue,
                    //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    //     List localList = [];
                    //     localList.clear();
                    //     msgList.clear();
                    //     if (snapshot.hasData) {
                    //       if (snapshot.data!.snapshot.children.isNotEmpty) {
                    //         Map<dynamic, dynamic> mp =
                    //             snapshot.data!.snapshot.value as dynamic;

                    //         localList = mp.values.toList();
                    //         print(localList);
                    //         for (var i = 0; i < mp.values.length; i++) {
                    //           msgList.add(
                    //             MessageModel(
                    //               message: localList[i]['message'],
                    //               sentByMe: localList[i]['sentByMe'],
                    //               dateTime: localList[i]['dateTime'],
                    //             ),
                    //           );
                    //         }
                    //       }

                    //       return snapshot.data!.snapshot.children.isEmpty
                    //           ?
                    child: msgList.isEmpty
                        ? const Center(
                            child: Text(""),
                          )
                        : ListView.builder(
                            itemCount: msgList.length,
                            reverse: true,
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: msgList[index].sentByMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: Spacing.all(MySize.size10),
                                  child: Container(
                                    width: MySize.size255,
                                    height: MySize.size60,
                                    decoration: ShapeDecoration(
                                      color: !msgList[index].sentByMe
                                          ? const Color(0xFF816ADB)
                                          : const Color(0xFF5429FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: !msgList[index].sentByMe
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              )
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                      ),
                                    ),
                                    padding: Spacing.horizontal(MySize.size8),
                                    child: Row(
                                      children: [
                                        Consumer<ChatProvider>(
                                            builder: (context, p, child) =>
                                                GestureDetector(
                                                  onTap: !p.voiceOn
                                                      ? () async {
                                                          p.changeVoiceValue();
                                                          await speakText(
                                                              msgList[index]
                                                                  .message,
                                                              index,
                                                              context);
                                                        }
                                                      : () async {
                                                          FlutterTts tts =
                                                              FlutterTts();
                                                          await tts.stop();
                                                          p.changeVoiceValue();
                                                        },
                                                  child: Container(
                                                    width: MySize.size36,
                                                    height: MySize.size36,
                                                    decoration:
                                                        const ShapeDecoration(
                                                      color:
                                                          ThemeColors.bgColor,
                                                      shape: CircleBorder(),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: p.voiceOnIndex !=
                                                            index
                                                        ? const Icon(
                                                            Icons.play_arrow,
                                                            color: ThemeColors
                                                                .mainColor,
                                                          )
                                                        : const Icon(
                                                            Icons.pause,
                                                            color: ThemeColors
                                                                .mainColor,
                                                          ),
                                                  ),
                                                )),
                                        SizedBox(width: MySize.size10),
                                        Expanded(
                                            child: SvgPicture.asset(icBar)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                    //             ;

                    //     } else {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //   },
                    // ),
                    ),
              ),
              Container(
                height: MySize.size100,
                width: double.infinity,
                padding: Spacing.horizontal(MySize.size30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<ChatProvider>(
                      builder: (context, p, child) => Text(
                        p.recordingOn ? "Recording" : "Press to Record",
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Consumer<ChatProvider>(
                      builder: (context, p, child) => GestureDetector(
                        onTap: p.recordingOn
                            ? () async {
                                p.stopListening();
                                p.changeRecordingValue();
                                if (!p.recordingOn) {
                                  if (p.concatString
                                      .toLowerCase()
                                      .contains("youtube")) {
                                    String url =
                                        "https://www.youtube.com/results?search_query=${p.concatString}";
                                    youtubeDialog(context, url);
                                  } else if (p.concatString
                                      .toLowerCase()
                                      .contains("google")) {
                                    String url =
                                        "https://www.google.com/search?q=${p.concatString}";

                                    chromeDialog(context, url);
                                  } else {
                                    String day = DateTime.now().day.toString();
                                    String month =
                                        DateTime.now().month.toString();
                                    String year =
                                        DateTime.now().year.toString();
                                    msgList.insert(
                                      0,
                                      MessageModel(
                                        message: p.concatString,
                                        sentByMe: true,
                                        dateTime: "$day/$month/$year",
                                      ),
                                    );
                                    setState(() {});
                                    // final ref = FirebaseDatabase.instance
                                    //     .ref(FirebaseAuth
                                    //         .instance.currentUser!.uid)
                                    //     .child("Chats");
                                    // await ref
                                    //     .push()
                                    //     .set(
                                    //       MessageModel(
                                    //         message: p.concatString,
                                    //         sentByMe: true,
                                    //         dateTime: "$day/$month/$year",
                                    //       ).toJson(),
                                    //     )
                                    //     .then((value) {
                                    //   print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                    //   print("added");
                                    //   print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                    // });
                                    await sendMsg(p.concatString);
                                  }
                                }
                              }
                            : () async {
                                await p.startListening();
                                p.changeRecordingValue();
                              },
                        child: Container(
                          width: MySize.size40,
                          height: MySize.size40,
                          decoration: const BoxDecoration(
                            color: ThemeColors.mainColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: p.recordingOn
                              ? const Icon(
                                  Icons.pause,
                                  color: ThemeColors.bgColor,
                                )
                              : const Icon(
                                  Icons.keyboard_voice,
                                  color: ThemeColors.bgColor,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> speakText(
      String message, int index, BuildContext context) async {
    final p = Provider.of<ChatProvider>(context, listen: false);
    p.changeVoiceOnIndexValue(index);
    FlutterTts tts = FlutterTts();

    await tts.speak(message).whenComplete(() {
      p.changeVoiceOnIndexValue(-1);
    });

    tts.awaitSpeakCompletion(true).then((value) {
      p.changeVoiceOnIndexValue(-1);
    });
  }

  Future<void> sendMsg(String text) async {
    String apiKey = "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";

    try {
      if (text.isNotEmpty) {
        var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo-0301",
            "messages": [
              {"role": "user", "content": text}
            ],
            "max_tokens": 250,
            "temperature": 0,
            "top_p": 1,
          }),
        );

        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          String day = DateTime.now().day.toString();
          String month = DateTime.now().month.toString();
          String year = DateTime.now().year.toString();

          msgList.insert(
            0,
            MessageModel(
              message: json["choices"][0]["message"]["content"]
                  .toString()
                  .trimLeft(),
              sentByMe: false,
              dateTime: "$day/$month/$year",
            ),
          );
          setState(() {});

          // final ref = FirebaseDatabase.instance
          //     .ref(FirebaseAuth.instance.currentUser!.uid)
          //     .child("Chats");
          // await ref
          //     .push()
          //     .set(
          //       MessageModel(
          //         message: json["choices"][0]["message"]["content"]
          //             .toString()
          //             .trimLeft(),
          //         sentByMe: false,
          //         dateTime: "$day/$month/$year",
          //       ).toJson(),
          //     )
          //     .then((value) {});
        } else {
          print(response.statusCode);
          print(response.body);
          print('Error occurred during API request');
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some error occurred, please try again!"),
        ),
      );
    }
  }

  youtubeDialog(BuildContext context, String url) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MySize.size22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.bgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MySize.size35),
                        Text(
                          'Permission Required',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: MySize.size14),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: Opacity(
                            opacity: 0.50,
                            child: Text(
                              'You are being redirect to www.youtube.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF404040),
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size37),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: CustomButton8(
                            text: "Yes, Continue",
                            backgroundColor: ThemeColors.mainColor,
                            textColor: ThemeColors.bgColor,
                            radius: 8,
                            onPressed: () async {
                              Uri uri = Uri.parse(url);
                              await launchUrl(uri,
                                  mode:
                                      LaunchMode.externalNonBrowserApplication);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size14),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: CustomButton8(
                            text: "No, Back to app",
                            backgroundColor: ThemeColors.fillColor,
                            textColor: ThemeColors.grey2,
                            radius: 8,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size35),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MySize.size62,
              height: MySize.size43,
              child: Image.asset(imgYoutube),
            ),
          ],
        ),
      ),
    );
  }

  chromeDialog(BuildContext context, String url) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MySize.size22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.bgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MySize.size35),
                        Text(
                          'Permission Required',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: MySize.size14),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: Opacity(
                            opacity: 0.50,
                            child: Text(
                              'You are being redirect to www.google.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF404040),
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size37),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: CustomButton8(
                            text: "Yes, Continue",
                            backgroundColor: ThemeColors.mainColor,
                            textColor: ThemeColors.bgColor,
                            radius: 8,
                            onPressed: () async {
                              Uri uri = Uri.parse(url);
                              await launchUrl(uri,
                                  mode:
                                      LaunchMode.externalNonBrowserApplication);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size14),
                        Padding(
                          padding: Spacing.horizontal(MySize.size23),
                          child: CustomButton8(
                            text: "No, Back to app",
                            backgroundColor: ThemeColors.fillColor,
                            textColor: ThemeColors.grey2,
                            radius: 8,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size35),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MySize.size62,
              height: MySize.size43,
              child: Image.asset(imgChrome),
            ),
          ],
        ),
      ),
    );
  }
}
