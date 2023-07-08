import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:podcasts/components/episode_item.dart';
import 'package:podcasts/components/my_app_bar.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/pages/player_page.dart';
import 'package:podcasts/view_models/library_view_model.dart';
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
        appBar: myAppBar(context, title: podcast?.title),
        body: getBody(podcast, context));
  }

  Widget getBody(Podcast? podcast, BuildContext context) {
    if (podcast == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: CachedNetworkImage(
                        imageUrl: podcast.image ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/disc-vinyl-icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            podcast.title ??
                                AppLocalizations.of(context)!.noTitle,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Row(children: [
                            Expanded(
                              flex: 4,
                              child: FilledButton.icon(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    Provider.of<LibraryViewModel>(context,
                                            listen: false)
                                        .subscribePodcast(podcast);
                                  },
                                  label: Text(
                                      AppLocalizations.of(context)!.subscribe)),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.public)),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share)),
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //     flex: 1,
            //     child: SingleChildScrollView(
            //         child: TextWrapper(text: podcast.description))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${podcast.totalEpisodes.toString()} ${AppLocalizations.of(context)!.episodes}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Expanded(
              flex: 7,
              child: ListView.separated(
                itemCount: podcast.episodes?.length ?? 0,
                itemBuilder: (context, index) {
                  final episode = podcast.episodes?[index];
                  if (episode == null) {
                    return const SizedBox();
                  }
                  return EpisodeItem(
                      episode: episode,
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerPage(
                                      episode: episode,
                                      showTitle: podcast.title ??
                                          AppLocalizations.of(context)!.noTitle,
                                    )),
                          ));
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
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
