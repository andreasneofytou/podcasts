import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  Episode(
      this.id,
      this.title,
      this.description,
      this.pubDateInMs,
      this.audio,
      this.audioLength,
      this.image,
      this.thumbnail,
      this.isAudioInvalid,
      this.isExplicitContent,
      this.link);

  String? id;
  String? title;
  String? description;
  @JsonKey(name: 'pub_date_ms')
  int? pubDateInMs;
  String? audio;
  @JsonKey(name: 'audio_length_sec')
  int? audioLength;
  String? image;
  String? thumbnail;
  @JsonKey(name: 'maybe_audio_invalid')
  bool? isAudioInvalid;
  @JsonKey(name: 'explicit_content')
  bool? isExplicitContent;
  String? link;
  // @JsonKey(name: 'total_episodes')

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
