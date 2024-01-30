import 'package:cropdisdetection/Screens/diseases/diseasepage.dart';
import 'package:cropdisdetection/Screens/gallery/gallerypage.dart';
import 'package:cropdisdetection/HomePage.dart';
import 'package:cropdisdetection/providers/diseasedetailsprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DiseaseDetailsProvider>(
            create: (context) => DiseaseDetailsProvider()),
      ],
      child: MaterialApp(
        routes: {
          '/diseases': (context) => DiseasePage(),
          '/gallery': (context) => GalleryPage(),
          // '/help': (context) => HelpPage(),
        },
        title: 'Tomato Research App',
        theme: ThemeData(
            // primarySwatch: Colors.green, // Choose your color palette
            // visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true),
        home: HomePage(),
      ),
    );
  }
}
