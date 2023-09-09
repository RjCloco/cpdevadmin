import 'package:flutter/material.dart';

class CRMList extends StatefulWidget {
  const CRMList({super.key});

  @override
  State<CRMList> createState() => _CRMListState();
}

class _CRMListState extends State<CRMList> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF1046A8),
              borderRadius: BorderRadius.circular(7.0),
            ),
            height: 100,
            width: 1200,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Customer',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
                ),
                SizedBox(height: 10
                    ,width: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Search by ',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 200.0, // Set the desired width
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        //SizedBox(width: 170.0), // Spacing between previous widget and this one
                        // SizedBox(width: 130.0), // Spacing between Phone number and Search button
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone number: ',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 270.0, // Set the desired width
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your search functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // White color for the button background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0), // Spacing below the search section
          // Add DataTable with headers and rows
          DataTable(
            columns: [
              DataColumn(label: Text('S.No',style: TextStyle(fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Customer',style: TextStyle(fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Address',style: TextStyle(fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Email',style: TextStyle(fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold),)),
            ],
            rows: [
              // Add your data rows here
              DataRow(
                cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Customer 1')),
                  DataCell(Text('123-456-7890')),
                  DataCell(Text('Address 1')),
                  DataCell(Text('email1@example.com')),
                  DataCell(IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      // Handle edit action
                    },
                  )),
                ],
              ),
              // Add more data rows as needed
            ],
          ),
        ],
      );
  }
}

