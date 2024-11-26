import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/Pages/home.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/main.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/services/news.dart';
import 'package:news_api_app/utils/constants.dart';
import 'package:news_api_app/widgets/newsCard.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<Article> articles = [];

  Timer? _debounce;

  @override
  void initState() {
    getByQuiery();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Themeprovider selectionTheme = context.watch<Themeprovider>();
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: TextFormField(
            onChanged: (value) {
              getByQuiery();
            },
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: selectionTheme.theme ? greyCardsDark : greyCardsLight,
              prefixIcon: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.arrow_back)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              hintText: "Search",
              suffixIcon: _searchController.text != ''
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        getByQuiery();
                      },
                      icon: Icon(Icons.clear))
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadiusCard)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusCard),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusCard),
                  borderSide: BorderSide.none),
            ),
            controller: _searchController,
          ),
          elevation: 0,
          leadingWidth: 0,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
          controller: _scrollController,
          itemCount: articles?.length ?? 0,
          itemBuilder: (context, index) {
            Article? item = articles[index];
            print(item.urlToImage);
            if (!item.title!.contains('Removed') && item.description != null) {
              return NewsCard(item: item);
            } else {
              return SizedBox();
            }
          },
        ));
  }

  Future getByQuiery() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      ByQuery().getNews(query: _searchController.text).then(
        (value) {
          articles.clear();
          articles.addAll(value);
          setState(() {});
        },
      );
    });
  }
}
