import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/models/episode.dart';
import 'package:rxdart/rxdart.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key, required this.episode});

  final Episode episode;

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    initAsync();
  }

  void initAsync() async {
    await audioPlayer.setUrl(widget.episode.audio!);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          StreamBuilder<PositionData>(
              stream: positionDataStream,
              builder: (context, snapshot) {
                return Slider(
                    max: snapshot.data?.durationStream?.inSeconds.toDouble() ??
                        0,
                    min: 0,
                    value: snapshot.data?.position.inSeconds.toDouble() ?? 0,
                    secondaryTrackValue:
                        snapshot.data?.bufferPosition.inSeconds.toDouble(),
                    onChanged: (value) {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
              }),
          StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                return playerButton(snapshot.data);
              }),
        ],
      ))),
    );
  }

  Widget playerButton(PlayerState? playerState) {
    // 1
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      // 2
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: const CircularProgressIndicator(),
      );
    } else if (audioPlayer.playing != true) {
      // 3
      return OutlinedButton.icon(
        icon: const Icon(Icons.play_arrow),
        onPressed: audioPlayer.play,
        label: const Text("Play"),
      );
    } else if (processingState != ProcessingState.completed) {
      // 4
      return OutlinedButton.icon(
        icon: const Icon(Icons.pause),
        label: const Text("Pause"),
        onPressed: audioPlayer.pause,
      );
    } else {
      // 5
      return OutlinedButton.icon(
        icon: const Icon(Icons.replay),
        label: const Text("Replay"),
        onPressed: () => audioPlayer.seek(Duration.zero,
            index: audioPlayer.effectiveIndices!.first),
      );
    }
  }
}

class PositionData {
  PositionData(this.position, this.bufferPosition, this.durationStream);

  Duration position;
  Duration bufferPosition;
  Duration? durationStream;
}
