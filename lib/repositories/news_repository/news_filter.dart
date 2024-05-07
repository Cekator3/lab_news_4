import '../enums/news_channel.dart';
import 'DTO/news_list_item.dart';

/// Subsystem for filtering news list
class NewsFilter
{
  void byChannel(List<NewsListItem> news, NewsChannel channel)
  {
    // ...
  }

	// Filters news by date
	void byDate(List<NewsListItem> news, DateTime from, DateTime to)
  {
    // ...
  }

	/// Removes watched news
	void onlyNotWatched(List<NewsListItem> news)
  {
    // ...
  }
}
