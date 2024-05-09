// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:lab_news_4/UI/news_page/news_page.dart';
import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_news_4/repositories/news_repository/news_repository.dart';

class NewsApp extends StatefulWidget
{
  final NewsRepository news;

  const NewsApp({super.key, required this.news});

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
            children: [
              NewsPage(
                channel: NewsChannel.archLinux,
                news: widget.news
              ),
              NewsPage(
                channel: NewsChannel.habr,
                news: widget.news
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onNavigationBarLinkTapped,
            selectedItemColor: Colors.cyan,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Arch linux',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Habr',
              ),
            ],
          ),
        )
    );
  }
}

void main() async
{
  NewsRepository news = NewsRepository();
  await news.init();

  NewsApp app = NewsApp(news: news);
  runApp(app);
}
