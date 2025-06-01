import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/view/widgets/category_row.dart';
import 'package:notes/view/widgets/confirmatio_widget.dart';
import 'package:notes/view/widgets/dateinforow.dart';
import 'package:notes/view/widgets/notes_editor.dart';
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
            ConfirmExitDialog.show(
              context: context,
              title: 'Confirm Exit',
              content: 'Unsaved changes will be lost. Do you want to exit?',
              onConfirm: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
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
                CategoryRow(
                  isReadOnly: _controller.readOnly,
                  controller: newNotesController,
                  onCategorySelected: () => setState(() {}),
                ),
                if (!_controller.readOnly)
                  NotesToolBar(controller: _controller),
                const Divider(thickness: 1, color: Colors.grey),
                NotesEditor(
                  controller: _controller,
                  editorFocusNode: _editorFocusNode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
