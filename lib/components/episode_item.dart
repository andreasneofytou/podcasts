import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:podcasts/models/episode.dart';

class EpisodeItem extends StatelessWidget {
  const EpisodeItem({super.key, required this.episode, this.onTap});

  final Function? onTap;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "${DateFormat.MMMd(Platform.localeName).format(DateTime.fromMillisecondsSinceEpoch(episode.pubDateInMs!))} | ${Duration(seconds: episode.audioLength!).toString().split('.').first} mins",
              ),
            ),
            Text(
              episode.title ?? 'No title',
              textAlign: TextAlign.left,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  FilledButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {},
                      label: Text(AppLocalizations.of(context)!.playEpisode)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.playlist_add)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download_outlined)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
