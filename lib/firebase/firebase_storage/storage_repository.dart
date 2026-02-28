import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadFile(File file) {
    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() +
        path.extension(file.path);

    Reference ref = _storage.ref().child('vault/$fileName');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    return ref.putFile(file, metadata);
  }

  Future<List<String>> getAllImages() async {
    ListResult result = await _storage.ref().child('vault').listAll();

    List<String> urls = [];
    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
}
