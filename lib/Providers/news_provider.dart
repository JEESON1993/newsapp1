import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Commons/app_constants.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  var response2;
  NewsModel news = NewsModel(status: '', totalResults: 0, articles: []);

  var response;

  Future<NewsModel> fetchnews(
      {searchkeyword, from, to, sortBy, apiKey, pageSize}) async {
    NewsModel result = NewsModel(status: '', totalResults: 0, articles: []);
    try {
      String url =
          'https://newsapi.org/v2/everything?q=$searchkeyword&from=$from&from=$to&sortBy=$sortBy&apikey=$apiKey&pageSize=$pageSize';
      print(url);

      // final Uri url = Uri.https(Uri.parse(url), {
      //   "q": searchkeyword,
      //   "from": from,
      //   "to": to,
      //   "sortBy": sortBy,
      //   "apiKey": apiKey,
      //   "pageSize": pageSize
      // });
      try {
        response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );
      } catch (e) {
        print(e);
      }

      print(response.body);
      var data = jsonDecode(response.body);

      news = NewsModel.fromJson(data);
      response2 = response.statusCode;
      if (response.statusCode == 200) {}
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return result;
  }
}
