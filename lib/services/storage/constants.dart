const noteTable = 'notesss';
const idColumn = 'id';
const textColumn = 'text';
const createNotesTable = '''CREATE TABLE IF NOT EXISTS "notesss" (
        "id"	INTEGER NOT NULL,
        "text"	TEXT,
        PRIMARY KEY("id" AUTOINCREMENT)
      );''';
