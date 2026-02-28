import 'package:flutter/material.dart';
import 'vault_view_model.dart';

class CloudVaultScreen extends StatefulWidget {
  @override
  _CloudVaultScreenState createState() => _CloudVaultScreenState();
}

class _CloudVaultScreenState extends State<CloudVaultScreen> {
  final VaultViewModel _viewModel = VaultViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Secure Vault"),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              _viewModel.imageUrls.isEmpty
                  ? Center(child: Text("Vault Empty. Upload a document."))
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _viewModel.imageUrls.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _viewModel.imageUrls[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (ctx, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

              if (_viewModel.isUploading)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Encrypting & Uploading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        LinearProgressIndicator(
                          value: _viewModel.uploadProgress,
                          backgroundColor: Colors.grey[700],
                          color: Colors.greenAccent,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${(_viewModel.uploadProgress * 100).toInt()}%",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _viewModel.isUploading
                ? null
                : () => _viewModel.pickAndUpload(),
            icon: Icon(Icons.upload_file),
            label: Text("Upload"),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
