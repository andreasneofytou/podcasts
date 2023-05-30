import 'package:flutter/material.dart';
import 'package:podcasts/components/podcast_item.dart';
import 'package:podcasts/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<HomeViewModel>();
    if (model.podcasts.isEmpty) {
      model.fetchPodcasts();
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: model.podcasts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: model.podcasts.length,
                itemBuilder: (context, index) {
                  final podcast = model.podcasts[index];
                  return PodcastItem(podcast: podcast);
                },
              ));
  }
}
