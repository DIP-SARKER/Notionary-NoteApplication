import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  String _title = '';
  Document _content = Document();
  String _category = "";

  bool get canSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;

    final String? newContent =
        content.toPlainText().trim().isNotEmpty
            ? content.toPlainText().trim()
            : null;

    return newTitle != null || newContent != null;
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  set content(Document value) {
    _content = value;
    notifyListeners();
  }


  Document get content => _content;

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  String get category => _category;

  void saveNote(BuildContext context) {
    final String contentJson = jsonEncode(_content.toDelta().toJson());
    
    final String now = DateTime.now().toIso8601String();

    final Note note = Note(
      title: title,
      content: contentJson,
      text: content.toPlainText().trim(),
      createdAt: now,
      modifiedAt: now,
      category: category.isNotEmpty ? category : 'Personal',
    );

    context.read<NotesController>().addNote(note);
  }
}
