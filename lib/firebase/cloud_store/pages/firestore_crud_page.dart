import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/cloud_store/model/database_functions.dart';
import 'package:flutter_basics_1/firebase/cloud_store/pages/pets_page.dart';

class FirestoreCrudPage extends StatelessWidget {
  FirestoreCrudPage({super.key});
  DatabaseFunctions dbFunctions = DatabaseFunctions();

  var _nameController = TextEditingController();
  var _animalController = TextEditingController();
  var _ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  var _updateOption = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore CRUD'), centerTitle: true),
      body: Center(
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
                            decoration: InputDecoration(labelText: 'Animal'),
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
                            decoration: InputDecoration(labelText: 'Age'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
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
                          await dbFunctions.createSomething(
                            colName: 'pets',
                            docName: 'kitty',
                            name: 'jerry',
                            animal: 'cat',
                            age: 5,
                          );
                        },
                        child: Text('Create'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DropdownMenu<String>(
                            initialSelection: _updateOption,
                            onSelected: (value) {
                              _updateOption = value!;
                              print('Selected: $value');
                            },
                            dropdownMenuEntries: [
                              DropdownMenuEntry<String>(
                                value: 'name',
                                label: 'Name',
                              ),
                              DropdownMenuEntry<String>(
                                value: 'animal',
                                label: 'Animal',
                              ),
                              DropdownMenuEntry<String>(
                                value: 'age',
                                label: 'Age',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _animalController,
                            decoration: InputDecoration(labelText: 'Animal'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your animal';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await dbFunctions.updateSomething(
                          colName: 'pets',
                          docName: 'kitty',
                          field: 'age',
                          newFieldVal: 8,
                        );
                      },
                      child: Text('Update'),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PetsPage()),
                  );
                },
                child: Text('Read'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await dbFunctions.deleteSomething(
                    colName: 'pets',
                    docName: 'kitty',
                  );
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
