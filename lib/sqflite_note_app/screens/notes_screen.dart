import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/my_colors.dart';
import '../constants/my_sizes.dart';
import '../constants/my_styles.dart';
import '../database/notes_database.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import 'note_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final notes = await NotesDatabase.instance.getNotes();
    //print("UI DEBUG: Found ${notes.length} notes in DB");
    setState(() {
      this.notes = notes;
    });
  }

  void showNoteDialog(Note? note) {
    showDialog(
      context: context,
      builder: (dialogContext) => NoteDialog(
        note: note,
        onSave: (Note note) async {
          //print(note.description);

          if (note.id == null) {
            await NotesDatabase.instance.addNote(note);
          } else {
            await NotesDatabase.instance.updateNote(note);
          }
          fetchNotes();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Notes', style: MyStyles.appBarTextStyle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(null),
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: MyIconSize.small),
      ),
      body: notes.isEmpty
          ? notesNotFound()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    onDelete: (Note note) async {
                      if (note.id == null) return;
                      await NotesDatabase.instance.deleteNote(note.id!);
                      fetchNotes();
                    },
                    onTap: (Note note) {
                      showNoteDialog(note);
                    },
                  );
                },
              ),
            ),
    );
  }

  Widget notesNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add,
            size: MyIconSize.extraLarge,
            color: MyColors.lowOpacityColor,
          ),
          SizedBox(height: MySpaceSize.small),
          Text(
            'No Notes',
            style: GoogleFonts.mochiyPopPOne(
              fontSize: MyFontSize.large,
              fontWeight: FontWeight.w500,
              color: MyColors.lowOpacityColor,
            ),
          ),
        ],
      ),
    );
  }
}
