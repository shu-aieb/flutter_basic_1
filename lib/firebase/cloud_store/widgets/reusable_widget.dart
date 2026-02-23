import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/database_functions.dart';

class AnimalDetailSheet extends StatefulWidget {
  DatabaseFunctions dbFunctions;
  Map<String, dynamic> docs;

  AnimalDetailSheet({super.key, required this.dbFunctions, required this.docs});

  @override
  State<AnimalDetailSheet> createState() => _AnimalDetailSheetState();
}

class _AnimalDetailSheetState extends State<AnimalDetailSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _animalController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _animalController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.docs['name'];
    _animalController.text = widget.docs['animal'];
    _ageController.text = widget.docs['age'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  'Edit Animal',
                  style: GoogleFonts.playwritePe(
                    color: Colors.blue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
              ],
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(width: 10),
                TextFormField(
                  controller: _animalController,
                  decoration: InputDecoration(labelText: 'Animal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your animal';
                    }
                    return null;
                  },
                ),
                SizedBox(width: 10),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  print('Form is valid');

                  await widget.dbFunctions.updateSomething(
                    colName: 'pets',
                    docName: _nameController.text,
                    name: _nameController.text,
                    animal: _animalController.text,
                    age: int.parse(_ageController.text),
                  );
                  //Navigator.pop(context);
                  Get.back();
                },
                child: Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
