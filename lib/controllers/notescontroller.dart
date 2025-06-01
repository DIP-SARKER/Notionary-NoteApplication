import 'package:flutter/material.dart';
import 'package:notes/models/notesmodel.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class NotesController extends ChangeNotifier {
  final List<Note> _notes = [];

  NotesController() {
    _init();
  }

  Future<void> _init() async {
    final loadedNotes = await loadAllNotesFromFiles();
    _notes.addAll(loadedNotes);
    notifyListeners();
  }

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

  Future<void> saveNoteToFile(Note note) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory notionaryDir = Directory('${appDocDir.path}/Notionary');

    if (!await notionaryDir.exists()) {
      await notionaryDir.create(recursive: true);
    }

    // Sanitize filename: use timestamp or title (safe for file systems)
    final safeFileName = note.title.replaceAll(RegExp(r'[^\w\s-]'), '_');
    final fileName = '${safeFileName}_${note.createdAt}.json';
    final File file = File('${notionaryDir.path}/$fileName');

    final String jsonString = jsonEncode(note.toJson());

    await file.writeAsString(jsonString);
  }

  Future<void> saveAllNotesSeparately(List<Note> notes) async {
    for (var note in notes) {
      await saveNoteToFile(note);
    }
  }

  Future<List<Note>> loadAllNotesFromFiles() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory notionaryDir = Directory('${appDocDir.path}/Notionary');

    if (!await notionaryDir.exists()) return [];

    final List<Note> notes = [];

    final files = notionaryDir.listSync();
    for (var file in files) {
      if (file is File && file.path.endsWith('.json')) {
        final jsonString = await file.readAsString();
        final data = jsonDecode(jsonString);
        notes.add(Note.fromJson(data));
      }
    }

    return notes;
  }
}
