import 'package:flutter/material.dart';
import 'package:notes/models/notesmodel.dart';

class NotesController extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes];

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
}
