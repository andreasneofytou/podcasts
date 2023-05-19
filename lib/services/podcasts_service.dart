import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:podcasts/models/podcast.dart';

class PodcastsService {
  static const baseUrl = 'localhost:3000';

  Future<Podcast?> fetchPodcast(String podcastId) async {
    final url = Uri.http(
        baseUrl, '/api/v2/podcasts/$podcastId', {'sort': 'recent_first'});
    final response = await http.get(url, headers: {});

    if (response.statusCode == HttpStatus.ok) {
      return Podcast.fromJson(json.decode(response.body));
    }

    return null;
  }
}
