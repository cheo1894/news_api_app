import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/router/router.dart';
import 'package:news_api_app/services/news.dart';
import 'package:news_api_app/widgets/newsCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  List<Article> news = [];
  int page = 1;
  @override
  void initState() {
    getNews();
    _scrollController.addListener(
      () {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
          page++;
          setState(() {});
          Future.delayed(Duration(microseconds: 500), () {
            getNews();
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Top Headlines'),
          elevation: 0,
          actions: [
            IconButton(onPressed: (){

              context.push('/$search');
            }, icon: Icon(Icons.search))
          ],
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

  Future<void> getNews() async {
    print('Page = $page');
    await TopHeadLines().getNews(page: page).then(
      (value) {
        if (value != null) {
          news.addAll(value);
        }
        setState(() {});
      },
    );
  }
}
