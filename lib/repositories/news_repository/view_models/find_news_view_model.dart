/// A subsystem for passing data into method "find" of NewsRepository.
class FindNewsViewModel
{
  final String query;
  final DateTime from;
  final DateTime to;
  final bool ignoreWatchedNews;

  FindNewsViewModel({required this.query, required this.from, required this.to, required this.ignoreWatchedNews});
}
