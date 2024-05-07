/// A subsystem for reading data about certain news passed from the NewsRepository.
class NewsDetails
{
  final String id;
  final String title;
  final String author;
  final DateTime publishedAt;
  final String content;
  final String url;

  NewsDetails({required this.id, required this.title, required this.author, required this.publishedAt, required this.content, required this.url});

  String getId() => id;
  String getTitle() => title;
  String getAuthor() => author;
  DateTime getPublicationDate() => publishedAt;
  String getContent() => content;
  String getURL() => url;
}
