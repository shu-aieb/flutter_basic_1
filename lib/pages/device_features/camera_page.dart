import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? image;
  bool isLoading = false;

  final picker = ImagePicker();

  // Future<void> pickImage(ImageSource source) async {
  //   final pickedFile = await picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       image = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> pickAndSaveImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File tempImageFile = File(pickedFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final newPath = '${appDir.path}/$fileName';
      print('new Path : $newPath');
      final savedImage = await tempImageFile.copy(newPath);

      setState(() {
        image = File(pickedFile.path);
        print('Image Path : ${savedImage!.path}');
      });
    } else {
      print('No Image Selected');
    }
  }

  Future<void> loadLastSavedImage() async {
    isLoading = true;
    final appDir = await getApplicationDocumentsDirectory();
    final files = appDir.listSync();
    if (files.isNotEmpty) {
      final firstImageFile = files.firstWhereOrNull(
        (f) => f.path.endsWith('.png'),
      );
      if (firstImageFile != null) {
        setState(() {
          image = File(firstImageFile.path);
        });
      }
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: isLoading
                ? const CircularProgressIndicator()
                : image != null
                ? Image.file(image!, fit: BoxFit.cover)
                : const Center(child: Text('No Image Selected')),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => pickAndSaveImage(ImageSource.camera),
                label: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.camera_alt),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => pickAndSaveImage(ImageSource.gallery),
                label: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.image),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () => loadLastSavedImage(),
            label: const Text(
              'Load Last Saved Image',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            icon: const Icon(Icons.file_upload),
          ),
        ],
      ),
    );
  }
}
