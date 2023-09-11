import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'AppBar.dart';
import 'Provider.dart';
import 'SIdeBar.dart';

bool addchargestation = false;
bool addchargepoint = false;
int index=0;

List<String> amenities =[
  'mall',
  'Cafe',
  'Restaurant',
  'Hotel',
];

List<String> BusinessNames =[
  'Business Name 1',
  'Business Name 2',
  'Business Name 3',
];

class AssetManagement extends StatefulWidget {
  const AssetManagement({super.key});

  @override
  State<AssetManagement> createState() => _AssetManagementState();
}

class _AssetManagementState extends State<AssetManagement> {



  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SideBar(),
          ),
          Expanded(
            flex: 5,
            child:
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF242B5C), // Dark blue background color
                    Colors.black, // Black color for gradient
                  ],
                ),
              ),
              child: Stack(
                children: [
                  TopAppBar(),
                  Positioned(
                    top: 160,
                    left: MediaQuery.of(context).size.height / 36,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: 1160, // Set the width as needed
                        height:h, // Set the height as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 18.0, left: 18.0, bottom: 18.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            index = 0;
                                            addchargestation = false;
                                          });
                                        },
                                        child: Container(
                                          width: 150.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: (index==0)?Color(0xFF1046A8):Color(0xFFD3D3D3),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Charging Station',
                                              style: TextStyle(color: (index==0)?Colors.white:Color(0xFF1046A8)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            index = 1;
                                            addchargepoint=false;
                                          });

                                        },
                                        child: Container(
                                          width: 150.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: (index==1)?Color(0xFF1046A8):Color(0xFFD3D3D3),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Charging Points',
                                              style: TextStyle(color: (index==1)?Colors.white:Color(0xFF1046A8,)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:200,
                                        height: 30,
                                        child: TextFormField(
                                          // controller: ListSearch,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search..',
                                            filled: true, // Add a background color to the TextField
                                            fillColor: Color(
                                                0xFFDEE3E7), // Set the background color of the TextField
                                            prefixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.search),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(index==0){
                                              addchargestation = true;
                                            }
                                            if(index==1){
                                              addchargepoint = true;
                                            }

                                          });
                                        },
                                        child: Container(
                                          width: 80.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1046A8),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.add,color: Colors.white,size: 15,),
                                                Text(
                                                  'Add',
                                                  style: TextStyle(color: Colors.white,)),
                                              ],
                                            ),
                                          ),
                                          ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              if(index==0 && addchargestation==false)
                                ChargingStation(),
                              if(index==1&& addchargepoint==false)
                                ChargePoint(),
                              if(index==0 && addchargestation==true)
                                AddChargeStation(),
                              if(index==1 && addchargepoint==true)
                                AddChargePoint()
                            ],
                          )
                          // child: Column(
                          //   children: [
                          //    TextButton(onPressed: (){
                          //      Add();
                          //    }, child: Text("Add Charge Station")),
                          //     //TextButton(onPressed: (){}, child: Text("Add Charge Station")),
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
class ChargePoint extends StatefulWidget {
  const ChargePoint({super.key});

  @override
  State<ChargePoint> createState() => _ChargePointState();
}

class _ChargePointState extends State<ChargePoint> {

  TextEditingController ListSearch = new TextEditingController();
  void handleClick(int item) {

    switch (item) {
      case 0:
        {

          Navigator.pushNamed(context, '/AssetManagement');
          break;
        }
      case 1:
        {
          break;
        }
      case 2:
        {
          break;
        }
    }
  }

  List<Map<String,dynamic>> chargingpoints =[
    {
      'S.No':"1",
      'CPID':"1231",
      'CP Display Name':"Retina display",
      'OEM':"12e122",
      'Model': "Delta50KWSingle",
      'Station':"Charge Partners Gandhipuram",
      'Tariff':"Default",
      'Last Message Received':"Sep 9,2023 3:01:34 PM",
      'Status':"Completed",
      'Published': "Yes",
      'Actions': 'View',

    }
  ];

  @override
  Widget build(BuildContext context) {
    // final sidebarProvider = Provider.of<SidebarProvider>(context);
    return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Charge Stations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 80.24,
                columns: [
                  DataColumn(
                    label: Text(
                      'S.NO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('CPID', style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Text('CP Display Name',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('OEM', style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  DataColumn(
                    label:
                    Text('Model', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text(
                      'Charge Stations',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label:
                    Text('Tariff', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Last Message Received', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label:
                    Text('STATUS', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('PUBLISHED',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('ACTIONS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows:chargingpoints.map<DataRow>((data) {
                  return DataRow(cells: [
                    DataCell(Text(data['S.No'] ?? 'N/A')),
                    DataCell(Text(data['CPID'].toString())),
                    DataCell(Text(data['CP Display Name'].toString())),
                    DataCell(Text(data['OEM'] ?? 'N/A')),
                    DataCell(Text(data['Model'].toString())),
                    DataCell(Text(data['Station'] ?? 'N/A')),
                    DataCell(Text(data['Tariff'].toString())),
                    DataCell(Text(data['Last Message Received'].toString())),
                    DataCell(Text(data['Status'] ?? 'N/A')),
                    DataCell(Text(data['Published'].toString())),
                    DataCell(
                      PopupMenuButton<int>(
                        onSelected: (item) => handleClick(item),
                        itemBuilder: (context) => [
                          // PopupMenuItem<int>(value: 0, child: Text('Profile')),
                          PopupMenuItem<int>(value: 0, child: Text('View')),
                          PopupMenuItem<int>(value: 1, child: Text('Edit'))
                          // PopupMenuItem<int>(value: 2, child: Text('Delete Account')),
                        ],
                      ),
                    ),
                    // Add more cells for other columns
                  ]);
                }).toList(),
              ),
            ),
          ],
        );
  }
}


class ChargingStation extends StatefulWidget {
  const ChargingStation({super.key});

  @override
  State<ChargingStation> createState() => _ChargingStationState();
}

class _ChargingStationState extends State<ChargingStation> {
  List<Map<String,dynamic>> chargingStations =[
    {
      'Name':"Charge Station",
      'Address': "CBE",
      'Latitude': 90.896,
      'Longitude': 89.789,
      'Owner Name': "Swetha",
      'Actions': 'View'

    }
  ];
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: DataTable(
        columnSpacing: 80.24,
        columns: [
          DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
          DataColumn(label: Text('Address',style: TextStyle(fontWeight: FontWeight.bold)),),
          DataColumn(label: Text('Latitude',style: TextStyle(fontWeight: FontWeight.bold)),),
          DataColumn(label: Text('Longitude',style: TextStyle(fontWeight: FontWeight.bold)),),
          DataColumn(label: Text('Owner Name',style: TextStyle(fontWeight: FontWeight.bold)),),
          DataColumn(label: Text('Actions',style: TextStyle(fontWeight: FontWeight.bold)),),

        ],
        rows: chargingStations.map<DataRow>((data) {
          return DataRow(cells: [
            DataCell(Text(data['Name'] ?? 'N/A')),
            DataCell(Text(data['Address'].toString())),
            DataCell(Text(data['Latitude'].toString())),
            DataCell(Text(data['Longitude'].toString())),
            DataCell(Text(data['Owner Name'].toString())),
            DataCell(Text(data['Actions'].toString())),

            // Add more cells for other columns
          ]);
        }).toList(),
      ),
    );
  }
}

class AddChargeStation extends StatefulWidget {
  const AddChargeStation({super.key});

  @override
  State<AddChargeStation> createState() => _AddChargeStationState();
}

class _AddChargeStationState extends State<AddChargeStation> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  String? SelectedBusinessName ='';
  TextEditingController LocationName = new TextEditingController();
  TextEditingController Street = new TextEditingController();
  TextEditingController PinCode = new TextEditingController();
  TextEditingController City = new TextEditingController();
  TextEditingController State = new TextEditingController();
  TextEditingController Latitude = new TextEditingController();
  TextEditingController Longitude = new TextEditingController();
  TextEditingController StartTime = new TextEditingController();
  TextEditingController EndTime = new TextEditingController();
  // TextEditingController CommissionedDate = new TextEditingController();
  TextEditingController SupportPersonName = new TextEditingController();
  TextEditingController SupportContact = new TextEditingController();
  TextEditingController SupportEmail = new TextEditingController();
  List<String> selectedAmenities=[];
  bool checkaminities = false;
  Future<bool> _checkCollectionExists(CollectionReference collectionRef) async {
    try {
      // Fetch the first document from the collection (if it exists)
      await collectionRef.limit(1).get();
      return true;
    } catch (e) {
      // If an error occurs, the collection doesn't exist
      return false;
    }
  }

  GeoPoint stringToGeoPoint(String lat, String long) {
    double latitude = double.parse(lat);
    double longituide = double.parse(long);
    GeoPoint geoPoint = GeoPoint(latitude, longituide);
    return geoPoint;
  }
  void _showMessage(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> DataBaseAddChargeStation() async {

    String collectionName = 'Stations'; // Replace with your desired collection name
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);
    // Check if the collection exists
    final bool collectionExists = await _checkCollectionExists(collectionRef);
    // If the collection doesn't exist, create it

    if (!collectionExists) {
      await collectionRef.add({
        'station_id': FieldValue.serverTimestamp(),
        'LocationName': LocationName.text,
        'address':{
          'city':City.text,
          'pincode':PinCode.text,
          'state':State.text,
          'street':Street.text
        },
        'map_coordinates':stringToGeoPoint(Latitude.text,Longitude.text),
        'opening_hour':{
          'commissioned_date': dateInput.text,
          'from':StartTime.text,
          'to':EndTime.text,
        },
        'amenities':selectedAmenities,

      });
      _showMessage("Product Added to the DataBase");
    }
    // Add the document to the collection
    await collectionRef.add({
      'station_id':collectionRef.doc(),
      'LocationName': LocationName.text,
      'address':{
        'city':City.text,
        'pincode':PinCode.text,
        'state':State.text,
        'street':Street.text
      },
      'map_coordinates':stringToGeoPoint(Latitude.text,Longitude.text),
      'opening_hour':{
        'commissioned_date': dateInput.text,
        'from':StartTime.text,
        'to':EndTime.text,
      },
      'amenities':selectedAmenities,
      'location_support_information':{
        'support_contact_number':SupportContact.text,
        'support_email_id': SupportEmail.text,
        'support_person_name':SupportPersonName.text
      }

    });
    _showMessage("Product Added to the DataBase");
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;




    return Visibility(
      visible: addchargestation==true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Add Charge Station",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.black, // Set the color of the line
            thickness: 0.3, // Set the thickness of the line
            height: 20, // Set the height of the line (space below text)
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              // border: Border.all(color: Color(0xFF1046A8),width: 3)
                              border: Border(
                                  top: BorderSide(
                                      color:Color(0xFF1046A8), width: 2
                                  ),
                                  bottom: BorderSide(
                                      color: Color(0xFF1046A8), width: 5
                                  ),

                                  left: BorderSide(
                                      color: Color(0xFF1046A8), width: 2
                                  ),
                                  right: BorderSide(
                                      color: Color(0xFF1046A8), width: 2
                                  )
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 193,
                                    width: 500,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color:Color(0xFF1046A8), width: 2
                                            ),
                                            bottom: BorderSide(
                                                color: Color(0xFF1046A8), width: 5
                                            ),

                                            left: BorderSide(
                                                color: Color(0xFF1046A8), width: 2
                                            ),
                                            right: BorderSide(
                                                color: Color(0xFF1046A8), width: 2
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Row(
                                          children: [
                                            Text("Location Name "),
                                            Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      // Icon(Icons.,color: Colors.red,)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                    child: SizedBox(
                                      width: 500,
                                      height: 30,
                                      child: TextFormField(
                                        controller: LocationName,
                                        decoration: InputDecoration(
                                          hintText: 'Location Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, // Set the border color to black
                                              width: 1.6, // Set the border thickness
                                            ),
                                          ),
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Mandatory Field";

                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Address "),
                                          Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      // Icon(Icons.star)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                    child: SizedBox(
                                      width: 500,
                                      height: 30,
                                      child: TextFormField(
                                        controller: Street,
                                        decoration: InputDecoration(
                                          hintText: 'Street',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, // Set the border color to black
                                              width: 1.6, // Set the border thickness
                                            ),
                                          ),
                                           // Remove the default border
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Mandatory Field";

                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                    child: SizedBox(
                                      width: 500,
                                      height: 30,
                                      child: TextFormField(
                                        controller: PinCode,
                                        decoration: InputDecoration(
                                          hintText: 'Pin Code',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, // Set the border color to black
                                              width: 1.6, // Set the border thickness
                                            ),
                                          ),
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Mandatory Field";

                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                        child: SizedBox(
                                          width:240,
                                          height: 30,
                                          child: TextFormField(
                                            controller: City,
                                            decoration: InputDecoration(
                                              hintText: 'City',
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.black, // Set the border color to black
                                                    width: 1.6, // Set the border thickness
                                                  ),
                                                ),
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Mandatory Field";

                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                        child: SizedBox(
                                          width: 240,
                                          height: 30,
                                          child: TextFormField(
                                            controller: State,
                                            decoration: InputDecoration(
                                              hintText: 'State',
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.black, // Set the border color to black
                                                    width: 1.6, // Set the border thickness
                                                  ),
                                                ),
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Mandatory Field";

                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF1046A8),width: 3)
                        ),
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Map Co-Ordinates'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  child: SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      controller: Longitude,
                                      decoration: InputDecoration(
                                        hintText: 'Longitude',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color to black
                                            width: 1.6, // Set the border thickness
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  child: SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      controller: Latitude,
                                      decoration: InputDecoration(
                                        hintText: 'Latitude',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color to black
                                            width: 1.6, // Set the border thickness
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('Opening Hour '),
                                Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  child: SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      controller: StartTime,
                                      decoration: InputDecoration(
                                        hintText: 'Start Time',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color to black
                                            width: 1.6, // Set the border thickness
                                          ),
                                        ),
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Mandatory Field";

                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  child: SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      controller: EndTime,
                                      decoration: InputDecoration(
                                        hintText: 'End Time',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color to black
                                            width: 1.6, // Set the border thickness
                                          ),
                                        ),
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Mandatory Field";

                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Commissioned Date"),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                              child: SizedBox(
                                width: 500,
                                height: 30,
                                child:  TextField(
                                  controller: dateInput,
                                  //editing controller of this TextField
                                  decoration: InputDecoration(
                                    hintText: 'Enter Date',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.black, // Set the border color to black
                                        width: 1.6, // Set the border thickness
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                ),
                                // child: TextFormField(
                                //   decoration: InputDecoration(
                                //     hintText: 'Commissioned Date',
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //       borderSide: BorderSide(
                                //         color: Colors.black, // Set the border color to black
                                //         width: 1.6, // Set the border thickness
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Amenities"),
                            Padding(
                              padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                              child: SizedBox(
                                width: 500,
                                height: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:   Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: amenities.map((Data) {
                                      return  GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedAmenities.contains(Data)) {
                                              selectedAmenities.remove(Data);
                                              print(selectedAmenities);
                                            } else {
                                              selectedAmenities.add(Data);
                                              print(selectedAmenities);
                                            }
                                          });
                                        },
                                        child: Chip(
                                          label:  (selectedAmenities.contains(Data))?Text('$Data x',style: TextStyle(color: Colors.white),):Text('+ $Data'),
                                          backgroundColor: (selectedAmenities.contains(Data))
                                              ? Color(0xFF1046A8) // Blue when selected
                                              : null,      // Grey when not selected
                                        ),
                                      );

                                    }).toList(),
                                  ),
                                )
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Location support information "),
                                Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Padding(
                              padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                              child: SizedBox(
                                width: 500,
                                height: 30,
                                child: TextFormField(
                                  controller: SupportPersonName,
                                  decoration: InputDecoration(
                                    hintText: 'Support Person Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.black, // Set the border color to black
                                        width: 1.6, // Set the border thickness
                                      ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Mandatory Field";
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 30,
                                  child: TextFormField(
                                    controller: SupportContact,
                                    decoration: InputDecoration(
                                      hintText: 'Support Contact Number',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.black, // Set the border color to black
                                          width: 1.6, // Set the border thickness
                                        ),
                                      ),
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Mandatory Field";

                                      }
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: 240,
                                  height: 30,
                                  child: TextFormField(
                                    controller: SupportEmail,
                                    decoration: InputDecoration(
                                      hintText: ' Support Email ID',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.black, // Set the border color to black
                                          width: 1.6, // Set the border thickness
                                        ),
                                      ),

                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Mandatory Field";

                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Business Name "),
                                Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                              child: SizedBox(
                                width: 500,
                                height: 48,
                                child: DropdownButtonFormField(
                                  items: BusinessNames.map((names) {
                                    return DropdownMenuItem(
                                      value: names,
                                      child: Text('$names',style: TextStyle(fontSize: 15),),
                                    );
                                  }).toList(),
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      SelectedBusinessName = selectedValue;
                                      // SelectedAge = selectedValue as List<dynamic>;
                                    });
                                  },
                                  value: BusinessNames.isNotEmpty ? BusinessNames[0] : null,
                                  decoration: InputDecoration(
                                    labelText: "Select Business Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            print("Validated");
                            DataBaseAddChargeStation();
                          }
                        },
                        child: Container(
                          width: 120.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF1046A8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white,)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            index = 0;
                            addchargestation = false;
                          });

                        },
                        child: Container(
                          width: 120.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0xFF1046A8)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  'Cancel',
                                  style: TextStyle(color:Color(0xFF1046A8),)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class AddChargePoint extends StatefulWidget {
  const AddChargePoint({super.key});

  @override
  State<AddChargePoint> createState() => _AddChargePointState();
}

class _AddChargePointState extends State<AddChargePoint> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool _switchValue = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Add Charge Point",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Colors.black, // Set the color of the line
          thickness: 0.3, // Set the thickness of the line
          height: 20, // Set the height of the line (space below text)
        ),
        Form(
          // key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(15),
                        // border: Border.all(color: Color(0xFF1046A8),width: 3)
                          border: Border(
                              top: BorderSide(
                                  color:Color(0xFF1046A8), width: 2
                              ),
                              bottom: BorderSide(
                                  color: Color(0xFF1046A8), width: 5
                              ),

                              left: BorderSide(
                                  color: Color(0xFF1046A8), width: 2
                              ),
                              right: BorderSide(
                                  color: Color(0xFF1046A8), width: 2
                              )
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:18.0),
                            child: Text("Add charge point information",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Row(
                                  children: [
                                    Text("Charging Location "),
                                    Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              // Icon(Icons.,color: Colors.red,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Select charge location',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Charging Point OEM "),
                                  Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              // Icon(Icons.star)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Select OEM',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                  // Remove the default border
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Model Name"),
                                  Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              // Icon(Icons.star)
                            ],
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Select Model Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Charge Point Display Name"),
                                  Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              // Icon(Icons.star)
                            ],
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Authorization Key"),
                                  Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              // Icon(Icons.star)
                            ],
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Key',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFF1046A8),width: 3)
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text("Charge Point ID "),
                              ),
                              // Icon(Icons.,color: Colors.red,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Auto generated ID',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Box Number"),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Box Number',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                  // Remove the default border
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Serial Number"),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Serial Number',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color to black
                                      width: 1.6, // Set the border thickness
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mandatory Field";

                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Commissioned Date "),
                                      Text("*",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  Center(
                                      child: SizedBox(
                                        width: 150,
                                        height: 30,
                                        child: TextField(
                                          controller: dateInput,
                                          //editing controller of this TextField
                                          decoration: InputDecoration(
                                            hintText: 'Enter Date',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.black, // Set the border color to black
                                                width: 1.6, // Set the border thickness
                                              ),
                                            ),
                                          ),
                                          readOnly: true,
                                          //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(pickedDate);
                                              print(
                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                              setState(() {
                                                dateInput.text =
                                                    formattedDate; //set output date to TextField value.
                                              });
                                            } else {}
                                          },
                                        ),
                                      ))
                                  // Padding(
                                  //   padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  //   child: SizedBox(
                                  //     width: 150,
                                  //     height: 30,
                                  //     child: TextFormField(
                                  //       decoration: InputDecoration(
                                  //         hintText: 'Date',
                                  //         enabledBorder: OutlineInputBorder(
                                  //           borderRadius: BorderRadius.circular(10.0),
                                  //           borderSide: BorderSide(
                                  //             color: Colors.black, // Set the border color to black
                                  //             width: 1.6, // Set the border thickness
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       validator: (value){
                                  //         if(value!.isEmpty){
                                  //           return "Mandatory Field";
                                  //
                                  //         }
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Latitude"),
                                  Padding(
                                    padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                    child: SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter latitude',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, // Set the border color to black
                                              width: 1.6, // Set the border thickness
                                            ),
                                          ),
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Mandatory Field";

                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Longitude"),
                                  Padding(
                                    padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                                    child: SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter Longitude',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, // Set the border color to black
                                              width: 1.6, // Set the border thickness
                                            ),
                                          ),
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Mandatory Field";

                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Icon(Icons.star)
                            ],
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Published"),
                                    CupertinoSwitch(
                                      activeColor: Colors.black,
                                      value: _switchValue,
                                      onChanged: (value) {
                                        // print("switch $_switchValue");
                                        setState(() {
                                          print(value);
                                          _switchValue = value;
                                          print("switch $_switchValue");
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Enable Reservation"),
                                    CupertinoSwitch(
                                      activeColor: Colors.black,
                                      value: _switchValue,
                                      onChanged: (value) {
                                        // print("switch $_switchValue");
                                        setState(() {
                                          print(value);
                                          _switchValue = value;
                                          print("switch $_switchValue");
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const  EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: SizedBox(
                              width: 500,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Enable Data Transfer"),
                                    CupertinoSwitch(
                                      activeColor: Colors.black,
                                      value: _switchValue,
                                      onChanged: (value) {
                                        // print("switch $_switchValue");
                                        setState(() {
                                          print(value);
                                          _switchValue = value;
                                          print("switch $_switchValue");
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        // if(formKey.currentState!.validate()){
                        //   print("Validated");
                        // }
                      },
                      child: Container(
                        width: 120.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF1046A8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white,)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        width: 120.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Color(0xFF1046A8)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                'Cancel',
                                style: TextStyle(color:Color(0xFF1046A8),)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
