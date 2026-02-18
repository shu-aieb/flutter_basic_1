import '../database/notes_database.dart';

class Note {
  int? id;
  String title;
  String description;
  String date;
  int colorIndex;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.colorIndex,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[NotesDatabase.colId],
      title: map[NotesDatabase.colTitle],
      description: map[NotesDatabase.colDescription],
      date: map[NotesDatabase.colDate],
      colorIndex: map[NotesDatabase.colColor],
    );
  }
}
