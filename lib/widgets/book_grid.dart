import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/book_provider.dart';
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

        if (bookProvider.books.isEmpty) {
          return const Center(
            child: Text('No books found'),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppConstants.gridCrossAxisCount,
            childAspectRatio: AppConstants.gridChildAspectRatio,
            crossAxisSpacing: AppConstants.gridSpacing,
            mainAxisSpacing: AppConstants.gridSpacing,
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
