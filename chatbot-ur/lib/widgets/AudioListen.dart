import 'package:record/record.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../Providers/DialogueFlowHandler.dart';

class AudioListener extends StatefulWidget {
  const AudioListener({super.key});

  @override
  State<AudioListener> createState() => _AudioListenerState();
}

class _AudioListenerState extends State<AudioListener> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool speechEnabled = false;
  bool isListening = false;
  int? sampleRate;

  final record = Record();
  String lastWords = '';

  void handleAudioData(List<int> data) {
    print("Received audio data: ${data.length} bytes");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  recordAudio() async {
    try {
      if (await record.hasPermission()) {
        // Start recording
        await record.start();
      }
    } catch (e) {}
  }

  // String? audiopath;
  // stopRecording() async {
  //   try {
  //     audiopath = await record.stop();
  //   } catch (e) {}
  // }

  // playSound() async {
  //   await AudioPlayer().play(DeviceFileSource(audiopath ?? ''));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (down) async {
        if (!isListening) {
          setState(() {
            isListening = true;
          });
          speechEnabled = await _speechToText.initialize();
          if (speechEnabled) {
            
            await _speechToText.listen(onResult: (res) {
              setState(() {
                lastWords = res.recognizedWords;
              });
            });
          }
        }
      },
      onTapUp: (r) async {
        await _speechToText.stop();
        // stopRecording();
        try {
          // ignore: use_build_context_synchronously
          context
              .read<DialogueFlowHandler>()
              .addMessage(audio: '', query: lastWords, isAudio: true);
          setState(() {
            isListening = false;
          });
        } catch (e) {}
      },
      child: AvatarGlow(
        endRadius: 30,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        glowColor: Colors.red,
        showTwoGlows: true,
        child: CircleAvatar(
            child: Icon(
          isListening ? Icons.mic_off : Icons.mic,
          size: 25,
        )),
      ),
    );
  }
}
