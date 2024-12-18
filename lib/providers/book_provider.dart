import 'package:flutter/material.dart';
import '../models/book.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  String _searchQuery = '';
  bool _isLoading = false;

  List<Book> get books => _books;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  void setSearchQuery(String query) {
    _searchQuery = query;
    searchBooks();
  }

  Future<void> searchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      _books = List.generate(
        12,
        (index) => Book(
          id: 'book_$index',
          title: 'Book Title ${index + 1}',
          author: 'Author ${index + 1}',
          coverUrl: null,
        ),
      );
    } catch (e) {
      _books = [];
      debugPrint('Error searching books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
