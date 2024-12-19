import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/book_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/book_grid.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getHorizontalPadding(context),
          vertical: AppConstants.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SearchBarWidget(
                  onSearch: (query) {
                    context.read<BookProvider>().setSearchQuery(query);
                  },
                ),
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

class BookSearchDelegate extends SearchDelegate<String> {
  final BookProvider bookProvider;

  BookSearchDelegate(this.bookProvider) {
    bookProvider.clearSearch();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          bookProvider.clearSearch();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isNotEmpty) {
      bookProvider.setSearchQuery(query);
    }
    return const BookGrid();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isNotEmpty) {
      bookProvider.setSearchQuery(query);
    }
    return const BookGrid();
  }

  @override
  String get searchFieldLabel => AppConstants.searchHint;
}
