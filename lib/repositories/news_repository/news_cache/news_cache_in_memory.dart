import '../DTO/news_details.dart';

/// A subsystem for interacting with news data stored in memory
class NewsCacheInMemory
{
  List<NewsDetails> _news = [];

  /// Retrieves all news
	List<NewsDetails> getAll()
  {
    return _news;
  }

  /// Replaces all news
	void set(List<NewsDetails> news)
  {
    _news = news;
  }
}
