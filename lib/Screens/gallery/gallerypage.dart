import 'package:cropdisdetection/Models/identifydisease.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
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

 void _sendImageToDiseasePage() {
    if (_selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IdentifyDisease(imageFile: File(_selectedImage!.path)),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Icon(Icons.error),
            content: Icon(Icons.warning),
            actions: [
              TextButton(
                onPressed: () {
                 Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ],
          );
        },
      );
    }
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Container()
                : Image.file(
                    File(_selectedImage!.path),
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width*0.7,
                 ),
            SizedBox(height: 20.0),
            Container(
              width: 100,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.add_photo_alternate),
                label: Container(),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 100,
              child: ElevatedButton.icon(
                onPressed: _sendImageToDiseasePage,
                icon: Icon(Icons.check),
                label: Container(),
              ),
            ),
          ],
        ),
      ),
    );
 }
}
