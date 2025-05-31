import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  Note? _note;
  String _title = '';
  Document _content = Document();
  String _category = "";

  set note(Note? value) {
    _note = value;
    if (_note != null) {
      _title = _note!.title;
      _content = Document.fromJson(jsonDecode(_note!.content));
      _category = _note!.category;
    } else {
      _title = '';
      _content = Document();
      _category = '';
    }
    notifyListeners();
  }

  Note? get note => _note;
  bool get isNewNote => _note == null;

  bool get canSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;

    final contentJson = jsonEncode(_content.toDelta().toJson());

    final String? newContent =
        content.toPlainText().trim().isNotEmpty
            ? content.toPlainText().trim()
            : null;

    bool canSave = newTitle != null || newContent != null;
    if (!isNewNote) {
      canSave =
          canSave &&
          (newTitle != note?.title ||
              contentJson != note?.content ||
              _category != note?.category);
    }
    return canSave;
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
      createdAt: isNewNote ? now : _note!.createdAt,
      modifiedAt: now,
      category: category.isNotEmpty ? category : 'Personal',
    );

    final notesController = context.read<NotesController>();
    isNewNote
        ? notesController.addNote(note)
        : notesController.updateNote(note);
  }
}
