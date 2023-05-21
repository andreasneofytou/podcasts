import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerViewModel extends ChangeNotifier {
  int position = 0;
  int bufferPosition = 0;
  int selectedPosition = 0;
  PlayerState? playerState;

  late AudioPlayer _audioPlayer;
  AudioPlayer get audioPlayer => _audioPlayer;

  PlayerViewModel() {
    _audioPlayer = AudioPlayer();
  }

  void setUrl({required String url}) {
    _audioPlayer.setUrl(url);
    notifyListeners();
  }
}
