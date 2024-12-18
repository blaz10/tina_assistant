import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'constants/app_constants.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const BookSearchApp());
}

class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
