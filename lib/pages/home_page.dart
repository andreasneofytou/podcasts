import 'package:flutter/material.dart';
import 'package:podcasts/pages/podcast_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            child: const Text("Podcast page"),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PodcastPage(
                          podcastId: "9d29eaece0e441cd80e89d9be5505a8b",
                        )))));
  }
}
