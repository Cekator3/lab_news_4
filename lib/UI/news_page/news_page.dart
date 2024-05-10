// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_news_4/UI/news_page/widgets/news_list.dart';
import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';
import 'package:lab_news_4/repositories/news_repository/errors/find_news_errors.dart';
import 'package:lab_news_4/repositories/news_repository/errors/update_news_errors.dart';
import 'package:lab_news_4/repositories/news_repository/news_repository.dart';
import 'package:lab_news_4/repositories/news_repository/view_models/find_news_view_model.dart';

class NewsPage extends StatefulWidget
{
  final NewsChannel channel;
  final NewsRepository news;

  const NewsPage({super.key, required this.channel, required this.news});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>
{
  List<NewsListItem> _newsList = [];
  String? _searchQuery;
  DateTime? _searchFrom;
  DateTime? _searchTo;
  bool _searchIgnoreWatchedNews = false;

  void _synchronizeNews() async
  {
    final errors = UpdateNewsErrors();
    await widget.news.synchronize(errors);

    if (errors.hasAny())
    {
      /// TODO error handling
      return;
    }

    _performSearch();
  }

  void _performSearch()
  {
    final search = FindNewsViewModel(
      _searchQuery,
      _searchFrom,
      _searchTo,
      _searchIgnoreWatchedNews
    );
    final errors = FindNewsErrors();
    List<NewsListItem> newsList = widget.news.find(widget.channel, search, errors);

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

  Future<DateTime?> _negotiateDate(DateTime initialDate) async
  {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
    );
  }

  @override
  void initState()
  {
    super.initState();

    _performSearch();
    if (_newsList.isEmpty)
      _synchronizeNews();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости'),
      ),
      body: Column(
        children: [
          Padding(
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
                      onPressed: () async
                      {
                        final date = await _negotiateDate(_searchFrom ?? DateTime.now());
                        if ((date != null) && (date != _searchFrom))
                        {
                          setState(()
                          {
                            _searchFrom = date;
                          });
                          _performSearch();
                        }
                      },
                      child: Text("С: ${_searchFrom?.toString().substring(0, 10) ?? "дата начала"}")
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () async
                      {
                        final date = await _negotiateDate(_searchTo ?? DateTime.now());
                        if ((date != null) && (date != _searchTo))
                        {
                          setState(()
                          {
                            _searchTo = date;
                          });
                          _performSearch();
                        }
                      },
                      child: Text("До: ${_searchTo?.toString().substring(0, 10) ?? "дата конца"}")
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
          ),

          Expanded(
            child: NewsListWidget(newsList: _newsList),
          ),
        ],
      )
    );
  }
}
