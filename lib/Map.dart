// import 'package:flutter/material.dart';
// import 'dart:html';
// import 'package:google_maps/google_maps.dart';
// import 'dart:ui' as ui;
//
// import 'package:location/location.dart';
//
//
// class getMap extends StatefulWidget {
//   const getMap({super.key});
//
//   @override
//   State<getMap> createState() => _getMapState();
// }
//
// class _getMapState extends State<getMap> {
//
//
//   LocationData? currentLocation;
//
//   void getCurrentLocation() {
//     Location location = Location();
//
//     location.getLocation().then((location) {
//       setState(() {
//         currentLocation = location;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// Widget getMap() {
//   String htmlId = "7";
//   // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//     final myLatlng = LatLng(1.3521, 103.8198);
//
//     final mapOptions = MapOptions()
//       ..zoom = 10
//       ..center = LatLng(1.3521, 103.8198);
//
//     final elem = DivElement()
//       ..id = htmlId
//       ..style.width = "100%"
//       ..style.height = "100%"
//       ..style.border = 'none';
//
//     final map = GMap(elem, mapOptions);
//
//     Marker(MarkerOptions()
//       ..position = myLatlng
//       ..map = map
//       ..title = 'Hello World!'
//     );
//
//     return elem;
//   });
//
//   return HtmlElementView(viewType: htmlId);
// }
library maps_launcher;
import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:the_widget_marker/the_widget_marker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Provider.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({Key? key}) : super(key: key);

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  List<Marker> _otherMarkers=[];
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();

  static const LatLng officeLoc = LatLng(11.0201, 76.9627); //cloco office
  static const LatLng funmall = LatLng(11.0247, 77.0106); //Fun mall
  static const LatLng lakshmicomplex = LatLng(11.0169, 76.9655); //lakshmi complex
  static const LatLng racecourse = LatLng(10.9991, 76.9773);
  static const LatLng prozone = LatLng(11.0548, 76.9941);

  List<LatLng> markers_latlong = [
    LatLng(11.0247, 77.0106),
    LatLng(11.0169, 76.9655),
    LatLng(10.9991, 76.9773),
    LatLng(11.0548, 76.9941),
  ];

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  }

  Future<List<DocumentSnapshot>> fetchData() async {
    // Get a reference to the 'StationManagement' collection
    CollectionReference stationCollection = FirebaseFirestore.instance.collection('StationManagement');

    try {
      QuerySnapshot querySnapshot = await stationCollection.where('ActiveStatus', isEqualTo: true).get();
      return querySnapshot.docs;
    } catch (error) {
      // Handle any errors that occur during the data fetch
      print('Error fetching data: $error');
      return [];
    }
  }



  Future<void> DBAddStation()async {
    String collectionName = 'StationManagement'; // Replace with your desired collection name
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final DocumentSnapshot docSnapshot = await collectionRef.doc('Lakshmi Mills').get();
      await collectionRef.doc('Lakshmi Mills').set({
       'ActiveStatus': true,
        'Address': {
         'City': 'Coimbatore',
          'State':'Tamil Nadu',
          'PinCode':641062,
        },
        'CreatedAt':  DateTime.now(),
        'Latitude':11.0169,
        'Longitude':76.9655,
        'StationName': 'Lakshmi Mills',
        'Description': 'Lakshmi complex'
        // Add other fields if required

      });

  }

  Future<void>  AddStationdata(List<DocumentSnapshot<Object?>> stationData) async {
    for (var document in stationData) {
      _otherMarkers.add(
        Marker(
            markerId:MarkerId(document['StationName']),
            position: LatLng(document['Latitude'],document['Longitude']),
            infoWindow: InfoWindow(
              title: document['StationName'],
              snippet:document['Description'],
              onTap: () {
                _onMarkerTapped(document['ChargingStation'], document['Description'],document['Latitude'], document['Longitude']);
              },
            ),
            // icon: markerIcon,
            icon: await MarkerIcon.downloadResizePictureCircle(
            'assets/image2.png',
            size: 40,
            addBorder: true,
            borderColor: Colors.white,
            borderSize: 15
        ),
      ),
    );// Add more fields as needed
      //print(_otherMarkers);
  }
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Future <void> addCustomIcon()  async{
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(0.5,0.5)),
        'assets/image2.png')
        .then((icon) {
      setState(() {
        markerIcon = icon;
        print(markerIcon);
      });
      // markerIcon = icon;
    }
    );

    // final Uint8List markIcons = await getImages('assets/error.jpeg', 50);
  }

  // Future<Uint8List> getImages(String path, int width) async{
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  //
  // }






  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> locations = [
    {'latitude': 11.0247, 'longitude': 77.0106, 'stationName': 'Fun Mall','town': 'Peelamedu','city':'Coimbatore'},
    {'latitude': 11.0169, 'longitude': 76.9655, 'stationName': 'Lakshmi Complex','town': 'Gandhipuram','city':'Coimbatore'},
    {'latitude': 11.0548,'longitude': 76.9941, 'stationName' : 'Prozone','town': 'Saravanampatti','city':'Coimbatore'},
  ];

  void _onSearchIconPressed() {
    final String searchInput = _searchController.text.toLowerCase();
    bool foundMatch = false;

    for (final location in locations) {
      if (location['stationName'].toString().toLowerCase() == searchInput ||
          location['town'].toString().toLowerCase() == searchInput ||
          location['city'].toString().toLowerCase() == searchInput) {
        _moveToLocation(location['latitude'] as double, location['longitude'] as double);
        foundMatch = true;
        break;
      }
    }

    if (!foundMatch) {
      print("Failed");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Not Found'),
            content: Text('The searched location was not found in the list.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  void _moveToLocation(double latitude, double longitude) {
    if (_controller.isCompleted) {
      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude, longitude)),
        );
      });
    }
  }

  @override
  void dispose() {
    //_customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // DBAddStation();
    //getCurrentLocation();
     //addCustomIcon();


    super.initState();
  }

  _onMarkerTapped(String name, String snippet,double latitude, double longitude) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerDetailsPage(title: name, snippet: snippet,lat: latitude ,long:longitude),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (currentLocation != null) {
    //   _otherMarkers.add(
    //     Marker(
    //       markerId: const MarkerId("Current location"),
    //       position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    //       infoWindow: InfoWindow(
    //         title: 'Current Location',
    //         snippet: ('${LatLng(currentLocation!.latitude!, currentLocation!.longitude!)}'),
    //       ),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    //       // icon: markerIcon,
    //     ),
    //   );
    // }
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          sidebarProvider.stationData = snapshot.data!;
          // print('Other markers: $_otherMarkers');
          return FutureBuilder<void>(
            future: AddStationdata(sidebarProvider.stationData),
            builder: (BuildContext context, AsyncSnapshot<void> addStationSnapshot) {
              if (addStationSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (addStationSnapshot.hasError) {
                return Center(child: Text('Error: ${addStationSnapshot.error}'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      height: 30,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search location..',
                          filled: true,
                          fillColor: Color(0xFFDEE3E7),
                          prefixIcon: IconButton(
                            onPressed: _onSearchIconPressed,
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 400,
                      width: 1200,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) async {
                          _customInfoWindowController.googleMapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(11.1271, 76.6569),
                          zoom: 10, // Adjust the zoom level as needed
                        ),
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        markers: Set<Marker>.from(_otherMarkers),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );


  }
}

class MarkerDetailsPage extends StatelessWidget {
  final String title;
  final String snippet;
  double lat;
  double long;

  MarkerDetailsPage({required this.title, required this.snippet,required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Place name : "),
                Text(title),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Description : "),
                Text(snippet),
              ],
            ),
            ElevatedButton(
              onPressed: () => MapsLauncher.launchCoordinates(
                  lat, long, title),
              child: Text('Redirect to map'),
            ),
          ],
        ),
      ),
    );
  }
}



class MapsLauncher {
  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing the result of a search query.
  static Uri createQueryUri(String query) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': query});
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': query});
    }

    return uri;
  }

  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing coordinates ([latitude] and [longitude]).
  static Uri createCoordinatesUri(double latitude, double longitude,
      [String? label]) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$latitude,$longitude'});
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';

      if (label != null) query += '($label)';

      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {
        'll': '$latitude,$longitude',
        'q': label ?? '$latitude, $longitude',
      };

      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$latitude,$longitude'});
    }

    return uri;
  }

  /// Launches the maps application for this platform.
  /// The maps application will show the result of the provided search [query].
  /// Returns a Future that resolves to true if the maps application
  /// was launched successfully, false otherwise.
  static Future<bool> launchQuery(String query) {
    return launchUrl(createQueryUri(query));
  }

  /// Launches the maps application for this platform.
  /// The maps application will show the specified coordinates.
  /// Returns a Future that resolves to true if the maps application
  /// was launched successfully, false otherwise.
  static Future<bool> launchCoordinates(double latitude, double longitude,
      [String? label]) {
    return launchUrl(createCoordinatesUri(latitude, longitude, label));
  }
}