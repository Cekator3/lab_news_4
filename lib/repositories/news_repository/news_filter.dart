import 'DTO/news_list_item.dart';

/// Subsystem for filtering news list
class NewsFilter
{
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
