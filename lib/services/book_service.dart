import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/book.dart';

class BookService {
  static const String _baseUrl = 'https://openlibrary.org';
  final Map<String, List<Book>> _cache = {};

  Future<List<Book>> searchBooks(String query) async {
    if (query.isEmpty) return [];

    // Check cache first
    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    final url = Uri.parse('$_baseUrl/search.json'
        '?q=${Uri.encodeComponent(query)}'
        '&limit=50' // Request 50 items at once
        '&fields=key,title,author_name,cover_i,first_sentence,subject,first_publish_year,person' // Only request needed fields
        );

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'}, // Specify JSON response
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final docs = data['docs'] as List;

        // Process data in parallel
        final books = await compute(_processBooks, docs);

        // Cache the results
        _cache[query] = books;

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

// Separate function for parallel processing
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

String _getAuthor(dynamic authors) {
  if (authors is List && authors.isNotEmpty) {
    return authors.first.toString();
  }
  return 'Unknown Author';
}

List<String> _getList(dynamic items) {
  if (items is List) {
    return items.take(5).map((item) => item.toString()).toList();
  }
  return [];
}

String _getYear(dynamic year) {
  if (year != null) {
    return year.toString();
  }
  return '';
}
