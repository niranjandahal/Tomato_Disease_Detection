import 'package:cropdisdetection/Screens/camera/camerapage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:cropdisdetection/providers/diseasedetailsprovider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _dataFetching;

  @override
  void initState() {
    super.initState();
    _dataFetching = fetchData();
  }

  Future<void> fetchData() async {
    final provider =
        Provider.of<DiseaseDetailsProvider>(context, listen: false);
    await provider.getDiseaseDetails();
    await provider.getcarouselimg();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Crop Disease Detection'),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(25),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: FutureBuilder(
                  future: _dataFetching,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<DiseaseDetailsProvider>(
                        builder: (context, provider, child) {
                          return CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: MediaQuery.of(context).size.height * 0.25,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: true,
                              aspectRatio: 2.0,
                            ),
                            items: provider.carouselimg.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(
                                                  0.4), // Adjust opacity as needed
                                              BlendMode.srcATop,
                                            ),
                                            // child:
                                            // Image.network(
                                            //   i['download_url'],
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: Text(
                                          i['author'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        bottom: 10,
                                        left: 10,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                // beautiful gridview of option buttons in card
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    //camera button
                    Card(
                      margin: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () async {
                          await availableCameras().then((value) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          CameraPage(cameras: value))));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(Icons.camera_alt),
                              const Text("Camera")
                            ],
                          ),
                        ),
                      ),
                    ),
                    //gallery button
                    Card(
                      margin: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/gallery');
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(Icons.photo),
                              const Text("Gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                    //all diseases information button
                    Card(
                      margin: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/diseases');
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(Icons.info),
                              const Text("Diseases")
                            ],
                          ),
                        ),
                      ),
                    ),
                    //help and faq
                    Card(
                      margin: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/help');
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(Icons.help),
                              const Text("Help")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
