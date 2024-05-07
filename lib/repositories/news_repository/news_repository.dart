// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';
import 'package:lab_news_4/repositories/news_repository/news_filter.dart';

import 'DTO/news_details.dart';
import 'errors/find_news_errors.dart';
import 'errors/update_news_errors.dart';
import 'view_models/find_news_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'package:lab_news_4/repositories/news_repository/news_cache/news_cache.dart';
import 'package:lab_news_4/repositories/news_repository/rss_downloader/rss_downloader.dart';
import 'package:lab_news_4/repositories/news_repository/rss_downloader/errors/rss_fetch_errors.dart';

/// A subsystem for interacting with stored data on news.
class NewsRepository
{
  late final NewsCache? _news;
  late final SharedPreferences? _prefs;

  Future<void> init() async
  {
    if (_news != null)
      return;

    _news = NewsCache();
    await _news!.init();

    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _setSynchronizationDate() async
  {
    await _prefs!.setString('sync_date', DateTime.now().toIso8601String());
  }

  DateTime? _getSynchronizationDate()
  {
    String? syncDateStr = _prefs!.getString('sync_date');
    if (syncDateStr == null)
      return null;
    return DateTime.parse(syncDateStr);
  }

  /// Synchronizes the stored data with the data from news channels
  Future<void> synchronize(UpdateNewsErrors errors) async
  {
    List<NewsDetails> newsList = [];
    final rss = RssDownloader();
    for (NewsChannel channel in NewsChannel.values)
    {
      final fetchErrors = RssFetchErrors();
      newsList.addAll(await rss.fetch(channel, fetchErrors));

      if (fetchErrors.hasAny())
      {
        if (fetchErrors.isInternetConnectionMissing())
          errors.add(errors.INTERNET_CONNECTION_MISSING);
        if (fetchErrors.isInternalErrorOccurred())
          errors.add(errors.INTERNAL);
        break;
      }
    }

    await _news!.add(newsList);
    await _setSynchronizationDate();
  }

  /// Returns the last sync date with news channels
  ///
  /// Returns `null` if sync was never completed at least once.
  DateTime? getLastSynchronizationDate()
  {
    return _getSynchronizationDate();
  }

  /// Retrieves news' information
  ///
  /// Returns `null` if error occurred or news was not found.
  NewsDetails? get(String newsId)
  {
    for (NewsDetails newsItem in _news!.getAll())
      if (newsItem.getId() == newsId)
        return newsItem;
    return null;
  }

  /// Updates [newsItem]
  ///
  /// If [newsItem] not exists, nothing will happen.
  Future<void> update(NewsDetails newsItem) async
  {
    await _news!.update(newsItem);
  }

  List<NewsListItem> _convertNewsDetailsToListItems(List<NewsDetails> news)
  {
    return news.map((e) => NewsListItem(id: e.getId(),
                                        title: e.getTitle(),
                                        channel: e.getChannel(),
                                        publishedAt: e.getPublicationDate(),
                                        isWatched: e.isWatched())).toList();
  }

  /// Retrieves a list of relevant news from news channel
  ///
  /// Returns an empty list if error occurred.
  List<NewsListItem> find(NewsChannel channel,
                          FindNewsViewModel search,
                          FindNewsErrors errors)
  {
    List<NewsListItem> newsList = _convertNewsDetailsToListItems(_news!.getAll());

    // Filtering news
    NewsFilter filter = NewsFilter();
    filter.byChannel(newsList, channel);
    if (search.query != null)
      filter.byQuery(newsList, search.query!);
    if ((search.from != null) || (search.to != null))
    {
      final minDate = DateTime.utc(-271821,04,20);
      final maxDate = DateTime.utc(275760,09,13);

      if ((search.from != null) && (search.to != null))
        filter.byDate(newsList, search.from!, search.to!);
      else if (search.from != null)
        filter.byDate(newsList, search.from!, maxDate);
      else
        filter.byDate(newsList, minDate, search.to!);
    }
    if (search.ignoreWatchedNews)
      filter.onlyNotWatched(newsList);

    return newsList;
  }
}
