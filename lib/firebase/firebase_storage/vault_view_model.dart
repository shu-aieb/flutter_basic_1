import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'storage_repository.dart';

class VaultViewModel extends ChangeNotifier {
  final StorageRepository _repo = StorageRepository();
  final ImagePicker _picker = ImagePicker();

  List<String> _imageUrls = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  List<String> get imageUrls => _imageUrls;
  bool get isUploading => _isUploading;
  double get uploadProgress => _uploadProgress;

  void loadImages() async {
    _imageUrls = await _repo.getAllImages();
    notifyListeners();
  }

  Future<void> pickAndUpload() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    _isUploading = true;
    _uploadProgress = 0.0;
    notifyListeners();

    try {
      UploadTask task = _repo.uploadFile(file);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        notifyListeners();
      });

      await task.whenComplete(() {});

      loadImages();
    } catch (e) {
      print("Upload failed: $e");
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
