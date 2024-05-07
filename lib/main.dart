// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  final client = http.Client();
  client.get(Uri.parse('https://habr.com/en/rss/articles/?fl=en')).then((response) {
    return response.body;
  }).then((responseBody) {
    final channel = RssFeed.parse(responseBody);
    final item = channel.items[0];
    final author = item.dc!.creator;
    final date = item.pubDate;
    final content = item.description;
    final url = item.link;
    return channel;
  });
  runApp(app);
}
