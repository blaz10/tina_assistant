import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/book_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/book_grid.dart';
import '../widgets/search_bar_widget.dart';

/// Main screen of the application.
/// Displays the search bar and book grid.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        //title: const Text(AppConstants.appTitle),
        //centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getHorizontalPadding(context),
          vertical: AppConstants.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar with maximum width constraint
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SearchBarWidget(
                  onSearch: (query) {
                    // Update search query in provider
                    context.read<BookProvider>().setSearchQuery(query);
                  },
                ),
              ),
            ),
            const SizedBox(height: AppConstants.mediumPadding),
            // Grid of book results
            const Expanded(
              child: BookGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
