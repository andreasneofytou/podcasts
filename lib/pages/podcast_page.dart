import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/components/episode_item.dart';
import 'package:podcasts/pages/episode_page.dart';
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
    var podcast = model.selectedPodcast;
    if (podcast == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CachedNetworkImage(
                imageUrl: podcast.image,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'assets/images/disc-vinyl-icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              podcast.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: podcast.episodes.length,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final episode = podcast.episodes[index];
                return EpisodeItem(
                    episode: episode,
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EpisodePage(
                                    episode: episode,
                                  )),
                        ));
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
          )
        ],
      );
    }
  }
}
