import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class BookSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const BookSearchBar({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: AppConstants.searchHint,
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: onChanged,
    );
  }
}
