import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Iconsax.search_normal, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(color: Colors.grey[600]),
                hintText: 'Search notes...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),
        ],
      ),
    );
  }
}
