import 'package:flip_clock/pages/home_page.dart';
import 'package:flip_clock/src/providers.dart';
import 'package:flip_clock/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ref.watch(themeProvider),
      home: const HomePage(),
    );
  }
}
