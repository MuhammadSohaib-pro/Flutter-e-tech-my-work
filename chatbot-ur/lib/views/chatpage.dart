import 'dart:typed_data';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chatbot/Models/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';

import '../../Providers/DialogueFlowHandler.dart';
import '../../widgets/AudioListen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  stt.SpeechToText speech = stt.SpeechToText();
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  String msg = 'nothing';

  @override
  void initState() {
    super.initState();
    //_initSpeech();
  }

  late DialogueFlowHandler dialogueFlowHandler;
  @override
  Widget build(BuildContext context) {
    dialogueFlowHandler = context.read<DialogueFlowHandler>();
    // final now = DateTime.now();
    return Scaffold(
        // bottomNavigationBar: ,
        appBar: AppBar(
            // title: const Text(''),
            ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: context.watch<DialogueFlowHandler>().messsages.isEmpty
                  ? const Center(
                      child: Text(
                      'No messages found',
                    ))
                  : ListView.builder(
                      // reverse: true,
                      shrinkWrap: true,
                      itemCount:
                          context.watch<DialogueFlowHandler>().messsages.length,
                      itemBuilder: (context, index) {
                        Chat chat = dialogueFlowHandler.messsages[index];
                        return chat.isVoice
                            ? BubbleNormalAudio(
                                color: const Color(0xFFE8E8EE),
                                duration: duration.inSeconds.toDouble(),
                                position: position.inSeconds.toDouble(),
                                isPlaying: isPlaying,
                                isLoading: isLoading,
                                isPause: isPause,
                                onSeekChanged: _changeSeek,
                                onPlayPauseButtonClick: () {
                                  print('##############################');
                                  print(chat.message);
                                  msg = chat.message;
                                  _playAudio(chat.message);
                                },
                                sent: true,
                              )
                            : BubbleSpecialThree(
                                text: dialogueFlowHandler
                                    .messsages[index].message,
                                color: chat.fromUser
                                    ? const Color.fromRGBO(138, 138, 236, 1)
                                    : const Color.fromRGBO(178, 178, 237, 1),
                                tail: true,
                                isSender: chat.fromUser);
                      })
              // This trailing comma makes auto-formatting nicer for build methods.
              ,
            ),
            // MessageBar(
            //     actions: const [
            //       Padding(
            //           padding: EdgeInsets.only(left: 10, right: 10),
            //           child: AudioListener())
            //     ],
            //     onSend: (data) {
            //       print('#####################@@@@@@@@@@@@@');
            //       print(data);
            //       dialogueFlowHandler.addMessage(
            //           query: data, isAudio: false, audio: '');
            //     })
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          dialogueFlowHandler.addMessage(
                              query: msg, isAudio: false, audio: '');
                          const AudioListener();
                        },
                        icon: Icon(
                          Icons.mic,
                          size: 50,
                        )),
                  ],
                )
              ],
            )
          ],
        ));
  }

  void _changeSeek(double value) {
    setState(() {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    });
  }

  void _playAudio(audio) async {
    try {
      if (audio != null) {
        setState(() {
          isPlaying = true;
        });
        await audioPlayer.play(DeviceFileSource(audio ?? ''));
      }
    } catch (e) {}
    setState(() {
      isPlaying = false;
    });
  }

  Uint8List doubleListToUint8List(List<double> doubleList) {
    List<int> intList =
        doubleList.map((double value) => value.toInt()).toList();
    return Uint8List.fromList(intList);
  }
}
