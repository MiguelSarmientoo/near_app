//lib/widgets/search_bar.dart

import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Buscar ubicación",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
      onSubmitted: (value) {
        Navigator.pushNamed(context, '/map');
      },
    );
  }
}
