import 'package:flutter/material.dart';
import 'package:notes/models/notesmodel.dart';

class NotesController extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [
    ..._notes.where((Note note) {
      return note.title.toLowerCase().contains(_searchNote.toLowerCase()) ||
          note.text.toLowerCase().contains(_searchNote.toLowerCase());
    }),
  ];

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void updateNote(Note newNote) {
    final index = _notes.indexWhere(
      (note) => note.createdAt == newNote.createdAt,
    );
    _notes[index] = newNote;
    notifyListeners();
  }

  String _searchNote = "";
  String get searchNote => _searchNote;
  set searchNote(String value) {
    _searchNote = value;
    notifyListeners();
  }
}
