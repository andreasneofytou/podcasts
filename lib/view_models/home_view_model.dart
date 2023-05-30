import 'package:flutter/foundation.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/services/podcasts_service.dart';

class HomeViewModel extends ChangeNotifier {
  final _podcastsService = PodcastsService();

  List<Podcast> _podcasts = [];
  List<Podcast> get podcasts => _podcasts;

  Future<void> fetchPodcasts() async {
    _podcasts = await _podcastsService.fetchBestPodcasts();
    notifyListeners();
  }
}
