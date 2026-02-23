import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetsController extends GetxController {
  var updateOption = 'name'.obs;
  var selectedDocId = ''.obs;

  Stream<QuerySnapshot> getPets() {
    return FirebaseFirestore.instance.collection('pets').snapshots();
  }

  void setUpdateOption(String val) => updateOption.value = val;
  void setSelectedDocId(String val) => selectedDocId.value = val;
}
