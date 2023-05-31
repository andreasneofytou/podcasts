import 'package:json_annotation/json_annotation.dart';
import 'package:podcasts/models/episode.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
  Podcast(
      this.id,
      this.title,
      this.publisher,
      this.image,
      this.thumbnail,
      this.totalEpisodes,
      this.audioLengthInSecs,
      this.updateFrequencyInHours,
      this.isExplicitContent,
      this.description,
      this.latestPubDate,
      this.earliestPubDate,
      this.nextEpisodePubDate,
      this.language,
      this.country,
      this.website,
      this.episodes);
  String id;
  String? title;
  @JsonKey(name: 'title_highlighted')
  String? titleHighlighted;
  @JsonKey(name: 'title_original')
  String? titleOriginal;
  String? publisher;
  @JsonKey(name: 'publisher_highlighted')
  String? publisherHighlighted;
  @JsonKey(name: 'publisher_original')
  String? publisherOriginal;
  String? image;
  String? thumbnail;
  @JsonKey(name: 'total_episodes')
  int? totalEpisodes;
  @JsonKey(name: 'audio_length_sec')
  int? audioLengthInSecs;
  @JsonKey(name: 'update_frequency_hours')
  int? updateFrequencyInHours;
  @JsonKey(name: 'explicit_content')
  bool isExplicitContent;
  String? description;
  @JsonKey(name: 'description_highlighted')
  String? descriptionHighlighted;
  @JsonKey(name: 'description_original')
  String? descriptionOriginal;
  @JsonKey(name: 'latest_pub_date_ms')
  int? latestPubDate;
  @JsonKey(name: 'earliest_pub_date_ms')
  int? earliestPubDate;
  @JsonKey(name: 'next_episode_pub_date')
  int? nextEpisodePubDate;
  String? language;
  String? country;
  String? website;
  List<Episode>? episodes = [];

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}
