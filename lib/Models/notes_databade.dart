import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note_tracker/Models/Note.dart';

import 'package:path_provider/path_provider.dart';

class NotesDatabasse extends ChangeNotifier {
  static late Isar isar;

  // initialize the database --
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // list of notes
  final List<Note> currentNotes = [];

  // create --
  Future<void> addNote(String noteName, String textNote) async {
    final note = Note()
      ..name = noteName
      ..text = textNote;
    await isar.writeTxn(() => isar.notes
        .put(note)); // note object will be stored into the database --
    fetchNotes();
    //readNote(note.id);
    notifyListeners();
  }

  // // Read --
  // Future<void> readNote(Id id) async {
  //   final existingNote = await isar.notes.get(id);
  //   currentNotes.removeAt(id - 1);
  //   currentNotes.insert(id - 1, existingNote!);
  //   notifyListeners();
  // }

  //fetch notes all --
  Future<void> fetchNotes() async {
    final dbNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(dbNotes);
    notifyListeners();
  }

  // Update --
  Future<void> updateNote(Id id, String noteName, String newNote) async {
    final existingNote = await isar.notes.get(id);
    final note = existingNote
      ?..name = noteName
      ..text = newNote;
    await isar.writeTxn(() => isar.notes.put(note!));
    fetchNotes();
    // readNote(id);
    notifyListeners();
  }

  // Delete --
  Future<void> deleteNote(Id id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
    // readNote(id);
    notifyListeners();
  }
}
