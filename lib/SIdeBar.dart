import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginScreen.dart';
import 'Provider.dart';
class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Future<void> _signOut() async {
    print("logout");
    try {
      await FirebaseAuth.instance.signOut();
      print(FirebaseAuth.instance.authStateChanges());
      Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    final currentPageIndex = sidebarProvider.currentPageIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF242B5C), // Dark blue background color
                Colors.black, // Black color for gradient
              ],
            ),
            border: Border(
              right: BorderSide(
                color: Colors.blue, // Border color
                width: 2.0,          // Border width
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: 100,),
                    SizedBox(
                        height:60,
                        width: 60,
                        child: Image.asset('assets/image2.png')
                    ),
                    Text("CHARGE PARTNERS",style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    sidebarProvider.navigateToPage(0);
                    Navigator.pushReplacementNamed(context, '/Dashboard');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: currentPageIndex == 0 ? Colors.black26:null,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Icon(Icons.bar_chart,color: Colors.blue,),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text("Dashboard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  decoration: BoxDecoration(
                      color: currentPageIndex == 1 ? Colors.black26: null
                  ),
                  child: GestureDetector(
                    onTap: (){
                      sidebarProvider.navigateToPage(1);
                      //Navigator.pushReplacementNamed(context, '/Dashboard');
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                            child: Icon(Icons.credit_card,color: Colors.blue,),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text("Business KPI",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.alarm,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Alarm Summary",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.earbuds_battery,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Charging Network",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.web_asset,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Asset Management",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.groups,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("CRM",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.speaker_phone,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("RFID Management",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.supervised_user_circle_outlined,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Accounts",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.mail_outline,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Tariff Management",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.support_agent,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("CPO Support",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.notifications,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Notifications",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.add_chart_rounded,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Reports",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.settings,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Settings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Icon(Icons.help,color: Colors.blue,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("Help",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                ),
                GestureDetector(onTap: (){
                  print("tapped");
                  _signOut();
                },
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF189C8A), // Set the background color
                      borderRadius: BorderRadius.circular(5.0), // Add rounded corners
                    ),
                    child:Center(
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14// Set text color
                            ),
                          ),
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 18,// Set icon color
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
      ),
    );
  }
}
