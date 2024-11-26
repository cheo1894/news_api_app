import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/Pages/article.dart';
import 'package:news_api_app/router/router.dart';
import 'package:news_api_app/widgets/bottomBoxWidget.dart';
import 'package:news_api_app/widgets/navIcons.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBoxWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: NavIcon(
                  onPressed: () {
                    context.go('/');
                  },
                  icon: Icon(
                    Icons.newspaper_rounded,
                    size: 20,
                  ),
                  text: 'News',
                ),
              ),
              Expanded(
                child: NavIcon(
                  onPressed: () {
                    context.go('/$settings');
                  },
                  icon: Icon(
                    Icons.settings_rounded,
                    size: 20,
                  ),
                  text: 'Settings',
                ),
              )
            ],
          ),
        if(Platform.isIOS)
        Gap(10)
        ],
      ),
    );
  }
}
