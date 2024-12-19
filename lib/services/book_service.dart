import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  static const String _baseUrl = 'https://openlibrary.org';

  Future<List<Book>> searchBooks(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse('$_baseUrl/search.json?q=${Uri.encodeComponent(query)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final docs = data['docs'] as List;
      
      return docs.take(20).map((doc) {
        final coverId = doc['cover_i'];
        final coverUrl = coverId != null 
          ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg'
          : null;

        return Book(
          id: doc['key'] ?? '',
          title: doc['title'] ?? 'Unknown Title',
          author: _getAuthor(doc['author_name']),
          coverUrl: coverUrl,
          description: doc['first_sentence']?.join(' ') ?? 'No description available',
          categories: _getList(doc['subject']),
          publishedYear: _getYear(doc['first_publish_year']),
          characters: _getList(doc['person']),
        );
      }).toList();
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
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
    return 'Unknown Year';
  }
}
