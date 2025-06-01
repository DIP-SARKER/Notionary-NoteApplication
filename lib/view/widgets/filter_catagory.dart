import 'package:flutter/material.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/utilities/catagoriesoption.dart';

class FilterCatagory extends StatelessWidget {
  final List<Note> filteredNotes;
  final int selectedCategory;
  final Function(int) onCategorySelected;

  const FilterCatagory({
    super.key,
    required this.filteredNotes,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Catagories().categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => onCategorySelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedCategory == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  Catagories().categories[index],
                  style: TextStyle(
                    color:
                        selectedCategory == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
