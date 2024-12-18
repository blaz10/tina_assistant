import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/book_grid.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            BookSearchBar(),
            SizedBox(height: AppConstants.mediumPadding),
            Expanded(
              child: BookGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
