class Book {
  final String id;
  final String title;
  final String author;
  final String? coverUrl;
  final String description;
  final List<String> categories;
  final String publishedYear;
  final List<String> characters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverUrl,
    this.description = '',
    this.categories = const [],
    this.publishedYear = '',
    this.characters = const [],
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      coverUrl: json['coverUrl'] as String?,
      description: json['description'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)?.cast<String>() ?? [],
      publishedYear: json['publishedYear'] as String? ?? '',
      characters: (json['characters'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}
