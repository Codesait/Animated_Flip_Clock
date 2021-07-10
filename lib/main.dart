import 'package:flip_clock/providers/theme_provider.dart';
import 'package:flip_clock/utils/themData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
       MyApp(),
  );
}

class MyApp extends StatefulWidget{
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AppThemeNotifier themeChangeProvider = new AppThemeNotifier();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<AppThemeNotifier>(
          builder: (_,val,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.themeData(themeChangeProvider.darkTheme, context),
              home: HomePage(),
            );
          },
        ),
      );
  }
  }

