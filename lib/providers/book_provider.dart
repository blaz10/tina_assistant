import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookProvider extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _books = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  List<Book> get books => _books;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> setSearchQuery(String query) async {
    if (_isLoading) return;

    _searchQuery = query.trim();
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      _books = await _bookService.searchBooks(_searchQuery);
      if (_books.isEmpty && _searchQuery.isNotEmpty) {
        _error = 'No books found for "$_searchQuery"';
      }
    } catch (e) {
      _error = 'Failed to load books. Please try again.';
      _books = [];
      debugPrint('Error searching books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _books = [];
    _error = null;
    notifyListeners();
  }
}
