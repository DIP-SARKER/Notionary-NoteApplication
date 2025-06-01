import 'package:flutter/material.dart';
import 'package:notes/controllers/newnotescontroller.dart';

Future<void> showCategoryDropdownMenu({
  required BuildContext context,
  required Offset position,
  required NewNoteController controller,
  required VoidCallback onCategorySelected,
}) async {
  final selectedCategory = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx + 1,
      position.dy + 1,
    ),
    items: [
      _buildMenuItem('Personal', Colors.green.shade300),
      _buildMenuItem('Work', Colors.blue.shade400),
      _buildMenuItem('Ideas', Colors.teal.shade300),
      _buildMenuItem('To-Do', Colors.amber.shade700),
    ],
  );

  if (selectedCategory != null) {
    controller.category = selectedCategory;
    onCategorySelected();
  }
}

PopupMenuItem<String> _buildMenuItem(String label, Color color) {
  return PopupMenuItem<String>(
    value: label,
    child: Text(label, style: TextStyle(color: color)),
  );
}
