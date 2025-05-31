import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/view/widgets/notestoolbar.dart';
import 'package:provider/provider.dart';

class Createoreditpage extends StatefulWidget {
  const Createoreditpage({
    super.key,
    required this.isNewNote,
    required this.readOnly,
  });
  final bool isNewNote;
  final bool readOnly;

  @override
  State<Createoreditpage> createState() => _CreateoreditpageState();
}

class _CreateoreditpageState extends State<Createoreditpage> {
  late quill.QuillController _controller = quill.QuillController.basic();
  late final NewNoteController newNoteController;
  final FocusNode _editorFocusNode = FocusNode();

  Map<String, Color> colorMap = {
    'Personal': Colors.green.shade300,
    'Work': Colors.blue.shade400,
    'Ideas': Colors.teal.shade300,
    'To-Do': Colors.amber.shade700,
  };

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NewNoteController>();
    _controller =
        quill.QuillController.basic()..addListener(() {
          newNoteController.content = _controller.document;
        });
    _controller.readOnly = widget.readOnly;
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  String formatDateTime([DateTime? dateTime]) {
    DateTime dt = (dateTime ?? DateTime.now()).toLocal();
    return DateFormat(
      'MMM dd, yyyy – hh:mm a',
    ).format(DateTime.parse(dt.toIso8601String()));
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
            icon:
                _controller.readOnly
                    ? Icon(Iconsax.receipt_edit)
                    : Icon(Iconsax.book_saved),
            onPressed: () {
              setState(() {
                _controller.readOnly = !_controller.readOnly;
              });
            },
          ),

          Selector<NewNoteController, bool>(
            selector: (_, newNoteController) => newNoteController.canSaveNote,
            builder:
                (_, canSaveNote, __) => IconButton(
                  icon: const Icon(Iconsax.direct),
                  onPressed:
                      canSaveNote
                          ? () {
                            newNoteController.saveNote(context);
                            Navigator.pop(context);
                          }
                          : null,
                ), // NoteIconButtonOutlined
          ),
        ],
      ),
      body: Consumer<NewNoteController>(
        builder: (context, newNotesController, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  canRequestFocus: !_controller.readOnly,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                  ),
                  onChanged: (value) {
                    newNotesController.title = value;
                  },
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
                                    const Duration(
                                      days: 5,
                                      hours: 3,
                                      minutes: 27,
                                    ),
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
                              onPressed: () {
                                catagorySelection(context, newNotesController);
                              },
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
                          newNotesController.category.isNotEmpty
                              ? newNotesController.category
                              : 'Not Selected',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                colorMap[newNotesController.category] ??
                                Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_controller.readOnly)
                  NotesToolBar(controller: _controller),
                const Divider(thickness: 1, color: Colors.grey),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: Colors.black,
                        ),
                      ),
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        focusNode: _editorFocusNode,
                        config: const quill.QuillEditorConfig(
                          placeholder: 'Start writing your note...',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> catagorySelection(
    BuildContext context,
    NewNoteController newNotesController,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Personal',
                  style: TextStyle(color: Colors.green.shade300),
                ),
                onTap: () {
                  // Set category to Personal
                  newNotesController.category = 'Personal';
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Work',
                  style: TextStyle(color: Colors.blue.shade400),
                ),
                onTap: () {
                  newNotesController.category = 'Work';
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Ideas',
                  style: TextStyle(color: Colors.teal.shade300),
                ),
                onTap: () {
                  newNotesController.category = 'Ideas';
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'To-Do',
                  style: TextStyle(color: Colors.amber.shade700),
                ),
                onTap: () {
                  newNotesController.category = 'To-Do';
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
