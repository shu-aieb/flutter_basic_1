import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFunctions {
  Future<void> createSomething({
    required String colName,
    docName,
    name,
    animal,
    required int age,
  }) async {
    await FirebaseFirestore.instance.collection(colName).doc(docName).set({
      'name': name,
      'animal': animal,
      'age': age,
    });
    print('Database updated');
  }

  Future<void> updateSomething({
    required String colName,
    docName,
    field,
    required var newFieldVal,
  }) async {
    await FirebaseFirestore.instance.collection(colName).doc(docName).update({
      field: newFieldVal,
    });
    print('Database updated new field value');
  }

  Future<void> deleteSomething({required String colName, docName}) async {
    await FirebaseFirestore.instance.collection(colName).doc(docName).delete();
    print('Database deleted');
  }
}
