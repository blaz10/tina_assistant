import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

/// Provider class that manages the state of book searches and results.
/// Uses ChangeNotifier to inform widgets of state changes.
class BookProvider extends ChangeNotifier {
  // Service for handling book-related API calls
  final BookService _bookService = BookService();
  
  // Private state variables
  List<Book> _books = [];        // List of books from search results
  String _searchQuery = '';      // Current search query
  bool _isLoading = false;       // Loading state indicator
  String? _error;                // Error message if any

  // Getters to access state variables
  List<Book> get books => _books;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Updates the search query and fetches new results.
  /// 
  /// [query] - The search term to look for books
  /// 
  /// This method:
  /// 1. Updates the search query
  /// 2. Fetches books from the API
  /// 3. Updates the UI state (loading, error messages)
  Future<void> setSearchQuery(String query) async {
    if (_isLoading) return;

    _searchQuery = query.trim();
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      _books = await _bookService.searchBooks(_searchQuery);
      // Only show error for empty results if we have a search query
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

  /// Resets the search state to initial values.
  /// Clears the search query, results, and any error messages.
  void clearSearch() {
    _searchQuery = '';
    _books = [];
    _error = null;
    notifyListeners();
  }
}
