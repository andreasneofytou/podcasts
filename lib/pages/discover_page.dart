import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:podcasts/components/podcast_item.dart';
import 'package:podcasts/pages/podcast_page.dart';
import 'package:podcasts/view_models/discover_view_model.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  late StreamSubscription<bool> keyboardSubscription;

  bool hasFocus = false;
  String query = '';

  void queryListener() {
    setState(() {
      query = textEditingController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    textEditingController = TextEditingController()..addListener(queryListener);

    focusNode = FocusNode()
      ..addListener(() {
        setState(() {
          hasFocus = focusNode.hasFocus;
        });
      });

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      visible ? focusNode.requestFocus() : focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    textEditingController.removeListener(queryListener);
    textEditingController.dispose();
    focusNode.dispose();
    keyboardSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<DiscoverViewModel>();

    if (model.trendingPodcasts.isEmpty) {
      model.fetchTrendingPodcasts();
    }
    if (query.isNotEmpty) {
      model.searchPodcasts(query: query);
    }
    return Column(children: getBody(model));
  }

  List<Widget> getBody(DiscoverViewModel model) {
    var bar = Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        controller: textEditingController,
        focusNode: focusNode,
        trailing: query.isNotEmpty
            ? [
                IconButton(
                    onPressed: () {
                      textEditingController.clear();
                    },
                    icon: const Icon(Icons.clear))
              ]
            : null,
        elevation: MaterialStateProperty.all(2),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)))),
        leading: const Icon(Icons.search),
        hintText: AppLocalizations.of(context)!.search,
      ),
    );

    if (hasFocus || query.isNotEmpty) {
      List<Widget> barWithResults = [bar];
      barWithResults.add(getResults(model));
      return barWithResults;
    }

    List<Widget> all = [bar];
    all.addAll(getContent(model));

    return all;
  }

  List<Widget> getContent(DiscoverViewModel model) {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.popularAndTrending,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.seeAll))
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: ListView.builder(
            padding: const EdgeInsets.only(right: 16),
            itemCount: model.trendingPodcasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final podcast = model.trendingPodcasts[index];
              return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PodcastPage(podcastId: podcast.id))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                              imageUrl: podcast.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                    "assets/images/disc-vinyl-icon.png",
                                    fit: BoxFit.cover,
                                  )))));
            }),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.mostListened,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.seeAll))
          ],
        ),
      ),
      Expanded(
          flex: 5,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: model.trendingPodcasts.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: model.trendingPodcasts.length,
                      itemBuilder: (context, index) {
                        final podcast = model.trendingPodcasts[index];
                        return PodcastItem(podcast: podcast);
                      },
                    )))
    ];
  }

  Widget getResults(DiscoverViewModel model) {
    return Expanded(
        flex: 1,
        child: model.searchResults.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.resultsAppear))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: model.searchResults.length,
                  itemBuilder: (context, index) {
                    return PodcastItem(podcast: model.searchResults[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                    );
                  },
                ),
              ));
  }
}
