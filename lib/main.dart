// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:lab_news_4/repositories/news_repository/news_cache/news_cache.dart';
import 'package:lab_news_4/repositories/news_repository/rss_downloader/errors/rss_fetch_errors.dart';
import 'package:lab_news_4/repositories/news_repository/rss_downloader/rss_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'repositories/news_repository/news_cache/news_cache.dart';

class NewsApp extends StatefulWidget
{
  const NewsApp({super.key});

  @override
  NewsAppState createState() => NewsAppState();
}

class NewsAppState extends State<NewsApp>
{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context)
  {
    void onNavigationBarLinkTapped(int index) async
    {
      setState(() {
        currentIndex = index;
      });
    }

    return MaterialApp(
        title: 'Новости',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
                onSurface: Colors.white,
                onBackground: Colors.cyan,
            ),
            textTheme: GoogleFonts.manropeTextTheme(
              const TextTheme(
                bodyMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                bodySmall: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )
              )
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.cyan,
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
            ),
        ),
        home: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              // PlacesPage(),
              // FavoritePlacesPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onNavigationBarLinkTapped,
            selectedItemColor: Colors.cyan,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.remove_red_eye),
                label: 'Просмотренное',
              ),
            ],
          ),
        )
    );
  }
}

void main() async
{
  NewsApp app = const NewsApp();
  runApp(app);

  final rss = RssDownloader();
  final errors = RssFetchErrors();
  final news = await rss.fetch(NewsChannel.habr, errors);

  final cache = NewsCache();
  await cache.init();
  cache.add(news);
  final newsFromCache = cache.getAll();
  print('lol');
}
