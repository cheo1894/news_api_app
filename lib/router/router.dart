import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_api_app/Pages/article.dart';
import 'package:news_api_app/Pages/dashboard.dart';
import 'package:news_api_app/Pages/home.dart';
import 'package:news_api_app/Pages/search.dart';
import 'package:news_api_app/Pages/seeMore.dart';
import 'package:news_api_app/Pages/settings.dart';
import 'package:news_api_app/models/newsModel.dart';

String article = 'article';
String search = 'search';
String settings = 'settings';
String seeMore = 'seeMore';
final GoRouter router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  ShellRoute(
      builder: (context, state, child) {
        return DashboardLayout(
          child: child,
        );
      },
      routes: [
        AppRoute(route: '/', page: HomeScreen(), routes: []),
        AppRoute(route: '/$settings', page: SettingsScreen())
      ]),
  AppRoute(route: '/$search', page: SearchScreen()),
  GoRoute(
    path: '/$article',
    builder: (context, state) {
      final arg = state.extra as ArticleScreenArguments;
      return ArticleScreen(
        args: arg,
      );
    },
  ),
  GoRoute(
    path: '/$article/$seeMore',
    builder: (context, state) {
      final arg = state.extra as SeeMoreScreenArguments;

      return SeeMoreScreen(args: arg);
    },
  ),
]);

AppRoute({required String route, required Widget page, List<RouteBase> routes = const []}) {
  return GoRoute(
      path: route,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: page,
          transitionDuration: const Duration(milliseconds: 0),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.ease).animate(animation),
              child: child,
            );
          },
        );
      },
      routes: routes);
}
