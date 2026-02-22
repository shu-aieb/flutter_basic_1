import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/database_functions.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  final dbFunctions = DatabaseFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pets'), centerTitle: true),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pets').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final docs = snapshot.data!.docs[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      dbFunctions.deleteSomething(
                        colName: 'pets',
                        docName: docs.id,
                      );
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,

                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Name : ${docs['name']}'),
                        subtitle: Text('Animal : ${docs['animal']}'),
                        trailing: Text(
                          'Age : ${docs['age'].toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }
}
