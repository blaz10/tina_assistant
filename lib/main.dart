import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'constants/app_constants.dart';
import 'providers/book_provider.dart';
import 'screens/home_page.dart';

/// Entry point of the application.
/// Sets up the provider and theme configuration.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookProvider(),
      child: const BookSearchApp(),
    ),
  );
}

/// Root widget of the application.
/// Configures the app theme and initial route.
class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
