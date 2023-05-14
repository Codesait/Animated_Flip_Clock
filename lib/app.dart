import 'package:flip_clock/pages/home_page.dart';
import 'package:flip_clock/providers/theme_provider.dart';
import 'package:flip_clock/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  AppThemeNotifier themeChangeProvider = AppThemeNotifier();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  Future<void> getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<AppThemeNotifier>(
        builder: (_, val, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
