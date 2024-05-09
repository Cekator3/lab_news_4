// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';
import 'package:lab_news_4/repositories/news_repository/errors/find_news_errors.dart';
import 'package:lab_news_4/repositories/news_repository/errors/update_news_errors.dart';
import 'package:lab_news_4/repositories/news_repository/news_repository.dart';
import 'package:lab_news_4/repositories/news_repository/view_models/find_news_view_model.dart';

class NewsPage extends StatefulWidget
{
  final NewsChannel channel;

  const NewsPage({super.key, required this.channel});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>
{
  final _news = NewsRepository();
  List<NewsListItem> _newsList = [];
  final _searchQueryController = TextEditingController();
  String? _searchQuery;
  DateTime? _searchFrom;
  DateTime? _searchTo;
  bool _searchIgnoreWatchedNews = false;

  void _synchronizeNews() async
  {
    final errors = UpdateNewsErrors();
    await _news.synchronize(errors);

    if (errors.hasAny())
    {
      /// TODO error handling
      return;
    }

    _performSearch();
  }

  void _performSearch() async
  {
    final news = NewsRepository();
    await news.init();
    final search = FindNewsViewModel(
      _searchQuery,
      _searchFrom,
      _searchTo,
      _searchIgnoreWatchedNews
    );
    final errors = FindNewsErrors();
    List<NewsListItem> newsList = _news.find(widget.channel, search, errors);

    if (errors.hasAny())
    {
      /// TODO error handling
      return;
    }

    setState(()
    {
      _newsList = newsList;
    });
  }

  @override
  void initState()
  {
    super.initState();
    () async
    {
      await _news.init();
      _performSearch();
      if (_newsList.isEmpty)
        _synchronizeNews();
    } ();
  }

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
              onChanged: (value)
              {
                setState(() {
                  _searchQuery = value;
                });
                _performSearch();
              },
            ),
            const SizedBox(height: 10),

            // Filters
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("С: ${_searchFrom?.toString().substring(0, 10) ?? "дата начала"}")
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: Text("До: ${_searchFrom?.toString().substring(0, 10) ?? "дата конца"}")
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text(
                'Убрать просмотренные',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
              ),
              value: _searchIgnoreWatchedNews,
              onChanged: (value)
              {
                setState(()
                {
                  _searchIgnoreWatchedNews = !_searchIgnoreWatchedNews;
                });
                _performSearch();
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            // Submit button
            ElevatedButton(
              onPressed: _synchronizeNews,
              child: const Text('Синхронизировать новости'),
            ),
          ],
        ),
      )
    );
  }
}
