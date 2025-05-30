import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:notes/view/widgets/notestoolbar.dart';

class Createoreditpage extends StatefulWidget {
  const Createoreditpage({super.key, required this.isNewNote});
  final bool isNewNote;

  @override
  State<Createoreditpage> createState() => _CreateoreditpageState();
}

class _CreateoreditpageState extends State<Createoreditpage> {
  late final quill.QuillController _controller = quill.QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatDateTime([DateTime? dateTime]) {
    DateTime dt = (dateTime ?? DateTime.now()).toLocal();
    return DateFormat('dd MMMM yyyy, hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNewNote ? 'Create Note' : 'Edit Note',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.direct),
            onPressed: () {
              // Save note logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                fillColor: Colors.transparent,
              ),
            ),
            const Divider(),
            if (!widget.isNewNote)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Last Modified",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            formatDateTime(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Created On",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            formatDateTime(
                              DateTime.now().subtract(
                                const Duration(days: 5, hours: 3, minutes: 27),
                              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Category",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Iconsax.add_square, size: 16),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Personal",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            NotesToolBar(controller: _controller),
            const Divider(thickness: 1, color: Colors.grey),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: quill.QuillEditor.basic(
                  controller: _controller,
                  config: const quill.QuillEditorConfig(
                    placeholder: 'Start writing your note...',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
