import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_news_4/UI/news_details_page/news_details_page.dart';
import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';
import 'package:lab_news_4/repositories/news_repository/news_repository.dart';

/// A subsystem for displaying "List of news" widget of "news" page to the user.
class NewsListWidget extends StatelessWidget
{
  final NewsRepository news;
  final List<NewsListItem> newsList;

  const NewsListWidget({super.key, required this.news, required this.newsList});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0)
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index)
          {
            NewsListItem newsItem = newsList[index];

            newsItem.getId();
            newsItem.getChannel();
            newsItem.getTitle();
            newsItem.getPublicationDate();

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  newsItem.getTitle(),
                  style:
                  TextStyle(
                    fontWeight: newsItem.isWatched() ? FontWeight.normal : FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  DateFormat('d MMMM y г. H:mm', 'ru').format(newsItem.getPublicationDate()),
                  style: const TextStyle(color: Colors.black),
                ),
                onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailsPage(newsItemId: newsItem.getId(), news: news)
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
