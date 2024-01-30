import 'package:cropdisdetection/Screens/diseases/diseasedetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cropdisdetection/providers/diseasedetailsprovider.dart';

class DiseasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Diseases'),
      ),
      body: Consumer<DiseaseDetailsProvider>(
        builder: (context, provider, child) {
          print(provider.DiseaseDetails[0]['Disease_Name']);
          return ListView.builder(
            itemCount: provider.DiseaseDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(provider.DiseaseDetails[index]['Disease_Name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseDetailsPage(
                        disease: provider.DiseaseDetails[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
