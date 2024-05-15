import 'package:cropdetectionsample/Screens/diseases/diseasedetail.dart';
import 'package:flutter/material.dart';
import 'package:cropdetectionsample/data/DiseasesModel.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Diseases'),
      ),
      body:
          // print(provider.DiseaseDetails[0]['Disease_Name']);
          ListView.builder(
        itemCount: DiseaseData().diseaseList.length,
        itemBuilder: (context, index) {
          var disease = DiseaseData().diseaseList[index];
          return Card(
            child: ListTile(
              title: Text(disease['Disease_Name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseDetailsPage(
                      disease: disease,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
