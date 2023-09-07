import 'package:cpdevadmin/AppBar.dart';
import 'package:cpdevadmin/LoginScreen.dart';
import 'package:cpdevadmin/Map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ListDisplay.dart';
import 'SIdeBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int ViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
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
                                          if (ViewIndex == 0)
                                            Text(
                                              "Map View",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          if (ViewIndex == 1)
                                            Text(
                                              "List View",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    ViewIndex = 0;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: (ViewIndex == 0)
                                                          ? Color(0xFF1046A8)
                                                          : Color(0xFFDEE3E7)),
                                                  child: Icon(
                                                    Icons.map,
                                                    color: (ViewIndex == 0)
                                                        ? Colors.white
                                                        : Color(0xFF1046A8),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    ViewIndex = 1;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: (ViewIndex == 1)
                                                          ? Color(0xFF1046A8)
                                                          : Color(0xFFDEE3E7)),
                                                  child: Icon(
                                                    Icons.list_alt,
                                                    color: (ViewIndex == 1)
                                                        ? Colors.white
                                                        : Color(0xFF1046A8),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      if (ViewIndex == 0) MapDisplay(),
                                      if (ViewIndex == 1) ListDisplay()
                                    ],
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
