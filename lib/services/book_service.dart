import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/book.dart';

/// Service class for handling book-related API operations.
/// Manages communication with the OpenLibrary API.
class BookService {
  /// Base URL for the OpenLibrary API
  static const String _baseUrl = 'https://openlibrary.org';

  /// Cache for storing search results to avoid redundant API calls
  final Map<String, List<Book>> _cache = {};

  /// Searches for books using the OpenLibrary API.
  ///
  /// [query] - The search term to look for books
  ///
  /// Returns a list of [Book] objects matching the search query.
  /// Returns an empty list if the query is empty or no results are found.
  Future<List<Book>> searchBooks(String query) async {
    if (query.isEmpty) return [];

    // Check cache first for faster response
    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    final url = Uri.parse('$_baseUrl/search.json'
        '?q=${Uri.encodeComponent(query)}'
        '&limit=50' // Request 50 items at once
        '&fields=key,title,author_name,cover_i,first_sentence,subject,first_publish_year,person');

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final docs = data['docs'] as List;
        final numFound = data['numFound'] as int? ?? 0;


        // Process data in parallel for better performance
        final books = await compute(_processBooks, docs);

        // Only cache if we have all results
        if (books.length >= numFound) {
          _cache[query] = books;
        }

        return books;
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching books: $e');
      rethrow;
    }
  }
}

/// Processes the raw book data from the API response.
/// This runs in a separate isolate for better performance.
List<Book> _processBooks(List<dynamic> docs) {
  return docs.take(50).map((doc) {
    final coverId = doc['cover_i'];
    final coverUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg'
        : null;

    return Book(
      id: doc['key'] ?? '',
      title: doc['title'] ?? 'Unknown Title',
      author: _getAuthor(doc['author_name']),
      coverUrl: coverUrl,
      description:
          doc['first_sentence']?.join(' ') ?? 'No description available',
      categories: _getList(doc['subject']),
      publishedYear: _getYear(doc['first_publish_year']),
      characters: _getList(doc['person']),
    );
  }).toList();
}

/// Extracts the author name from the API response.
String _getAuthor(dynamic authors) {
  if (authors is List && authors.isNotEmpty) {
    return authors.first.toString();
  }
  return 'Unknown Author';
}

/// Converts a dynamic list to a list of strings.
List<String> _getList(dynamic items) {
  if (items is List) {
    return items.take(5).map((item) => item.toString()).toList();
  }
  return [];
}

/// Converts the publication year to a string.
String _getYear(dynamic year) {
  if (year != null) {
    return year.toString();
  }
  return '';
}
