import 'DTO/news_list_item.dart';
import '../enums/news_channel.dart';

/// Subsystem for filtering news list
/// TODO speed improve: removeWhere with all conditions that user needs
class NewsFilter
{
  void byChannel(List<NewsListItem> news, NewsChannel channel)
  {
    news.removeWhere((newsItem) => newsItem.getChannel() != channel);
  }

  bool _isBetweenDates(DateTime date, DateTime start, DateTime end)
  {
    return date.millisecondsSinceEpoch >= start.millisecondsSinceEpoch &&
           date.millisecondsSinceEpoch <= end.millisecondsSinceEpoch;
  }

	// Filters news by date
	void byDate(List<NewsListItem> news, DateTime from, DateTime to)
  {
    news.removeWhere((element) => _isBetweenDates(element.getPublicationDate(), from, to));
  }

	/// Removes watched news
	void onlyNotWatched(List<NewsListItem> news)
  {
    news.removeWhere((element) => element.isWatched());
  }
}
