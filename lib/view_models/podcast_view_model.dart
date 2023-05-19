import 'package:flutter/foundation.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/services/podcasts_service.dart';

class PodcastViewModel extends ChangeNotifier {
  final _podcastsService = PodcastsService();

  Podcast? _selectedPodcast;
  Podcast? get selectedPodcast => _selectedPodcast;

  PodcastViewModel();

  Future<void> fetchPodcast(String podcastId) async {
    _selectedPodcast = await _podcastsService.fetchPodcast(podcastId);
    notifyListeners();
  }
}
