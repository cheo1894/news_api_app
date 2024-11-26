import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_api_app/models/newsModel.dart';

mixin apiNews {
  var client = http.Client();
  String url = "https://newsapi.org/v2";
  var api_key = '8f99a12420ea4c87958c451e4198dd75';
  //'6fee09d37b73458ab8a84f2d1c2a0fad';
}

abstract class News with apiNews {
  Future getNews() async {
    print('Se está ejecutabdi la función');
    return 'Listo';
  }
}

class TopHeadLines with apiNews implements News {
  @override
  Future getNews({int page = 0}) async {
    try {
      String homeUrl = 'top-headlines?category=general&country=us&page=$page&pageSize=10';
      var news = await client.get(Uri.parse('$url/${homeUrl}&apiKey=$api_key'));

      log(news.body.toString());
      if (news.statusCode == 200) {
        CuratedNewsModel response = CuratedNewsModel.fromJson(jsonDecode(news.body));

        return response.articles ?? [];
      }
    } catch (e) {
      return [];
    }
  }
}

class BySourceOrDomain with apiNews implements News {
  @override
  Future getNews({String sourceName = '', String domains = '', int page = 0}) async {
    print('Pagina >>>> $page');
    try {
      String query = createQuery(sourceName: sourceName, domains: domains, page: page);

      print(query);

      var news = await client.get(Uri.parse('$url/${query}&apiKey=$api_key'));

      log(news.body.toString());
      if (news.statusCode == 200) {
        CuratedNewsModel response = CuratedNewsModel.fromJson(jsonDecode(news.body));

        return response.articles ?? [];
      }
    } catch (e) {
      return [];
    }
  }

  String createQuery({String sourceName = '', String domains = '', int page = 0}) {
    String sOrD = '';
    String query = '';

    sOrD =
        '${sourceName != '' ? 'sources=$sourceName&' : ''}${domains != '' ? "domains=$domains" : ""}&language=en${page > 0 ? "&page=$page&pageSize=10" : ""}';

    // if (sourceName != '' && domains == '') {
    //   sOrD = 'sources=$sourceName';
    // } else if (domains != '' && sourceName == '') {
    //   sOrD = 'domains=$domains';
    // } else if (sourceName != '' && domains != '') {
    //   sOrD = 'sources=$sourceName&domains=$domains';
    // }
    query = "everything?$sOrD";
    print('LA Q >>>>>>>>>>>>>>> $query');
    return query;
  }
}

class ByQuery with apiNews implements News {
  @override
  Future getNews({String query = ''}) async {
    try {
      String queryInLink = query == ''
          ? 'top-headlines?category=general&country=us'
          : 'everything?q=$query&language=en';

      String link = '$url/$queryInLink&apiKey=$api_key';

      print('URL >>>>>>>>>>>> $link');

      var res = await client.get(Uri.parse(link));

      log(res.body.toString());

      if (res.statusCode == 200) {
        CuratedNewsModel response = CuratedNewsModel.fromJson(jsonDecode(res.body));
        return response.articles ?? [];
      }
    } catch (e) {
      return [];
    }
  }
}
