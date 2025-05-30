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

  void updateNote(int index, Note newNote) {
    if (index >= 0 && index < _notes.length) {
      _notes[index] = newNote;
      notifyListeners();
    }
  }
}
