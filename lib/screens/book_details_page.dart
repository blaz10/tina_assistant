import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';
import '../utils/responsive_helper.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(book.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getHorizontalPadding(context),
            vertical: AppConstants.defaultPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ResponsiveHelper.isMobile(context))
                    _buildMobileLayout(context)
                  else
                    _buildDesktopLayout(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(context, 300),
        const SizedBox(height: AppConstants.mediumPadding),
        _buildBookInfo(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(context, 400),
        const SizedBox(width: AppConstants.mediumPadding * 2),
        Expanded(child: _buildBookInfo(context)),
      ],
    );
  }

  Widget _buildCoverImage(BuildContext context, double height) {
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51), // 0.2 * 255 ≈ 51
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: book.coverUrl != null
            ? Image.network(
                book.coverUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(height),
              )
            : _buildPlaceholder(height),
      ),
    );
  }

  Widget _buildPlaceholder(double height) {
    return Container(
      height: height,
      width: height * 0.7,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.book, size: 80, color: Colors.grey),
      ),
    );
  }

  Widget _buildBookInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Text(
          book.author,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: AppConstants.mediumPadding),
        _buildInfoSection('Description', book.description),
        if (book.categories.isNotEmpty)
          _buildInfoSection('Categories', book.categories.join(', ')),
        if (book.publishedYear.isNotEmpty)
          _buildInfoSection('Published', book.publishedYear),
        if (book.characters.isNotEmpty)
          _buildInfoSection('Characters', book.characters.join(', ')),
      ],
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
