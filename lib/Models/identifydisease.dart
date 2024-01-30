import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:cropdisdetection/providers/diseasedetailsprovider.dart';
import 'package:cropdisdetection/Screens/diseases/diseasedetail.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class IdentifyDisease extends StatefulWidget {
  const IdentifyDisease({Key? key, required File imageFile}) : super(key: key);

  @override
  State<IdentifyDisease> createState() => _IdentifyDiseaseState();
}

class _IdentifyDiseaseState extends State<IdentifyDisease> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<DiseaseDetailsProvider>(context, listen: false);
    // Simulate a delay of 5 seconds and then navigate to the next page
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiseaseDetailsPage(
            disease: provider.DiseaseDetails[Random().nextInt(9)],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display a loading indicator while waiting
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
