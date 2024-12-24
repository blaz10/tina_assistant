import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';
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

        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = ResponsiveHelper.isMobile(context);
            final crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
            final aspectRatio = isMobile ? 0.65 : AppConstants.gridChildAspectRatio;
            final spacing = isMobile ? AppConstants.smallPadding : AppConstants.mediumPadding;

            return GridView.builder(
              padding: EdgeInsets.all(spacing),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: bookProvider.books.length,
              itemBuilder: (context, index) => BookCard(book: bookProvider.books[index]),
            );
          },
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width <= 500) return 2;
    if (width <= 800) return 3;
    if (width <= 1100) return 4;
    return 5;
  }
}
