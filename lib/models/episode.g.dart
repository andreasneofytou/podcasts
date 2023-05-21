// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['id'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['pub_date_ms'] as int?,
      json['audio'] as String?,
      json['audio_length_sec'] as int?,
      json['image'] as String?,
      json['thumbnail'] as String?,
      json['maybe_audio_invalid'] as bool?,
      json['explicit_content'] as bool?,
      json['link'] as String?,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'pub_date_ms': instance.pubDateInMs,
      'audio': instance.audio,
      'audio_length_sec': instance.audioLength,
      'image': instance.image,
      'thumbnail': instance.thumbnail,
      'maybe_audio_invalid': instance.isAudioInvalid,
      'explicit_content': instance.isExplicitContent,
      'link': instance.link,
    };
