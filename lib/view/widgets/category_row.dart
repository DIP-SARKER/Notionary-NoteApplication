import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/utilities/colors.dart';
import 'package:notes/view/widgets/categoryselection.dart';

class CategoryRow extends StatelessWidget {
  final bool isReadOnly;
  final NewNoteController controller;
  final VoidCallback onCategorySelected;

  const CategoryRow({
    super.key,
    required this.isReadOnly,
    required this.controller,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 4),
                if (!isReadOnly)
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Iconsax.add_square, size: 16),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          final box = context.findRenderObject() as RenderBox;
                          final position = box.localToGlobal(Offset.zero);

                          await showCategoryDropdownMenu(
                            context: context,
                            position: position,
                            controller: controller,
                            onCategorySelected: onCategorySelected,
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              controller.category.isNotEmpty
                  ? controller.category
                  : 'Not Selected',
              style: TextStyle(
                fontSize: 16,
                color:
                    AppColors().colorMap[controller.category] ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
