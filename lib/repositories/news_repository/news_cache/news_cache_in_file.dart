import '../DTO/news_details.dart';

/// A subsystem for interacting with news data stored in a persistent storage
/// (database or file)
class NewsCacheInFile
{
  /// Retrieves all news
	Future<List<NewsDetails>> getAll() async
  {
    // ...
  }

  /// Replaces all news
	Future<void> set(List<NewsDetails> news) async
  {
    // ...
  }
}
