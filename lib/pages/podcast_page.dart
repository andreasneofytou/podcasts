import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:podcasts/components/episode_item.dart';
import 'package:podcasts/components/text_wrapper.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/pages/player_page.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(podcast?.title ?? AppLocalizations.of(context)!.noTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: getBody(podcast, context));
  }

  RenderObjectWidget getBody(Podcast? podcast, BuildContext context) {
    if (podcast == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: CachedNetworkImage(
                        imageUrl: podcast.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/disc-vinyl-icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        podcast.title,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextWrapper(text: podcast.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${podcast.totalEpisodes.toString()} ${AppLocalizations.of(context)!.episodes}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              height: 2,
            ),
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemCount: podcast.episodes.length,
                itemBuilder: (context, index) {
                  final episode = podcast.episodes[index];
                  return EpisodeItem(
                      episode: episode,
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerPage(
                                      episode: episode,
                                      showTitle: podcast.title,
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
        ),
      );
    }
  }
}
