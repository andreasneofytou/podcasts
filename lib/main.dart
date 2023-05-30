import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcasts/pages/discover_page.dart';
import 'package:podcasts/pages/home_page.dart';
import 'package:podcasts/pages/library_page.dart';
import 'package:podcasts/pages/profile_page.dart';
import 'package:podcasts/theme.dart';
import 'package:podcasts/view_models/discover_view_model.dart';
import 'package:podcasts/view_models/home_view_model.dart';
import 'package:podcasts/view_models/player_view_model.dart';
import 'package:podcasts/view_models/podcast_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.neofytou.podcasts',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    initializeDateFormatting(Platform.localeName);
    return const MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => PodcastViewModel()),
          ChangeNotifierProvider(create: (_) => PlayerViewModel()),
          ChangeNotifierProvider(create: (_) => DiscoverViewModel()),
        ],
        child:
            DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [AppLocalizations.delegate],
              supportedLocales: AppLocalizations.supportedLocales,
              title: 'Podcasts',
              themeMode: ThemeMode.system,
              theme: ThemeData(
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                useMaterial3: true,
              ),
              home: const MainPageBody());
        }));
  }
}

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const DiscoverPage(),
    const LibraryPage(),
    const ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.homeTabText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.explore),
              label: AppLocalizations.of(context)!.discoverTabText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.library_books),
              label: AppLocalizations.of(context)!.libraryTabText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: AppLocalizations.of(context)!.profileTabText)
        ],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
