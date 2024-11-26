import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/Pages/seeMore.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/main.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/router/router.dart';
import 'package:news_api_app/services/news.dart';
import 'package:news_api_app/utils/constants.dart';
import 'package:news_api_app/widgets/newsCard.dart';
import 'package:news_api_app/widgets/readFullNewsCard.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreenArguments {
  Article? article;

  ArticleScreenArguments({required this.article});
}

class ArticleScreen extends StatefulWidget {
  ArticleScreenArguments? args;

  ArticleScreen({super.key, this.args});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  List<Article> articlesBySource = [];

  ScrollController _scrollController = ScrollController();

  Color? iconsColor;
  Themeprovider? selectionTheme;

  String content = '';

  Article? data;

  @override
  void initState() {
    data = widget.args!.article;
    _scrollController.addListener(
      () {
        if (_scrollController.offset > 194) {
          iconsColor = Colors.transparent;
        } else {
          iconsColor = selectionTheme!.theme ? greyCardsDark : greyCardsLight;
        }
        setState(() {});
      },
    );

    getBysource();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectionTheme = context.watch<Themeprovider>();
    if (!_scrollController.hasClients) {
      iconsColor = selectionTheme!.theme ? greyCardsDark : greyCardsLight;
    }
    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                context.pop(true);
              },
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: iconsColor, borderRadius: BorderRadius.circular(40)),
                child: Icon(Icons.arrow_back_rounded),
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(data?.url ?? '');
                },
                icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(color: iconsColor, borderRadius: BorderRadius.circular(40)),
                    child: Icon(Icons.share_rounded)))
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data?.urlToImage ?? '',
              placeholder: (context, url) => Image.asset(
                placeHolderImage,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                placeHolderImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Gap(20),
                    Text(
                      data?.title ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Gap(20),
                  ],
                ),
                if (data?.description != null && data?.description != '')
                  Column(
                    children: [
                      Text(
                        data?.description ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                      Gap(20),
                    ],
                  ),
                if (data?.content != null && data?.content != '')
                  Column(
                    children: [
                      Text(
                        content + '...',
                        style: TextStyle(fontSize: 16),
                      ),
                      Gap(20),
                    ],
                  ),
                ReadThisFullNewsCard(article: widget.args!.article)
              ],
            ),
          ),
          Gap(20),
          if (articlesBySource.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Read other ${widget.args?.article?.source?.name} news',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          ),
                          onPressed: () {
                            context.push('/$article/$seeMore',
                                extra: SeeMoreScreenArguments(source: data!));
                          },
                          child: Text(
                            'See more',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articlesBySource.length,
                    itemBuilder: (context, index) {
                      Article item = articlesBySource[index];
                      return NewsCard(
                        item: item,
                        width: 320,
                      );
                    },
                  ),
                ),
                Gap(40)
              ],
            )
        ]))
      ]),
    );
  }

  Future getBysource() async {
    List<String> domain = data!.url!.split('/');
    print(domain);
    BySourceOrDomain().getNews(sourceName: data?.source?.id ?? '', domains: domain[2]).then(
      (value) {
        articlesBySource.addAll(value);

        if (data?.url != '' && data?.url != null) {
          articlesBySource.removeWhere(
            (element) => element.url == data!.url,
          );
        }

        setState(() {});
      },
    );
  }

  String cleanContent() {
    List<String> contentList = widget.args?.article?.content?.split('…') ?? [];

    return contentList[0] ?? '';
  }
}
