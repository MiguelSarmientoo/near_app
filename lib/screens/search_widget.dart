//lib/screens/search_widget.dart
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchWidget({required this.onSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchQuery = '';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                searchQuery = value;
              },
              decoration: const InputDecoration(
                hintText: 'Search for places...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              onSearch(searchQuery);
            },
          ),
        ],
      ),
    );
  }
}
