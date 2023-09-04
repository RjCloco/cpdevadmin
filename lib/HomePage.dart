import 'package:cpdevadmin/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: Column(
      //   children: [
      //     Text("Home Page"),
      //     ElevatedButton(onPressed: () async {
      //       await _signOut();
      //     }, child: Text("LOG OUT"))
      //   ],
      // ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                 color: Color(0xFF242B5C)
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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF)
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                        child: SizedBox(
                          height: 150,
                            width: w,
                            child: Image.asset('assets/graphic_slide.jpeg')),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
