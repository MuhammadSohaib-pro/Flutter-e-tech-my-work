import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatProvider with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _recordingOn = false;
  bool _voiceOn = false;
  String _concatString = "";
  int _voiceOnIndex = -1;

  int get voiceOnIndex => _voiceOnIndex;

  bool get recordingOn => _recordingOn;
  bool get voiceOn => _voiceOn;
  String get concatString => _concatString;

  changeVoiceOnIndexValue(int value) {
    _voiceOnIndex = value;
    notifyListeners();
  }

  changeRecordingValue() {
    _recordingOn = !_recordingOn;
    notifyListeners();
  }

  changeVoiceValue() {
    _voiceOn = !_voiceOn;
    notifyListeners();
  }

  Future<void> startListening() async {
    print("Start Listening");
    _concatString = "";
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void stopListening() async {
    print("Stop Listening");
    await _speechToText.stop();
    print("cancatenated string $_concatString");
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _concatString = result.recognizedWords;
    print("cancatenated string $_concatString");
    notifyListeners();
  }
}
