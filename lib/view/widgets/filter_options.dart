import 'package:flutter/material.dart';

Future<void> showDateFilterDropdownMenu({
  required BuildContext context,
  required Offset position,
  required String currentSelection, // Add this
  required void Function(String selected) onSelected,
}) async {
  final selected = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx-1,
      position.dy-1,
    ),
    items: [
      PopupMenuItem<String>(
        value: 'modified',
        enabled: currentSelection != 'modified',
        child: Text(
          'Date Modified',
          style: TextStyle(
            color: currentSelection == 'modified' ? Colors.grey : null,
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'created',
        enabled: currentSelection != 'created',
        child: Text(
          'Date Created',
          style: TextStyle(
            color: currentSelection == 'created' ? Colors.grey : null,
          ),
        ),
      ),
    ],
  );

  if (selected != null) {
    onSelected(selected);
  }
}
