import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcasts/components/my_app_bar.dart';
import 'package:podcasts/models/episode.dart';
import 'package:rxdart/rxdart.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.episode, required this.showTitle});

  final Episode episode;
  final String showTitle;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    initAsync();
  }

  void initAsync() async {
    await audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.episode.audio!),
        tag: MediaItem(
            id: widget.episode.id!,
            title: widget.episode.title!,
            artUri: Uri.parse(widget.episode.image!))));
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
      appBar: myAppBar(context, title: widget.episode.title),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.episode.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/disc-vinyl-icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.episode.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.showTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: Divider(height: 1, thickness: 1),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                StreamBuilder<PositionData>(
                    stream: positionDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Slider(
                          value: 0,
                          onChanged: null,
                        );
                      } else {
                        var PositionData(
                          :position,
                          :bufferPosition,
                          :durationStream
                        ) = snapshot.data!;
                        return Column(
                          children: [
                            Slider(
                                max: durationStream?.inSeconds.toDouble() ?? 0,
                                min: 0,
                                value: position.inSeconds.toDouble(),
                                secondaryTrackValue:
                                    bufferPosition.inSeconds.toDouble(),
                                onChanged: (value) {
                                  audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                }),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(position.toString().split('.').first),
                                  Text(durationStream
                                      .toString()
                                      .split('.')
                                      .first)
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.replay_10_outlined),
                      onPressed: () => audioPlayer.seek(Duration(
                          seconds: audioPlayer.position.inSeconds - 10)),
                    ),
                    StreamBuilder<PlayerState>(
                        stream: audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          return playerButton(snapshot.data);
                        }),
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.forward_30_outlined),
                      onPressed: () => audioPlayer.seek(Duration(
                          seconds: audioPlayer.position.inSeconds + 30)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget playerButton(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    const iconSize = 100.0;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: iconSize,
        height: iconSize,
        child: const CircularProgressIndicator(),
      );
    } else if (audioPlayer.playing != true) {
      return IconButton(
        iconSize: iconSize,
        // color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.play_circle_fill),
        onPressed: audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        iconSize: iconSize,
        icon: const Icon(
          Icons.pause,
        ),
        onPressed: audioPlayer.pause,
      );
    } else {
      return IconButton(
        iconSize: iconSize,
        icon: const Icon(Icons.replay_outlined),
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
