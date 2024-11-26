import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/Pages/article.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/main.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/router/router.dart';
import 'package:news_api_app/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatelessWidget {
  double width;
  NewsCard({super.key, required this.item, this.width = double.infinity});

  final Article? item;

  @override
  Widget build(BuildContext context) {
    Themeprovider selectionTheme = context.watch<Themeprovider>();
    return GestureDetector(
      onTap: () {
        context.push('/$article', extra: ArticleScreenArguments(article: item));
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: selectionTheme.theme ? greyCardsDark : greyCardsLight,
            borderRadius: BorderRadius.circular(borderRadiusCard)),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadiusCard))),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadiusCard)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item?.urlToImage ?? '',
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Text(
                    item?.title ?? '',
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
                  Text(
                    item?.description ?? '',
                    style: TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
