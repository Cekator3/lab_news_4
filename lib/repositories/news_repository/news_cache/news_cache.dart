import '../DTO/news_details.dart';

/// A subsystem for interacting with locally stored news data
abstract class NewsCache
{
  /// Retrieves all news
	List<NewsDetails> getAll();

  /// Replaces all news
	void set(List<NewsDetails> news);
}
