import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();
  Timer? _debounce;
  static const _minQueryLength = 0;
  static const _debounceTime = Duration(milliseconds: 300);

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Only search if query meets minimum length
    if (query.trim().length < _minQueryLength) return;

    _debounce = Timer(_debounceTime, () {
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: AppConstants.searchHint,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: _onSearchChanged,
    );
  }
}
