import 'package:flutter/material.dart';

class CRM_Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Customer',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0), // Add spacing between "Customer" and "Group"
                        Container(
                          width: 250.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Group',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          '+Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0), // Add vertical spacing
                Expanded(
                  child: GridWidget(), // Add the GridWidget wrapped in Expanded
                ),
              ], // End of the Column children
            ), // End of the Column
          ], // End of the Stack children
        ), // End of the Stack
      ), // End of the Scaffold
    ); // End of the MaterialApp
  } // End of the build method
}

class GridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridItem(1),
              SizedBox(width: 100.0, height: 100,), // Add horizontal spacing between grids
              GridItem(2),
              SizedBox(width: 100.0, height: 100,), // Add horizontal spacing between grids
              GridItem(3),
            ],
          ),
          SizedBox(height: 10.0), // Add vertical spacing between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridItem(4),
              SizedBox(width: 100.0, height: 100,), // Add horizontal spacing between grids
              GridItem(5),
              SizedBox(width: 100.0, height: 100,), // Add horizontal spacing between grids
              GridItem(6),
            ],
          ),
        ],
      ),
    );
  }
}


class GridItem extends StatefulWidget {
  final int index;

  GridItem(this.index);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isOptionsVisible = false;
  bool isViewClicked = false;
  bool isEditClicked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 25.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: [
          Container(
            width: 250.0,
            height: 150.0,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Group name',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Admin User',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Admin Email',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'aaa',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'bbb',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'ccc',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  isOptionsVisible = !isOptionsVisible;
                });
              },
              child: Icon(
                Icons.more_vert,
                color: isOptionsVisible ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          if (isOptionsVisible)
            Positioned(
              top: 40.0,
              right: 8.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isViewClicked = !isViewClicked;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isViewClicked ? Colors.blue : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: isViewClicked ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isEditClicked = !isEditClicked;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isEditClicked ? Colors.blue : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: isEditClicked ? Colors.white : Colors.black,
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
    );
  }
}