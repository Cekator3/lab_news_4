/// A subsystem for passing data into method "find" of NewsFeedReader.
class ReadNewsFeedViewModel
{
  final String query;
  final DateTime from;
  final DateTime to;
  final bool ignoreWatchedNews;

  ReadNewsFeedViewModel({required this.query, required this.from, required this.to, required this.ignoreWatchedNews});
}
