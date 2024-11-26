import 'package:flutter/material.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/services/news.dart';
import 'package:news_api_app/widgets/newsCard.dart';

class SeeMoreScreenArguments {
  Article source;

  SeeMoreScreenArguments({required this.source});
}

class SeeMoreScreen extends StatefulWidget {
  SeeMoreScreenArguments args;
  SeeMoreScreen({super.key, required this.args});

  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  SeeMoreScreenArguments? data;

  ScrollController _scrollController = ScrollController();
  List<Article> news = [];
  int page = 1;

  @override
  void initState() {
    data = widget.args;
    getBysource();
    _scrollController.addListener(
      () {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
          page++;
          setState(() {});
          Future.delayed(Duration(microseconds: 500), () {
            getBysource();
          });
        }
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${data!.source.source!.name ?? ''} news'),
          elevation: 0,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
          controller: _scrollController,
          itemCount: news?.length ?? 0,
          itemBuilder: (context, index) {
            Article? item = news[index];
            print(item.urlToImage);
            if (!item.title!.contains('Removed') && item.description != null) {
              return NewsCard(item: item);
            } else {
              return SizedBox();
            }
          },
        ));
  }

  Future getBysource() async {
    List<String> domain = data!.source.url!.split('/');
    print(domain);
    BySourceOrDomain()
        .getNews(sourceName: data?.source.source?.id ?? '', domains: domain[2], page: page)
        .then(
      (value) {
        news.addAll(value);

        if (data?.source.url != '' && data?.source.url != null) {
          news.removeWhere(
            (element) => element.url == data!.source.url,
          );
        }
        setState(() {});
      },
    );
  }
}
