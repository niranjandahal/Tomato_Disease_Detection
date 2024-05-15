import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cropdetectionsample/data/DiseasesModel.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image.file(File(_selectedImage!.path)),
                  ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 100,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_photo_alternate),
                label: Container(),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 100,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await DiseaseData()
                      .sendImageToDiseasePage(context, _selectedImage);
                },
                icon: const Icon(Icons.check),
                label: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
