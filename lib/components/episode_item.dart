import 'dart:io';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${DateFormat.MMMd(Platform.localeName).format(DateTime.fromMillisecondsSinceEpoch(episode.pubDateInMs!))} | ${Duration(seconds: episode.audioLength!).toString().split('.').first}"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  episode.title ?? 'No title',
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
