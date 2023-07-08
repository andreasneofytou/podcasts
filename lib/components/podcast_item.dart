import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/pages/podcast_page.dart';

class PodcastItem extends StatelessWidget {
  final Podcast podcast;
  const PodcastItem({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text(podcast.title!),
    // );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PodcastPage(podcastId: podcast.id))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: CachedNetworkImage(
                    imageUrl: podcast.image ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/disc-vinyl-icon.png',
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        podcast.title ??
                            podcast.titleOriginal ??
                            AppLocalizations.of(context)!.noTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('${podcast.totalEpisodes ?? 0} Podcasts')
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
