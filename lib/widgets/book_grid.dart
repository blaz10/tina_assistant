import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/book_provider.dart';
import '../utils/responsive_helper.dart';
import 'book_card.dart';

class BookGrid extends StatelessWidget {
  const BookGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        if (bookProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookProvider.error != null) {
          return Center(
            child: Text(
              bookProvider.error!,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }

        if (bookProvider.books.isEmpty && bookProvider.searchQuery.isEmpty) {
          return const Center(
            child: Text(
              'Enter a search term to find books',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper.getGridCrossAxisCount(context).toInt(),
            childAspectRatio: AppConstants.gridChildAspectRatio,
            crossAxisSpacing: ResponsiveHelper.getGridSpacing(context),
            mainAxisSpacing: ResponsiveHelper.getGridSpacing(context),
          ),
          itemCount: bookProvider.books.length,
          itemBuilder: (context, index) {
            return BookCard(book: bookProvider.books[index]);
          },
        );
      },
    );
  }
}
