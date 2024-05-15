import 'package:cropdetectionsample/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class DiseaseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> disease;

  const DiseaseDetailsPage({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(disease['Disease_Name']),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${disease['Disease_Name']}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      //gauge indicator on baiss of severity by gauge indicator packages
                      AnimatedRadialGauge(
                        duration: const Duration(seconds: 6),
                        curve: Curves.elasticOut,
                        radius: 120,
                        value: double.parse(disease['DISEASE_Severity_Value']),
                        axis: const GaugeAxis(
                          min: 0,
                          max: 100,
                          degrees: 180,
                          style: GaugeAxisStyle(
                            thickness: 20,
                            background: Color(0xFFDFE2EC),
                            segmentSpacing: 4,
                          ),
                          progressBar: GaugeProgressBar.rounded(
                            color: Color.fromARGB(69, 180, 194, 248),
                          ),
                          segments: [
                            GaugeSegment(
                              from: 0,
                              to: 33.3,
                              color: Colors.green, // Low severity
                              cornerRadius: Radius.circular(8),
                            ),
                            GaugeSegment(
                              from: 33.3,
                              to: 66.6,
                              color: Colors.yellow, // Moderate severity
                              cornerRadius: Radius.circular(8),
                            ),
                            GaugeSegment(
                              from: 66.6 +
                                  0.01, // Add a small offset to avoid coverage
                              to: 100,
                              color: Colors.red, // High severity
                              cornerRadius: Radius.circular(8),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),

                      //description
                      showdetail('Description'),

                      //cause
                      showdetail('Causes'),

                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              disease['Images'][0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Image.network(
                              disease['Images'][1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16.0),

                      //symptoms
                      Dropdown('Symptoms'),

                      //management tip
                      Dropdown('MANAGEMENT_TIPS'),

                      // treatment
                      showdetail('Treatment'),

                      //prevention
                      showdetail('Prevention'),

                      // Affected_Plant_Parts
                      showdetail('Affected_Plant_Parts'),

                      //Spread_and_Impact
                      showdetail('Spread_and_Impact'),

                      // DISEASE_Severity_Level
                      showdetail('DISEASE_Severity_Level')
                    ],
                  ),
                ),
              ),

              // if relateddisease is not null then only show the card

              disease['RELATEDOTHERDISEASE'] != ""
                  ? Card(
                      elevation: 3,
                      margin: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: const Text(
                          'Related Other Disease:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //images of related other disease

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              disease['RELATEDOTHERDISEASE'],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Image.network(
                              disease['relateddiseaseimg'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showdetail(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + ':',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          disease[title],
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget Dropdown(String text) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          text + ':',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              disease[text],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
