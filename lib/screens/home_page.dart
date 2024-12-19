import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/book_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/book_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getHorizontalPadding(context),
          vertical: AppConstants.defaultPadding,
        ),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: AppConstants.searchHint,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<BookProvider>().setSearchQuery(value);
                },
              ),
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
