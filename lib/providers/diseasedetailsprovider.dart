import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package for rootBundle
import 'package:http/http.dart' as http; // Import this package for get

class DiseaseDetailsProvider extends ChangeNotifier {
  List _DiseaseDetails = [];
  List get DiseaseDetails => _DiseaseDetails;
  bool dataloaded = false;

  List _carouselimg = [];
  List get carouselimg => _carouselimg;
  bool carouselimgloaded = false;

  Future<void> getDiseaseDetails() async {
    if (dataloaded == false) {
      var jsonText =
          await rootBundle.loadString('asset/cropdisease/disease.json');
      var data = jsonDecode(jsonText);
      for (var i in data) {
        _DiseaseDetails.add(i);
      }
      dataloaded = true;
      // print(_DiseaseDetails[0]);
      print(DiseaseDetails.length);

      notifyListeners();
    }
  }

  // https://picsum.photos/v2/list
  Future<void> getcarouselimg() async {
    if (carouselimgloaded == false) {
      var url = "https://picsum.photos/v2/list";
      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      for (var i in data) {
        _carouselimg.add(i);
      }
      carouselimgloaded = true;
      // print(_carouselimg);
      notifyListeners();
    }
  }
}
