import 'package:camera/camera.dart';
import 'package:cropdetectionsample/data/DiseasesModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
                Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          ),
          const SizedBox(height: 30),
          Text(picture.name),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // Handle retake functionality here
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh, size: 30),
              ),
              IconButton(
                onPressed: () async {
                  await DiseaseData().sendImageToDiseasePage(context, picture);
                },
                icon: const Icon(Icons.check, size: 30),
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
