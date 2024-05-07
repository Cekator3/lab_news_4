/// A subsystem for reading data about certain news passed from the NewsRepository.
class NewsDetails
{
  final String _id;
  final String _title;
  final String _author;
  final DateTime _publishedAt;
  final String _content;
  final String _url;
  final bool _isWatched;

  NewsDetails({required String id, required String title, required String author, required DateTime publishedAt, required String content, required String url, required bool isWatched}) : _id = id, _title = title, _author = author, _publishedAt = publishedAt, _content = content, _url = url, _isWatched = isWatched;

  String getId() => _id;
  String getTitle() => _title;
  String getAuthor() => _author;
  DateTime getPublicationDate() => _publishedAt;
  String getContent() => _content;
  String getURL() => _url;
  bool isWatched() => _isWatched;
}
