import 'package:flutter/foundation.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/services/podcasts_service.dart';

class DiscoverViewModel extends ChangeNotifier {
  final _podcastsService = PodcastsService();

  List<Podcast>? _trendingPodcasts;
  List<Podcast> get trendingPodcasts => _trendingPodcasts ?? [];

  DiscoverViewModel();

  Future<void> fetchTrendingPodcasts() async {
    _trendingPodcasts = await _podcastsService.fetchBestPodcasts();
    notifyListeners();
  }
}
