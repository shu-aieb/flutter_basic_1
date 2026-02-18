import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/my_constants.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onDelete;
  final Function onTap;
  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(note),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Constants.noteColors[note.colorIndex],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.date,
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              note.title,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 9),
            Expanded(
              child: Text(
                note.description,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.5,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => onDelete(note),
                  icon: Icon(Icons.delete, color: Colors.black54, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
