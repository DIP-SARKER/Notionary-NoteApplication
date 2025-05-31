import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/utilities/colors.dart';
import 'package:notes/view/widgets/dateinfo.dart';
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
  late final TextEditingController _titleController;
  final FocusNode _editorFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();

    _controller = quill.QuillController(
      document: widget.isNewNote ? quill.Document() : newNoteController.content,
      selection: const TextSelection.collapsed(offset: 0),
    )..addListener(() {
      newNoteController.content = _controller.document;
    });

    _titleController = TextEditingController(text: newNoteController.title);
    _controller.readOnly = widget.readOnly;
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _controller.readOnly
              ? 'View Note'
              : widget.isNewNote
              ? 'Create Note'
              : 'Edit Note',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () {
            confirmExit(
              context,
              'Confirm Exit',
              'Unsaved changes will be lost. Do you want to exit?',
              () => Navigator.of(context).popUntil((route) => route.isFirst),
            );
          },
        ),
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
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  canRequestFocus: !_controller.readOnly,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                  ),
                  onChanged: (value) {
                    newNotesController.title = value;
                  },
                ),
                const Divider(),
                if (!widget.isNewNote)
                  DateInformation(note: newNotesController.note),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
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
                            !_controller.readOnly
                                ? IconButton(
                                  onPressed: () {
                                    catagorySelection(
                                      context,
                                      newNotesController,
                                    );
                                  },
                                  icon: Icon(Iconsax.add_square, size: 16),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                )
                                : const SizedBox.shrink(),
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
                                AppColors().colorMap[newNotesController
                                    .category] ??
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

  Future<dynamic> confirmExit(
    BuildContext context,
    String title,
    String content,
    onTap,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: onTap, child: const Text('OK')),
          ],
        );
      },
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
