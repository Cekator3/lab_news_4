import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_news_4/repositories/news_repository/DTO/news_list_item.dart';

/// A subsystem for displaying "List of news" widget of "news" page to the user.
class NewsListWidget extends StatelessWidget
{
  final List<NewsListItem> newsList;

  const NewsListWidget({super.key, required this.newsList});

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
                itemCount: newsList.length,
                itemBuilder: (BuildContext context, int index)
                {
                  NewsListItem newsItem = newsList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(
                        newsItem.getTitle(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMd().add_Hm().format(newsItem.getPublicationDate()),
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: ()
                      {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PlaceDetailsPage(placeId: newsItem.getId())
                        //   ),
                        // );
                      },
                    ),
                  );
                },
                  ),
          ),
    );
  }
}
