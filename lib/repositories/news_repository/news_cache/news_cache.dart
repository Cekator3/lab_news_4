// ignore_for_file: curly_braces_in_flow_control_structures

import '../DTO/news_details.dart';
import 'news_persistent_storage/news_persistent_storage.dart';

/// A subsystem for interacting with locally stored news data
class NewsCache
{
  static late final List<NewsDetails> _news;
  static late final List<String> _newsIdentifiers;
  static NewsPersistentStorage? _storage;

  bool _isInitialized()
  {
    return _storage != null;
  }

  /// Initializes the [NewsCache]
  Future<void> init() async
  {
    if (_isInitialized())
      return;

    _storage = NewsPersistentStorage();
    await _storage!.init();
    _news = _storage!.getAll();
    _newsIdentifiers = _news.map((newsItem) => newsItem.getId()).toList();
  }

  /// Retrieves all news
	List<NewsDetails> getAll()
  {
    return _news;
  }

  bool _exists(NewsDetails newsItem)
  {
    return _newsIdentifiers.contains(newsItem.getId());
  }

  /// Adds [news]
  ///
  /// If [news] already exists, it will be ignored.
	Future<void> add(List<NewsDetails> news) async
  {
    for (NewsDetails newsItem in news)
    {
      if (_exists(newsItem))
        continue;

      _newsIdentifiers.add(newsItem.getId());
      _news.add(newsItem);
    }

    await _storage!.set(_news);
  }

  /// Updates certain news
  ///
  /// If [newsItem] not exists, nothing will happen.
  Future<void> update(NewsDetails newsItem) async
  {
    if (! _exists(newsItem))
      return;

    int i = _news.indexWhere((item) => item.getId() == newsItem.getId());
    _news[i].markAsWatched();

    await _storage!.set(_news);
  }
}
