import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

double borderRadiusCard = 20.0;
String placeHolderImage = 'assets/images/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg';
Color greyCardsDark = Colors.grey[900]!;
Color greyCardsLight = Colors.grey[300]!;

  Future<void> onLaunchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception("Could nor launch $_url");
    }
  }