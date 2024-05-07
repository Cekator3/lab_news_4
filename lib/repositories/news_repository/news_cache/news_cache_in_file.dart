// ignore_for_file: constant_identifier_names, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:sqflite/sqflite.dart';
import '../DTO/news_details.dart';

/// A subsystem for interacting with news data stored in a persistent storage
/// (database or file)
class NewsCacheInFile
{
  static Database? _DB;

  /// Initializes the [NewsCacheInFile]
  Future<void> init() async
  {
    _DB = _DB ?? await openDatabase(
      '${await getDatabasesPath()}news.db',
      version: 3,
      onCreate: (db, version)
      {
        return db.execute(
          """
          CREATE TABLE news
          (
            id              TEXT   PRIMARY KEY,
            title           TEXT   NOT NULL,
            author          TEXT   NOT NULL,
            published_at    TEXT   NOT NULL,
            content         TEXT   NOT NULL,
            url             TEXT   NOT NULL,
            is_watched      INT    NOT NULL
          );
          """
        );
      }
    );
  }

  NewsDetails _convertMapToNews(Map<String, Object?> map)
  {
    return NewsDetails(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      publishedAt: DateTime.parse(map['published_at'] as String),
      content: map['content'] as String,
      url: map['url'] as String,
      isWatched: map['is_watched'] as int == 1
    );
  }

  /// Retrieves all news
	Future<List<NewsDetails>> getAll() async
  {
    if (_DB == null)
      throw Exception('NewsCacheInFile not initialized');

    List<Map<String, Object?>> maps = await _DB!.query('news');

    return List.generate(maps.length, (index)
    {
      return _convertMapToNews(maps[index]);
    });
  }

  Map<String, Object> _convertNewsToMap(NewsDetails newsItem)
  {
    return {
      'id': newsItem.getId(),
      'title': newsItem.getTitle(),
      'author': newsItem.getAuthor(),
      'published_at': newsItem.getPublicationDate().toIso8601String(),
      'content': newsItem.getContent(),
      'url': newsItem.getURL(),
      'is_watched': newsItem.isWatched() ? 1 : 0
    };
  }

  /// Replaces all news
	Future<void> set(List<NewsDetails> news) async
  {
    if (_DB == null)
      throw Exception('NewsCacheInFile not initialized');

    for (NewsDetails newsItem in news)
    {
      await _DB!.insert(
        'news',
        _convertNewsToMap(newsItem),
        conflictAlgorithm: ConflictAlgorithm.ignore
      );
    }
  }
}
