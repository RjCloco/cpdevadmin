import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'AppBar.dart';
import 'SIdeBar.dart';
class AssetManagement extends StatefulWidget {
  const AssetManagement({super.key});

  @override
  State<AssetManagement> createState() => _AssetManagementState();
}

class _AssetManagementState extends State<AssetManagement> {
  int index=0;

  @override
  Widget build(BuildContext context) {
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
                    child: Container(
                      width: 1160, // Set the width as needed
                      height: 550, // Set the height as needed
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
                                          index=2;
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
                            if(index==0)
                              Add(),
                              // ChargingStation(),
                            if(index==1)
                              ChargePoint(),
                            if(index==2)
                              Add()
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

  Color ChooseColor(String status) {
    if (status == 'Completed') {
      return Colors.green;
    } else if (status == 'On going') {
      return Colors.orange;
    } else if (status == 'At risk') {
      return Colors.red;
    } else if (status == 'Unknown') {
      return Colors.grey;
    } else {
      return Colors.yellow;
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

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String selectedCountryCode = "+1"; // Default country code
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Charge Station",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.black, // Set the color of the line
              thickness: 0.3, // Set the thickness of the line
              height: 20, // Set the height of the line (space below text)
            ),
            Form(
              key: formKey,
              child: Row(
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
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
                                  Text("Location Name"),
                                  // Icon(Icons.,color: Colors.red,)
                                ],
                              ),
                              SizedBox(
                                width: 400,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Location Name',
                                    border:
                                    OutlineInputBorder(), // Remove the default border
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
                                  Text("Address"),
                                  // Icon(Icons.star)
                                ],
                              ),
                              SizedBox(
                                width: 400,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Street',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                      borderSide: BorderSide(
                                        color: Colors.black, // Set the border color to black
                                        width: 30.0, // Set the border thickness
                                      ),
                                    ),
                                     // Remove the default border
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 400,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Pin Code',
                                    border:
                                    OutlineInputBorder(), // Remove the default border
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:200,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'City',
                                        border:
                                        OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'State',
                                        border:
                                        OutlineInputBorder(), // Remove the default border
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Map Co-Ordinates'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Longitude',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Latitude',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Opening Hour'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Start Time',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'End Time',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Commissioned Date"),
                              SizedBox(
                                width: 400,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Commissioned Date',
                                    border: OutlineInputBorder(), // Remove the default border
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amenities"),
                              SizedBox(
                                width: 400,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(), // Remove the default border
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location support information"),
                              SizedBox(
                                width: 500,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Support Person Name',
                                    border: OutlineInputBorder(), // Remove the default border
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
                                      decoration: InputDecoration(
                                        hintText: 'Support Contact Number',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 240,
                                    height: 30,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: ' Support Email ID',
                                        border: OutlineInputBorder(), // Remove the default border
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Business Name"),
                              SizedBox(
                                width: 500,
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Business Name',
                                    border: OutlineInputBorder(), // Remove the default border
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      );
  }
}
