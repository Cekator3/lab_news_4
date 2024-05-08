// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';
import 'package:lab_news_4/repositories/news_repository/errors/find_news_errors.dart';
import 'package:lab_news_4/repositories/news_repository/news_repository.dart';
import 'package:lab_news_4/repositories/news_repository/view_models/find_news_view_model.dart';

import 'widgets/news_list.dart';

class NewsPage extends StatefulWidget
{
  final NewsChannel channel;

  const NewsPage({super.key, required this.channel});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>
{
  List<NewsListItem> _newsList = [];
  final _searchQueryController = TextEditingController();
  String? _searchQuery;
  DateTime? _searchFrom = DateTime.now();
  DateTime? _searchTo = DateTime.now();
  bool _searchIgnoreWatchedNews = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 0,
          bottom: 0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchQueryController,
              decoration: const InputDecoration(
                hintText: 'Поиск...'
              ),
            ),
            const SizedBox(height: 10),

            // Filters
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("С: ${_searchFrom?.toString().substring(0, 10)}")
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: Text("До: ${_searchFrom?.toString().substring(0, 10)}")
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text(
                'Только не просмотренные',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
              ),
              value: _searchIgnoreWatchedNews,
              onChanged: (value) {
                setState(() {
                  _searchIgnoreWatchedNews = !_searchIgnoreWatchedNews;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            // Submit button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Поиск'),
            )
          ],
        ),
      )
    );
  }
}
