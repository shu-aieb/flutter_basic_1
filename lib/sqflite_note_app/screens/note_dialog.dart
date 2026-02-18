import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/my_constants.dart';
import '../constants/my_sizes.dart';
import '../constants/my_styles.dart';
import '../models/note.dart';
import '../widgets/my_textfield.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;
  final Function onSave;

  const NoteDialog({super.key, required this.note, required this.onSave});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late int _selectedColorIndex;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    _selectedColorIndex = widget.note?.colorIndex ?? 0;
    titleController = TextEditingController(text: widget.note?.title ?? '');
    descriptionController = TextEditingController(
      text: widget.note?.description ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return AlertDialog(
      backgroundColor: Constants.noteColors[_selectedColorIndex],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          widget.note == null ? 'Add Note' : 'Edit Note',
          style: MyStyles.headingTextStyle,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(currentDate, style: MyStyles.smallTextStyle),
            const SizedBox(height: MySpaceSize.large),
            MyTextfield(controller: titleController, labelText: 'Title'),

            const SizedBox(height: MySpaceSize.large),
            MyTextfield(
              controller: descriptionController,
              labelText: 'Description',
              maxLines: 5,
            ),
            const SizedBox(height: MySpaceSize.large),

            Wrap(
              spacing: MySpaceSize.medium,
              runSpacing: MySpaceSize.medium,
              children: List.generate(
                Constants.noteColors.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: MyRadiusSize.large,
                    backgroundColor: Constants.noteColors[index],
                    child: _selectedColorIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.black54,
                            size: MyFontSize.medium,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: MyStyles.textButtonStyle),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MyRadiusSize.medium),
            ),
          ),
          onPressed: () async {
            final note = Note(
              id: widget.note?.id,
              title: titleController.text,
              description: descriptionController.text,
              date: currentDate,
              colorIndex: _selectedColorIndex,
            );
            widget.onSave(note);
            Navigator.pop(context);
          },
          child: Text('Save', style: MyStyles.textButtonStyle),
        ),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
