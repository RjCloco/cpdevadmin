import 'package:flutter/material.dart';

import 'AppBar.dart';
import 'CRM_List.dart';
import 'SIdeBar.dart';
import 'CRM_grid.dart';
class CRM extends StatefulWidget {
  const CRM({super.key});

  @override
  State<CRM> createState() => _CRMState();
}

class _CRMState extends State<CRM> {
  int index = 0;
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
                        child:Column(
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
                                            'Customer',
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
                                            'Group',
                                            style: TextStyle(color: (index==1)?Colors.white:Color(0xFF1046A8,)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: 15.0), // Add spacing between "Customer" and "Group"
                                //SizedBox(width: 850.0),// Spacer to push the button to the rightmost corner
                                Container(
                                  width: 100.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1046A8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add your +Add button functionality here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF1046A8) ,// White color for the button background
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7.0),
                                      ),
                                    ),
                                    child: Text(
                                      '+Add',
                                      style: TextStyle(color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ],

                            ),
                            if (index == 0) CRMList(),
                             if (index == 1)...[
                               Container(
                                 height: 400,
                                 width: 800,
                                 child: CRMGrid(),
                               )
                             ],
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),

          )
        ],
      ),
    );;
  }
}
