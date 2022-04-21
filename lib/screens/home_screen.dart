import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/Commons/app_constants.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:news_app/components/home_screen_news_widget.dart';
import 'package:news_app/screens/full_news_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var news;

  var response2;

  int index1 = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<NewsProvider>(context, listen: false).fetchnews(
        searchkeyword: 'apple',
        from: '2022-04-20',
        to: '2022-04-20',
        sortBy: 'popularity',
        apiKey: '6f9b287b42444ca7b8afc123871ba0e5',
        pageSize: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                labelText: 'Search...'),
            onChanged: (value) {
              Provider.of<NewsProvider>(context, listen: false).fetchnews(
                  searchkeyword: value,
                  from: '2022-04-20',
                  to: '2022-04-20',
                  sortBy: 'popularity',
                  apiKey: '6f9b287b42444ca7b8afc123871ba0e5',
                  pageSize: 50);
            },
            onEditingComplete: () => TextInput.finishAutofillContext(),
          ),
        ),
        body: Consumer<NewsProvider>(
          builder: (context, data, child) => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              shrinkWrap: true,
              itemCount: data.news.articles.length,
              itemBuilder: (BuildContext context, int index) {
                index1 = index;
                return data.news.articles.length != 0
                    ? InkWell(
                        child: HomeScreenNewsWidget(
                          newsheadline: data.news.articles[index].title ?? '',
                          newsimage: data.news.articles[index].urlToImage ?? '',
                          smalldescription:
                              data.news.articles[index].description ?? '',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullNewsPage(
                                      data: data.news.articles[index],
                                    )),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.3,
                          color: Colors.grey,
                        ),
                      );
              }),
        ));
  }
}
