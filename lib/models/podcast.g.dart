// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      json['id'] as String,
      json['title'] as String?,
      json['publisher'] as String?,
      json['image'] as String?,
      json['thumbnail'] as String?,
      json['total_episodes'] as int?,
      json['audio_length_sec'] as int?,
      json['update_frequency_hours'] as int?,
      json['explicit_content'] as bool,
      json['description'] as String,
      json['latest_pub_date_ms'] as int?,
      json['earliest_pub_date_ms'] as int?,
      json['next_episode_pub_date'] as int?,
      json['language'] as String?,
      json['country'] as String?,
      json['website'] as String?,
      (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publisher': instance.publisher,
      'image': instance.image,
      'thumbnail': instance.thumbnail,
      'total_episodes': instance.totalEpisodes,
      'audio_length_sec': instance.audioLengthInSecs,
      'update_frequency_hours': instance.updateFrequencyInHours,
      'explicit_content': instance.isExplicitContent,
      'description': instance.description,
      'latest_pub_date_ms': instance.latestPubDate,
      'earliest_pub_date_ms': instance.earliestPubDate,
      'next_episode_pub_date': instance.nextEpisodePubDate,
      'language': instance.language,
      'country': instance.country,
      'website': instance.website,
      'episodes': instance.episodes,
    };
