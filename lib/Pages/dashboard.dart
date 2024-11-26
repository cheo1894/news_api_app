import 'package:flutter/material.dart';
import 'package:news_api_app/widgets/bottomBoxWidget.dart';
import 'package:news_api_app/widgets/navBar.dart';

class DashboardLayout extends StatelessWidget {
  Widget? child;
  DashboardLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {},
        child: Scaffold(body: child, bottomNavigationBar: NavBar()));
  }
}
