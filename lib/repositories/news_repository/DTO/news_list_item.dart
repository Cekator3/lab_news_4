/// A subsystem for reading data from the NewsRepository needed to
/// generate a list of news
class NewsListItem
{
  final String _id;
  final String _title;
  final DateTime _publishedAt;
  final bool _isWatched;

  NewsListItem({required String id, required String title, required DateTime publishedAt, required bool isWatched}) : _id = id, _title = title, _publishedAt = publishedAt, _isWatched = isWatched;

  String getId() => _id;
  String getTitle() => _title;
  DateTime getPublicationDate() => _publishedAt;
  bool isWatched() => _isWatched;
}
