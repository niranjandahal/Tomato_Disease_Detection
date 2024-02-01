import 'package:cropdisdetection/Screens/Help/helppage.dart';
import 'package:cropdisdetection/Screens/diseases/diseasepage.dart';
import 'package:cropdisdetection/Screens/gallery/gallerypage.dart';
import 'package:cropdisdetection/HomePage.dart';
import 'package:cropdisdetection/providers/diseasedetailsprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          '/help': (context) => HelpPage(),
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
