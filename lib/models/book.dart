class Book {
  final String id;
  final String title;
  final String author;
  final String? coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      coverUrl: json['coverUrl'] as String?,
    );
  }
}
