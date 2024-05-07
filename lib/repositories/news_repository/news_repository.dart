import 'package:lab_news_4/repositories/enums/news_channel.dart';
import 'errors/find_news_errors.dart';
import 'view_models/find_news_view_model.dart';
import 'errors/update_news_errors.dart';

/// A subsystem for interacting with stored data on news.
class NewsRepository
{
  /// Synchronizes the stored data with the data from news channels
  void update(UpdateNewsErrors errors)
  {
    // ...
  }

  /// Returns the last sync date with news channels
  ///
  /// Returns `null` if sync was never completed at least once.
  DateTime getLastUpdateTime()
  {
    // ...
  }

  /// Retrieves information about certain news.
  ///
  /// Returns `null` if error occurred or news was not found.
  NewsDetails? get(String newsId)
  {

  }

  /// Retrieves a list of relevant news from news channel
  ///
  /// Returns an empty list if error occurred.
  List<NewsListItem> find(NewsChannel channel,
                          FindNewsViewModel search,
                          FindNewsErrors errors)
  {

  }
}
