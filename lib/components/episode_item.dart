import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(6),
            height: 75,
            width: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: episode.image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'assets/images/disc-vinyl-icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.MMMd(Platform.localeName).format(
                      DateTime.fromMillisecondsSinceEpoch(
                          episode.pubDateInMs!))),
                  Text(
                    textAlign: TextAlign.left,
                    episode.title ?? 'No title',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(Duration(seconds: episode.audioLength!)
                      .toString()
                      .split('.')
                      .first)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
