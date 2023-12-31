import 'package:flutter/material.dart';

import 'AppBar.dart';
import 'SIdeBar.dart';
class AssetManagement extends StatefulWidget {
  const AssetManagement({super.key});

  @override
  State<AssetManagement> createState() => _AssetManagementState();
}

class _AssetManagementState extends State<AssetManagement> {
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
                           Text("Asset Management")
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
