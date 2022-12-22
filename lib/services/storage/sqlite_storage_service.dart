import 'package:flutter/services.dart';
import 'package:notes/services/storage/constants.dart';
import 'package:notes/services/storage/storage_exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NoteService {
  Database? _db;

  Future<int> deleteNote(int id) async {
    final db = getDbOrThrow();
    int deletedId =
        await db.delete(noteTable, where: 'id = ?', whereArgs: [id]);
    if (deletedId != 1) {
      throw UnableToDeleteNote();
    } else {
      return deletedId;
    }
  }

  Future<List<Note>> getNotes() async {
    final db = getDbOrThrow();
    final List<Map<String, Object?>> notes = await db.query(noteTable);
    return notes.map((e) {
      return Note.fromMap(e);
    }).toList();
  }

  Future<int> createNote({required String note}) async {
    Database db = getDbOrThrow();
    final id = await db.insert(noteTable, {textColumn: note});
    return id;
  }

  Database getDbOrThrow() {
    if (_db == null) {
      throw DatabaseNotOpen();
    } else {
      return _db!;
    }
  }

  void closeDb() {
    if (_db == null) {
      throw DatabaseAlreadyClose();
    } else {
      _db!.close();
      _db = null;
    }
  }

  Future<void> openDb() async {
    if (_db != null) {
      throw DatabaseAlreadyOpen();
    }

    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final String fullPath = join(docsPath.path, "database.db");
      Database db = await openDatabase(fullPath);
      _db = db;
      // create notes table
      _db!.execute(createNotesTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDatabaseDirectory();
    }
  }
}

class Note {
  final int id;
  final String text;
  Note({required this.id, required this.text});
  Note.fromMap(Map<String, Object?> map)
      : id = map[idColumn] as int,
        text = map[textColumn] as String;
  Map<String, Object> toMap() {
    return {idColumn: id, textColumn: text};
  }
}
