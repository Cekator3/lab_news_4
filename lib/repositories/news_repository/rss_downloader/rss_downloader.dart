import 'package:lab_news_4/repositories/enums/news_channel.dart';
import '../DTO/news_details.dart';
import 'errors/rss_fetch_errors.dart';

/// A subsystem for fetching news from RSS news feeds
class RssDownloader
{
  /// Fetches news from RSS news feed
  ///
  /// Returns an empty list if error occurred
	List<NewsDetails> fetch(NewsChannel channel, RssFetchErrors errors)
	{
		// ...
	}
}
