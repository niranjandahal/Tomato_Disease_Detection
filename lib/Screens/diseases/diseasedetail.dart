import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class DiseaseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> disease;

  DiseaseDetailsPage({required this.disease});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // This is to prevent the user from going back to the Identify Disease page
        // after they have already identified a disease
        Navigator.popUntil(context, (route) => route.isFirst);
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
                        duration: const Duration(seconds: 3),
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
                            color: Color(0xFFB4C2F8),
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
                              from: 66.6,
                              to: 100,
                              color: Colors.red, // High severity
                              cornerRadius: Radius.circular(8),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),
                      Text(
                        "Disease Severity level: ${disease['DISEASE_Severity_Level']}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        disease['Description'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Cause:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        disease['Causes'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),

                      //2 images in row
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

                      //symptoms should be visible if i want to see by clicking on the card
                      Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: const Text(
                            'Symptoms:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                disease['Symptoms'],
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // const Text(
                      //   'Symptoms:',
                      //   style: TextStyle(
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 4.0),
                      // Text(
                      //   disease['Symptoms'],
                      //   style: const TextStyle(fontSize: 16.0),
                      // ),

                      //management tip

                      Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: const Text(
                            'Management Tip:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                disease['MANAGEMENT_TIPS'],
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Treatment:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        disease['Treatment'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      // const Text(
                      //   'Management Tip:',
                      //   style: TextStyle(
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 4.0),
                      // Text(
                      //   disease['MANAGEMENT_TIPS'],
                      //   style: const TextStyle(fontSize: 16.0),
                      // ),
                      const SizedBox(height: 8.0),
                      //prevention
                      const Text(
                        'Prevention:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        disease['Prevention'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      // Affected_Plant_Parts
                      const Text(
                        'Affected Plant Parts:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        disease['Affected_Plant_Parts'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      //Spread_and_Impact
                      const Text(
                        'Spread and Impact:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        disease['Spread_and_Impact'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      // DISEASE_Severity_Level
                      const Text(
                        'Disease Severity Level:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        disease['DISEASE_Severity_Level'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
              // Add more cards for additional details

              // condition if relateddisease is not null then only show the card  "RELATEDOTHERDISEASE": "",
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              disease['RELATEDOTHERDISEASE'],
                              style: const TextStyle(fontSize: 16.0),
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
}
