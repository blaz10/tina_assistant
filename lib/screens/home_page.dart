import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/book_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
            const SizedBox(height: AppConstants.mediumPadding),
            const Expanded(
              child: BookGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
