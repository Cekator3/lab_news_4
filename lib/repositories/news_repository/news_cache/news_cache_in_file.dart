// ignore_for_file: constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import '../DTO/news_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A subsystem for interacting with news data stored in a persistent storage
/// (database or file)
class NewsCacheInFile
{
  static const KEY = 'news';
  static SharedPreferences? _storage;

  /// Initializes the [NewsCacheInFile]
  Future<void> init() async
  {
    _storage = _storage ?? await SharedPreferences.getInstance();
  }

  String _newsToJson(NewsDetails news)
  {
    return jsonEncode({
      'id': news.getId(),
      'title': news.getTitle(),
      'author': news.getAuthor(),
      'publishedAt': news.getPublicationDate().toIso8601String(), // Convert DateTime to ISO 8601 string
      'content': news.getContent(),
      'url': news.getURL(),
    });
  }

  NewsDetails _jsonToNews(String json)
  {
    return NewsDetails(
      id: jsonDecode(json)['id'],
      title: jsonDecode(json)['title'],
      author: jsonDecode(json)['author'],
      publishedAt: DateTime.parse(jsonDecode(json)['publishedAt']),
      content: jsonDecode(json)['content'],
      url: jsonDecode(json)['url'],
    );
  }

  /// Retrieves all news
	List<NewsDetails> getAll()
  {
    if (_storage == null)
      throw Exception('NewsCacheInFile not initialized');

    return _storage!.getStringList(KEY)?.map((json) => _jsonToNews(json)).toList() ?? [];
  }

  /// Replaces all news
	Future<void> set(List<NewsDetails> news) async
  {
    if (_storage == null)
      throw Exception('NewsCacheInFile not initialized');

    await _storage!.setStringList(KEY, news.map((newsItem) => _newsToJson(newsItem)).toList());
  }
}
