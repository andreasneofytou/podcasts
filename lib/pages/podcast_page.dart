import 'package:flutter/material.dart';
import 'package:podcasts/view_models/podcast_view_model.dart';
import 'package:provider/provider.dart';

class PodcastPage extends StatelessWidget {
  final String podcastId;
  const PodcastPage({super.key, required this.podcastId});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<PodcastViewModel>();
    if (model.selectedPodcast == null ||
        model.selectedPodcast!.id != podcastId) {
      model.fetchPodcast(podcastId);
    }
    return Center(
      child: Text(model.selectedPodcast?.title ?? 'No title'),
    );
  }
}
