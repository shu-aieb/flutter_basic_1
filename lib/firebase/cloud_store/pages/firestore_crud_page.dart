import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/cloud_store/model/database_functions.dart';
import 'package:flutter_basics_1/firebase/cloud_store/pages/pets_page.dart';
import 'package:flutter_basics_1/firebase/cloud_store/widgets/reusable_widget.dart';
import 'package:get/get.dart';

import '../viewmodel/pets_controller.dart';

class FirestoreCrudPage extends StatefulWidget {
  FirestoreCrudPage({super.key});

  @override
  State<FirestoreCrudPage> createState() => _FirestoreCrudPageState();
}

class _FirestoreCrudPageState extends State<FirestoreCrudPage> {
  DatabaseFunctions dbFunctions = DatabaseFunctions();

  final _nameController = TextEditingController();
  final _animalController = TextEditingController();
  final _ageController = TextEditingController();
  final _updateNameController = TextEditingController();
  final _updateValueController = TextEditingController();

  late PetsController petController;

  final _formKey = GlobalKey<FormState>();

  final _formKey2 = GlobalKey<FormState>();

  //var _updateOption = 'name';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petController = Get.put(PetsController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animalController.dispose();
    _ageController.dispose();
    _updateNameController.dispose();
    _updateValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore CRUD'), centerTitle: true),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(labelText: 'Name'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _animalController,
                                decoration: InputDecoration(
                                  labelText: 'Animal',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your animal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
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

                              await dbFunctions.createSomething(
                                colName: 'pets',
                                docName: _nameController.text,
                                name: _nameController.text,
                                animal: _animalController.text,
                                age: int.parse(_ageController.text),
                              );

                              _nameController.clear();
                              _animalController.clear();
                              _ageController.clear();

                              // await dbFunctions.createSomething(
                              //   colName: 'pets',
                              //   docName: 'kitty',
                              //   name: 'jerry',
                              //   animal: 'cat',
                              //   age: 5,
                              // );
                            },
                            child: Text('Create'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 5),
                  // Form(
                  //   key: _formKey2,
                  //   child: Column(
                  //     children: [
                  //       StreamBuilder(
                  //         stream: FirebaseFirestore.instance
                  //             .collection('pets')
                  //             .snapshots(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return Center(child: CircularProgressIndicator());
                  //           }
                  //           if (snapshot.hasData) {
                  //             return Obx(
                  //               () => DropdownMenu<String>(
                  //                 width: MediaQuery.of(context).size.width - 20,
                  //                 initialSelection:
                  //                     petController.selectedDocId.value,
                  //                 onSelected: (value) {
                  //                   petController.setSelectedDocId(value!);
                  //                   print('Selected: $value');
                  //                 },
                  //                 dropdownMenuEntries: [
                  //                   ...snapshot.data!.docs.map((e) {
                  //                     return DropdownMenuEntry<String>(
                  //                       value: e.id,
                  //                       label: e.id,
                  //                     );
                  //                   }),
                  //                 ],
                  //               ),
                  //             );
                  //           }
                  //           return Center(child: Text('No Data'));
                  //         },
                  //       ),
                  //       SizedBox(height: 20),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Expanded(
                  //             child: Obx(
                  //               () => DropdownMenu<String>(
                  //                 initialSelection:
                  //                     petController.updateOption.value,
                  //                 onSelected: (value) {
                  //                   petController.setUpdateOption(value!);
                  //                   print('Selected: $value');
                  //                 },
                  //                 dropdownMenuEntries: [
                  //                   DropdownMenuEntry<String>(
                  //                     value: 'name',
                  //                     label: 'Name',
                  //                   ),
                  //                   DropdownMenuEntry<String>(
                  //                     value: 'animal',
                  //                     label: 'Animal',
                  //                   ),
                  //                   DropdownMenuEntry<String>(
                  //                     value: 'age',
                  //                     label: 'Age',
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(height: 20),
                  //           Expanded(
                  //             child: Obx(
                  //               () => TextFormField(
                  //                 controller: _updateValueController,
                  //                 keyboardType:
                  //                     petController.updateOption.value == 'age'
                  //                     ? TextInputType.number
                  //                     : TextInputType.text,
                  //                 decoration: InputDecoration(
                  //                   labelText: 'New Value',
                  //                 ),
                  //                 validator: (value) {
                  //                   if (value == null || value.isEmpty) {
                  //                     return 'Please enter your animal';
                  //                   }
                  //                   if (petController.updateOption.value ==
                  //                           'age' &&
                  //                       int.tryParse(value) == null) {
                  //                     return 'Please enter a valid age';
                  //                   }
                  //                   return null;
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 20),
                  //       SizedBox(
                  //         width: double.infinity,
                  //         height: 40,
                  //
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.blue.shade600,
                  //             foregroundColor: Colors.white,
                  //           ),
                  //           onPressed: () async {
                  //             if (!_formKey2.currentState!.validate()) return;
                  //             print('Form 2 is valid');
                  //
                  //             await dbFunctions.updateSomething(
                  //               colName: 'pets',
                  //               docName: petController
                  //                   .selectedDocId
                  //                   .value, //_updateNameController.text,
                  //               field: petController.updateOption.value,
                  //               newFieldVal:
                  //                   petController.updateOption.value == 'age'
                  //                   ? int.parse(_updateValueController.text)
                  //                   : _updateValueController.text,
                  //             );
                  //           },
                  //           child: Text('Update'),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //-------------------
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => PetsPage()),
                  //     );
                  //   },
                  //   child: Text('Read'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await dbFunctions.deleteSomething(
                  //       colName: 'pets',
                  //       docName: 'kitty',
                  //     );
                  //   },
                  //   child: Text('Delete'),
                  // ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 5),
          Flexible(
            flex: 8,
            child: PetsPage(dbFunc: dbFunctions, petController: petController),
          ),
        ],
      ),
    );
  }
}
