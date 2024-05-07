/// A subsystem for reading data from the NewsRepository needed to
/// generate a list of news
class NewsListItem
{
  final String id;
  final String title;
  final DateTime publishedAt;

  NewsListItem({required this.id, required this.title, required this.publishedAt});

  String getId() => id;
  String getTitle() => title;
  DateTime getPublicationDate() => publishedAt;
}
