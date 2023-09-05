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
  List<DocumentSnapshot> stationData = [];

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

  void _fetchData() async {
    // Get a reference to the 'StationManagement' collection
    CollectionReference stationCollection = FirebaseFirestore.instance.collection('StationManagement');

    // Fetch the documents in the collection
    QuerySnapshot querySnapshot = await stationCollection.where('ActiveStatus' ,isEqualTo: true).get();

    // Store the documents in the stationData list
    setState(() {
      stationData = querySnapshot.docs;
    });

    AddStationdata();
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

  void  AddStationdata() {
    for (var document in stationData) {
      setState(() {
        _otherMarkers.add(
            Marker(
              markerId:MarkerId(document['StationName']),
              position: LatLng(document['Latitude'],document['Longitude']),
                onTap: () {
                        _customInfoWindowController.addInfoWindow!(
                          GestureDetector(
                            onTap: (){
                              _onMarkerTapped(document['StationName'], document['Description'], document['Latitude'], document['Longitude']);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[700],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text(
                                          document['StationName'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          document['Description'],
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Triangle.isosceles(
                                  edge: Edge.BOTTOM,
                                  child: Container(
                                    color: Colors.green[700],
                                    width: 20.0,
                                    height: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          lakshmicomplex,
                        );
                      },
            )
        );
      });

      // Add more fields as needed
    }
    // print(_otherMarkers);
  }



  // late List<Marker> _otherMarkers = [
  //   Marker(
  //     markerId: const MarkerId("Lakshmi Complex"),
  //     position: lakshmicomplex,
  //     onTap: () {
  //       _customInfoWindowController.addInfoWindow!(
  //         GestureDetector(
  //           onTap: (){
  //             _onMarkerTapped('Lakshmi Complex', 'Charging station',11.0169, 76.9655);
  //           },
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.green[700],
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.account_circle,
  //                         color: Colors.white,
  //                         size: 30,
  //                       ),
  //                       Text(
  //                         "Lakshmi complex",
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       Text(
  //                         "Charging station",
  //                         style: TextStyle(color: Colors.white),
  //                       )
  //                     ],
  //                   ),
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                 ),
  //               ),
  //               Triangle.isosceles(
  //                 edge: Edge.BOTTOM,
  //                 child: Container(
  //                   color: Colors.green[700],
  //                   width: 20.0,
  //                   height: 10.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         lakshmicomplex,
  //       );
  //     },
  //     // infoWindow: InfoWindow(
  //     //   title: 'Lakshmi Complex',
  //     //   snippet: 'Charging station',
  //     //   onTap: () {
  //     //     _onMarkerTapped('Lakshmi Complex', 'Charging station',11.0169, 76.9655);
  //     //   },
  //     // ),
  //     icon: BitmapDescriptor.defaultMarker,
  //   ),
  //   Marker(
  //     markerId: const MarkerId("Fun Mall"),
  //     position: funmall,
  //     onTap: () {
  //       _customInfoWindowController.addInfoWindow!(
  //         GestureDetector(
  //           onTap: (){
  //             _onMarkerTapped('Fun Mall', 'Mall',11.0247, 77.0106);
  //           },
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.green[700],
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.account_circle,
  //                         color: Colors.white,
  //                         size: 30,
  //                       ),
  //                       Text(
  //                         "Fun Mall",
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       Text(
  //                         "Mall",
  //                         style: TextStyle(color: Colors.white),
  //                       )
  //                     ],
  //                   ),
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                 ),
  //               ),
  //               Triangle.isosceles(
  //                 edge: Edge.BOTTOM,
  //                 child: Container(
  //                   color: Colors.green[700],
  //                   width: 20.0,
  //                   height: 10.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         funmall,
  //       );
  //     },
  //     // infoWindow: InfoWindow(
  //     //   title: 'Fun Mall',
  //     //   snippet: 'Mall',
  //     //   onTap: () {
  //     //     _onMarkerTapped('Fun Mall', 'Mall',11.0247, 77.0106);
  //     //   },
  //     // ),
  //     icon: markerIcon,
  //   ),
  //   Marker(
  //     markerId: const MarkerId("Race Course"),
  //     position: racecourse,
  //     onTap: () {
  //       _customInfoWindowController.addInfoWindow!(
  //         GestureDetector(
  //           onTap: (){
  //             _onMarkerTapped('Race Course', 'Hang out spots',10.9991, 76.9773);
  //           },
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.green[700],
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.account_circle,
  //                         color: Colors.white,
  //                         size: 30,
  //                       ),
  //                       Text(
  //                         "Race Course",
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       Text(
  //                         "Hang out spots",
  //                         style: TextStyle(color: Colors.white),
  //                       )
  //                     ],
  //                   ),
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                 ),
  //               ),
  //               Triangle.isosceles(
  //                 edge: Edge.BOTTOM,
  //                 child: Container(
  //                   color: Colors.green[700],
  //                   width: 20.0,
  //                   height: 10.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         racecourse,
  //       );
  //     },
  //
  //     // infoWindow: InfoWindow(
  //     //   title: 'Race Course',
  //     //   snippet: 'Hang out spots',
  //     //   onTap: () {
  //     //     _onMarkerTapped('Race Course', 'Hang out spots',10.9991, 76.9773);
  //     //   },
  //     // ),
  //
  //     // icon: BitmapDescriptor.defaultMarker,
  //     icon: markerIcon,
  //   ),
  //   Marker(
  //     markerId: const MarkerId("Prozone Mall"),
  //     position: prozone,
  //     onTap: () {
  //       _customInfoWindowController.addInfoWindow!(
  //         GestureDetector(
  //           onTap: (){
  //             _onMarkerTapped('Prozone Mall', 'Mall',11.0548, 76.9941);
  //           },
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.green[700],
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.account_circle,
  //                         color: Colors.white,
  //                         size: 30,
  //                       ),
  //                       Text(
  //                         "Prozone",
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       Text(
  //                         "Mall",
  //                         style: TextStyle(color: Colors.white),
  //                       )
  //                     ],
  //                   ),
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                 ),
  //               ),
  //               Triangle.isosceles(
  //                 edge: Edge.BOTTOM,
  //                 child: Container(
  //                   color: Colors.green[700],
  //                   width: 20.0,
  //                   height: 10.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         prozone,
  //       );
  //     },
  //
  //     // infoWindow: InfoWindow(
  //     //   title: 'Prozone',
  //     //   snippet: 'Mall',
  //     //   onTap: () {
  //     //     _onMarkerTapped('Prozone Mall', 'Mall',11.0548, 76.9941);
  //     //   },
  //     // ),
  //     // icon: BitmapDescriptor.defaultMarker,
  //     icon: markerIcon,
  //   ),
  // ];

  Future<void> _addMarkerWithDialog() async {
    double lat = 0;
    double lng = 0;
    String name = '';
    String snippet = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Marker'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  lat = double.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  lng = double.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Snippet'),
                onChanged: (value) {
                  snippet = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addMarker(lat, lng, name, snippet);
                print(_otherMarkers.length);
                print(_otherMarkers);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  // addCustomIcon()  async{
  //   BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(0.5,0.5)),
  //       'assets/img.png')
  //       .then((icon) {
  //     setState(() {
  //       markerIcon = icon;
  //     });
  //     // markerIcon = icon;
  //   }
  //   );
  //
  //   final Uint8List markIcons = await getImages('assets/img.png', 50);
  // }
  //
  // Future<Uint8List> getImages(String path, int width) async{
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  //
  // }

  void _addMarker(double latitude, double longitude, String name, String snippet) {
    final newMarker = Marker(
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      // infoWindow: InfoWindow(
      //   title: name,
      //   snippet: snippet,
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => MarkerDetailsPage(title: name, snippet: snippet,lat:latitude ,long: longitude,),
      //       ),
      //     );
      //   },
      // ),
      onTap: () {
        _customInfoWindowController.addInfoWindow!(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarkerDetailsPage(title: name, snippet: snippet,lat:latitude ,long: longitude,),
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          name,style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          snippet,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.green[700],
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
          ),
          LatLng(latitude, longitude),
        );
      },
      //icon: BitmapDescriptor.defaultMarker,
      icon: markerIcon,
    );

    setState(() {
      _otherMarkers.add(newMarker);
    });
  }

  void centerMapToCurrentLocation() {
    if (_controller.isCompleted && currentLocation != null) {
      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          ),
        );
      });
    }
  }

  void showBottomSheet(BuildContext context) {
    _otherMarkers = List.from(_otherMarkers.where((marker) => marker.markerId != const MarkerId("Current location")));
    _otherMarkers.sort((a, b) {
      double distanceToA = calculateDistanceInKm(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        a.position.latitude,
        a.position.longitude,
      );
      double distanceToB = calculateDistanceInKm(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        b.position.latitude,
        b.position.longitude,
      );
      return distanceToA.compareTo(distanceToB);
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // Initial size when the sheet is shown
          minChildSize: 0.2,     // Minimum size the sheet can be dragged to
          maxChildSize: 1.0,     // Maximum size the sheet can be dragged to
          expand: false,         // Whether the sheet can expand to its maximum size

          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: _otherMarkers.length,
              itemBuilder: (context, index) {
                final marker = _otherMarkers[index];

                double distanceInKm = calculateDistanceInKm(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                  marker.position.latitude,
                  marker.position.longitude,
                );

                return ListTile(
                  leading: Icon(Icons.location_pin),
                  title: Text(marker.infoWindow.title ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(marker.infoWindow.snippet ?? ''),
                      Text('Distance: ${distanceInKm.toStringAsFixed(2)} km'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarkerDetailsPage(
                          title: marker.infoWindow.title ?? '',
                          snippet: marker.infoWindow.snippet ?? '',
                          lat: marker.position.latitude,
                          long: marker.position.longitude,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  double calculateDistanceInKm(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // in km
    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

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
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    DBAddStation();
    _fetchData();
    getCurrentLocation();
    // addCustomIcon();


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
    if (currentLocation != null) {
      _otherMarkers.add(
        Marker(
          markerId: const MarkerId("Current location"),
          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: ('${LatLng(currentLocation!.latitude!, currentLocation!.longitude!)}'),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          // icon: markerIcon,
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: currentLocation == null
            ? Center(child: CircularProgressIndicator())
            :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Map View",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:  Color(0xFFDEE3E7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.map
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:  Color(0xFFDEE3E7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.list_alt
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: SizedBox(
                height: 30,
                child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search location..',
                                filled: true, // Add a background color to the TextField
                                fillColor:  Color(0xFFDEE3E7), // Set the background color of the TextField
                                prefixIcon: IconButton(
                                  onPressed: _onSearchIconPressed,
                                  icon: Icon(Icons.search),
                                ),
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
                      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                      zoom: 15,
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
        )
        //     : Stack(
        //   children: [
        //
        //     Positioned(
        //       child: GoogleMap(
        //         // onMapCreated: (GoogleMapController controller) {
        //         //   _controller.complete(controller);
        //         // },
        //         onMapCreated: (GoogleMapController controller) async {
        //           _customInfoWindowController.googleMapController = controller;
        //         },
        //         initialCameraPosition: CameraPosition(
        //           target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        //           zoom: 15,
        //         ),
        //         // initialCameraPosition: CameraPosition(
        //         //   target: officeLoc,
        //         //   zoom: 15,
        //         // ),
        //         onTap: (position) {
        //           _customInfoWindowController.hideInfoWindow!();
        //         },
        //         onCameraMove: (position) {
        //           _customInfoWindowController.onCameraMove!();
        //         },
        //
        //         markers: Set<Marker>.from(_otherMarkers),
        //       ),
        //     ),
        //
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       right: 0,
        //       child: Container(
        //         margin: EdgeInsets.symmetric(vertical: 10), // Add margin to the TextField
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: TextField(
        //             controller: _searchController,
        //             decoration: InputDecoration(
        //               hintText: 'Search for a location',
        //               filled: true, // Add a background color to the TextField
        //               fillColor: Colors.white, // Set the background color of the TextField
        //               border: OutlineInputBorder(
        //                 borderSide: BorderSide.none, // Remove border
        //                 borderRadius: BorderRadius.circular(18), // Add border radius
        //               ),
        //               suffixIcon: IconButton(
        //                 onPressed: _onSearchIconPressed,
        //                 icon: Icon(Icons.search),
        //               ),
        //             ),
        //             onSubmitted: (_) {
        //               _onSearchIconPressed();
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 75,
        //       left: 15,
        //       child: CircleAvatar(
        //         backgroundColor: Colors.green[700],
        //         radius: 28,
        //         child: IconButton(
        //           onPressed: (){
        //             _addMarkerWithDialog();
        //             print(_otherMarkers.length);
        //           },
        //
        //           icon: Icon(Icons.add_location_alt_outlined),
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //
        //     CustomInfoWindow(
        //       controller: _customInfoWindowController,
        //       height: 75,
        //       width: 150,
        //       offset: 50,
        //     ),
        //   ],
        // ),
      ),
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