import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NotesEditor extends StatelessWidget {
  const NotesEditor({
    super.key,
    required quill.QuillController controller,
    required FocusNode editorFocusNode,
  }) : _controller = controller,
       _editorFocusNode = editorFocusNode;

  final quill.QuillController _controller;
  final FocusNode _editorFocusNode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
