import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? image;

  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Page'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: image != null
                ? Image.file(image!)
                : const Center(child: Text('No Image Selected')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                child: const Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
