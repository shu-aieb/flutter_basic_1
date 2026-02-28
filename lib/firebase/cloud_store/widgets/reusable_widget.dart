import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/cloud_store/viewmodel/pets_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/database_functions.dart';

class AnimalDetailSheet extends StatefulWidget {
  DatabaseFunctions dbFunctions;
  Map<String, dynamic> docs;
  PetsController petController;

  AnimalDetailSheet({
    super.key,
    required this.dbFunctions,
    required this.docs,
    required this.petController,
  });

  @override
  State<AnimalDetailSheet> createState() => _AnimalDetailSheetState();
}

class _AnimalDetailSheetState extends State<AnimalDetailSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _animalController = TextEditingController();
  final _ageController = TextEditingController();

  final _updateValueController = TextEditingController();

  //var _updateOption = 'name';

  late final String docName;

  @override
  void dispose() {
    _nameController.dispose();
    _animalController.dispose();
    _ageController.dispose();
    _updateValueController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    docName = widget.docs['name'];
    _nameController.text = widget.docs['name'];
    _animalController.text = widget.docs['animal'];
    _ageController.text = widget.docs['age'].toString();

    var _updateOption = widget.petController.updateOption.value;
    _updateValueController.text = widget.docs[_updateOption];
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

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextFormField(
            //       controller: _nameController,
            //       decoration: InputDecoration(labelText: 'Name'),
            //       validator: (value) {
            //         if (value == null || value.isEmpty) {
            //           return 'Please enter your name';
            //         }
            //         return null;
            //       },
            //     ),
            //     SizedBox(width: 10),
            //     TextFormField(
            //       controller: _animalController,
            //       decoration: InputDecoration(labelText: 'Animal'),
            //       validator: (value) {
            //         if (value == null || value.isEmpty) {
            //           return 'Please enter your animal';
            //         }
            //         return null;
            //       },
            //     ),
            //     SizedBox(width: 10),
            //     TextFormField(
            //       controller: _ageController,
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(labelText: 'Age'),
            //       validator: (value) {
            //         if (value == null || value.isEmpty) {
            //           return 'Please enter your age';
            //         }
            //         if (int.tryParse(value) == null) {
            //           return 'Please enter a valid age';
            //         }
            //         return null;
            //       },
            //     ),
            //   ],
            // ),
            //-----
            //-----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Obx(
                    () => DropdownMenu<String>(
                      initialSelection: widget.petController.updateOption.value,
                      onSelected: (value) {
                        widget.petController.setUpdateOption(value!);
                        print('Selected: $value');
                      },
                      dropdownMenuEntries: [
                        DropdownMenuEntry<String>(value: 'name', label: 'Name'),
                        DropdownMenuEntry<String>(
                          value: 'animal',
                          label: 'Animal',
                        ),
                        DropdownMenuEntry<String>(value: 'age', label: 'Age'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => TextFormField(
                      controller: _updateValueController,
                      keyboardType:
                          widget.petController.updateOption.value == 'age'
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(labelText: 'New Value'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your animal';
                        }
                        if (widget.petController.updateOption.value == 'age' &&
                            int.tryParse(value) == null) {
                          return 'Please enter a valid age';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    print('Form is valid');

                    String val = widget.petController.updateOption.value;

                    await widget.dbFunctions.updateSomething(
                      colName: 'pets',
                      docName: docName,
                      field: val,
                      newFieldVal: val == 'age'
                          ? int.parse(_updateValueController.text)
                          : _updateValueController.text,
                    );
                    Navigator.pop(context);
                    //Get.back();
                  },
                  child: Text('Update'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
