import 'package:camera/camera.dart';
import 'package:cropdetectionsample/Screens/Help/helppage.dart';
import 'package:cropdetectionsample/Screens/diseases/diseasepage.dart';
import 'package:cropdetectionsample/Screens/media/camerapage.dart';
import 'package:cropdetectionsample/Screens/media/gallerypage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crop Disease Detection'),
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              _buildOptionCard(Icons.camera_alt, "Camera", () async {
                final cameras = await availableCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CameraPage(cameras: cameras),
                  ),
                );
              }),
              _buildOptionCard(
                  Icons.photo,
                  "Gallery",
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GalleryPage(),
                      ))),
              _buildOptionCard(
                Icons.info,
                "Diseases",
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseasePage(),
                    )),
              ),
              _buildOptionCard(
                  Icons.help,
                  "Help",
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpPage(),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
