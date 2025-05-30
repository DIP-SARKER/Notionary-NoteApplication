import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NotesToolBar extends StatelessWidget {
  const NotesToolBar({super.key, required quill.QuillController controller})
    : _controller = controller;

  final quill.QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return quill.QuillSimpleToolbar(
      controller: _controller,
      config: const quill.QuillSimpleToolbarConfig(
        multiRowsDisplay: false,
        showQuote: false,
        showSearchButton: false,
        showCodeBlock: false,
        showIndent: false,
        showClearFormat: false,
        showLink: false,
        showSmallButton: false,
      ),
    );
  }
}
