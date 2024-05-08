import 'package:lab_news_4/repositories/news_repository/DTO/news_details.dart';

import 'DTO/news_list_item.dart';
import '../enums/news_channel.dart';

/// Subsystem for filtering news list
/// TODO speed improve: removeWhere with all conditions that user needs
class NewsFilter
{
  void byQuery(List<NewsDetails> news, String query)
  {
    news.removeWhere((newsItem) => newsItem.getTitle().contains(query, 0) ||
                                   newsItem.getContent().contains(query, 0));
  }

  void byChannel(List<NewsDetails> news, NewsChannel channel)
  {
    news.removeWhere((newsItem) => newsItem.getChannel() != channel);
  }

  bool _isBetweenDates(DateTime date, DateTime start, DateTime end)
  {
    return date.millisecondsSinceEpoch >= start.millisecondsSinceEpoch &&
           date.millisecondsSinceEpoch <= end.millisecondsSinceEpoch;
  }

	// Filters news by date
	void byDate(List<NewsDetails> news, DateTime from, DateTime to)
  {
    news.removeWhere((element) => _isBetweenDates(element.getPublicationDate(), from, to));
  }

	/// Removes watched news
	void onlyNotWatched(List<NewsDetails> news)
  {
    news.removeWhere((element) => element.isWatched());
  }
}
