import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  bool isLoading = false;
  PlatformFile? pickedFile;
  String? savedFilePath;

  void pickFile() async {
    setState(() {
      isLoading = true;
      pickedFile = null;
      savedFilePath = null;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
      );
      if (result != null) {
        setState(() {
          pickedFile = result.files.single; // convert it to a Dart:io file
        });
        await saveFileLocally(pickedFile!);
      } else {
        print('User cancelled file picking');
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveFileLocally(PlatformFile pFile) async {
    if (pFile.path == null) {
      print('Picked file has no path. Cannot save.');
      return;
    }
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final String extension = pFile.extension ?? 'file';
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${pFile.name.replaceAll(' ', '_')}.$extension';
      final String newPath = '${appStorage.path}/$fileName';
      final File sourceFile = File(pFile.path!);
      final File savedFile = await sourceFile.copy(newPath);

      setState(() {
        savedFilePath = savedFile.path;
        print('Saved file path: $savedFilePath');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File saved successfully. to: $savedFilePath')),
      );
    } catch (e) {
      print('Error saving file: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving file: $e')));
      setState(() {
        savedFilePath = null;
      });
    }
  }

  Future<void> loadLastSavedFile() async {
    setState(() {
      isLoading = true;
      pickedFile = null;
      savedFilePath = null;
    });

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final files = appDir.listSync().whereType<File>().toList();
      if (files.isNotEmpty) {
        files.sort(
          (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
        );
        final File lastSavedActualFile = files.first;
        setState(() {
          savedFilePath = lastSavedActualFile.path;
          pickedFile = PlatformFile(
            name: lastSavedActualFile.path.split('/').last,
            size: lastSavedActualFile.lengthSync(),
            path: lastSavedActualFile.path,
            bytes: null,
          );
          print('Loaded Last saved file path: $savedFilePath');
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loaded Last saved file path: $savedFilePath'),
          ),
        );
      } else {
        print('No files found in the directory.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No files found in the directory.')),
        );
      }
    } catch (e) {
      print('Error loading last saved image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading file: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Upload'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () => pickFile(),
              child: Container(
                height: 250,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: pickedFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_rounded,
                              size: 50,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                'No File Selected',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.insert_drive_file,
                              size: 50,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Text(
                                'Selected File : \nName : ${pickedFile!.name}\nSize : ${pickedFile!.size} bytes\nPath : ${pickedFile!.path}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () => loadLastSavedFile(),
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
