import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class BookCard extends StatelessWidget {
  final String? title;
  final String? author;
  final String? coverUrl;

  const BookCard({
    super.key,
    this.title,
    this.author,
    this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _buildCoverImage(),
          ),
          Expanded(
            flex: 2,
            child: _buildBookInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    if (coverUrl != null) {
      return Image.network(
        coverUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.book, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.smallPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? 'Book Title',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.titleFontSize,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            author ?? 'Author Name',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: AppConstants.subtitleFontSize,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
