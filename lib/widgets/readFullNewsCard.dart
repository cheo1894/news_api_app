import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/main.dart';
import 'package:news_api_app/models/newsModel.dart';
import 'package:news_api_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ReadThisFullNewsCard extends StatelessWidget {
  Article? article;
  ReadThisFullNewsCard({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    Themeprovider selectionTheme = context.watch<Themeprovider>();
    return GestureDetector(
      onTap: () {
        if (article?.url != null) {
          onLaunchUrl(article!.url!);
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: selectionTheme!.theme ? greyCardsDark : greyCardsLight,
            borderRadius: BorderRadiusDirectional.circular(borderRadiusCard)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Read this full news',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Gap(10),
                  Text(
                    'You can read this complete news on ${article?.source?.name ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}