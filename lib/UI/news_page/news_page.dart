// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
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
  String? _searchQuery;
  DateTime? _searchFrom;
  DateTime? _searchTo;
  bool _searchIgnoreWatchedNews = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости'),
        actions: [
        ],
      ),
      // body:
    );
  }
}
