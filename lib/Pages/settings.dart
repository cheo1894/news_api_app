import 'package:flutter/material.dart';
import 'package:news_api_app/Providers/themeProvider.dart';
import 'package:news_api_app/main.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Themeprovider selecctionTheme = context.watch<Themeprovider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(
              'Dark theme',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            value: selecctionTheme.theme,
            onChanged: (value) {
              context.read<Themeprovider>().saveTheme(!selecctionTheme.theme);
            },
          )
        ],
      ),
    );
  }
}
