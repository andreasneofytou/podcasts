import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:podcasts/models/podcast.dart';

class PodcastsService {
  static const baseUrl = 'podcasts.neofytou.com';

  Future<Podcast?> fetchPodcast(String podcastId) async {
    final url = Uri.https(
        baseUrl, '/api/v2/podcasts/$podcastId', {'sort': 'recent_first'});
    final response = await http.get(url, headers: {});

    if (response.statusCode == HttpStatus.ok) {
      return Podcast.fromJson(json.decode(response.body));
    }

    return null;
  }

  Future<List<Podcast>> fetchBestPodcasts(
      {int page = 1,
      String region = 'us',
      sort = 'recent_added_first',
      safeMode = true}) async {
    final url = Uri.https(baseUrl, '/api/v2/best_podcasts', {
      'page': page.toString(),
      'region': region,
      'sort': sort,
      'safe_mode': safeMode.toString()
    });

    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return (json.decode(response.body)['podcasts'] as List)
          .map((e) => Podcast.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<Podcast>> searchPodcasts({required String term}) async {
    final url = Uri.https(baseUrl, '/api/v2/search', {
      'q': term,
      'type': 'podcast',
      'only_in': 'title,description,author,audio'
    });

    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return (json.decode(response.body)['results'] as List)
          .map((e) => Podcast.fromJson(e))
          .toList();
    }
    return [];
  }
}
