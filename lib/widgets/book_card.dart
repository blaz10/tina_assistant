import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';
import '../screens/book_details_page.dart';
import '../utils/responsive_helper.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: _buildCoverImage(),
            ),
            Expanded(
              flex: ResponsiveHelper.isMobile(context) ? 4 : 3,
              child: _buildBookInfo(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      ),
    );
  }

  Widget _buildCoverImage() {
    if (book.coverUrl != null) {
      return Image.network(
        book.coverUrl!,
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

  Widget _buildBookInfo(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isMobile ? 12.0 : AppConstants.titleFontSize,
      height: 1.2,
    );
    final authorStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: isMobile ? 11.0 : AppConstants.subtitleFontSize,
      height: 1.2,
    );

    return Padding(
      padding: EdgeInsets.all(isMobile ? 6.0 : AppConstants.smallPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            book.title,
            style: titleStyle,
            maxLines: isMobile ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            book.author,
            style: authorStyle,
            maxLines: isMobile ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
