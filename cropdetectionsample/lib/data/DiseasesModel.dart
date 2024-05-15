import 'package:cropdetectionsample/Screens/diseases/diseasedetail.dart';
import 'package:cropdetectionsample/localhosturl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class DiseaseData {
  static final DiseaseData _instance = DiseaseData._internal();

  factory DiseaseData() => _instance;

  DiseaseData._internal();

  List<Map<String, dynamic>> diseaseList = [];

  Future<void> initializeDiseaseList() async {
    if (diseaseList.isEmpty) {
      final jsonString =
          await rootBundle.loadString('asset/cropdisease/disease.json');
      diseaseList = json.decode(jsonString).cast<Map<String, dynamic>>();
    }
  }

  Future<void> sendImageToDiseasePage(
      BuildContext context, dynamic _selectedImage) async {
    if (_selectedImage != null) {
      var url = 'http://' + localhosturl + '/php/diseasedetection/index.php';
      var request = http.MultipartRequest('POST', Uri.parse(url));

      List<int> imageBytes = await _selectedImage.readAsBytes();

      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
      ));

      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        int res = int.parse(responseBody);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DiseaseDetailsPage(disease: diseaseList[res]),
            ));
      } else {}
    } else {}
  }
}
