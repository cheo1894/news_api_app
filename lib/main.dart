import 'package:flutter/material.dart';
import 'package:news_api_app/Pages/home.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/router/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Themeprovider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Themeprovider selectionTheme = context.watch<Themeprovider>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: selectionTheme.theme == false ? ThemeData.light() : ThemeData.dark(),
      routerConfig: router,
    );
  }
}
