import 'package:cropdetectionsample/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:cropdetectionsample/data/DiseasesModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiseaseData().initializeDiseaseList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tomato Disease Detection',
      theme: ThemeData(
        useMaterial3: true,
      ),
      builder: (context, child) {
        return ForcedMobileView(child: child!);
      },
      home: const HomePage(),
    );
  }
}

class ForcedMobileView extends StatelessWidget {
  final Widget child;

  const ForcedMobileView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Define Pixel 7 dimensions
    const double mobileWidth = 480;
    const double mobileHeight = 1050;

    // Get the current screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Force mobile dimensions if the screen is larger than mobile size
    if (screenWidth > mobileWidth || screenHeight > mobileHeight) {
      return Column(
        children: [
          //a bold text saying pixel 7 dimension zoom out browser to see full screen
          const Text(
            'Zoom out browser to see full screen',
            style: TextStyle(
              fontSize: 30,

              // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: Container(
              width: mobileWidth,
              height: mobileHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5), blurRadius: 10),
                ],
              ),
              child: MediaQuery(
                data: MediaQueryData(
                  size: const Size(mobileWidth, mobileHeight),
                  devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
                  padding: MediaQuery.of(context).padding,
                  viewInsets: MediaQuery.of(context).viewInsets,
                ),
                child: child,
              ),
            ),
          ),
        ],
      );
    }

    // Default rendering for mobile-sized screens
    return child;
  }
}
