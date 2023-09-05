import 'package:cpdevadmin/LoginScreen.dart';
import 'package:cpdevadmin/Map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SIdeBar.dart';

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
            child: SideBar(),
          ),
          Expanded(
            flex: 5,
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
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        child: Container(
                          height: 200,
                          width: 1200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/graphic_slide.jpeg"),
                              fit: BoxFit.fill
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hello Devs!",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          width: 200,
                                          child: TextFormField(
                                            // controller: _searchController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Search location..',
                                              filled: true, // Add a background color to the TextField
                                              fillColor:  Color(0xFFDEE3E7), // Set the background color of the TextField
                                              prefixIcon: IconButton(
                                                onPressed: (){},
                                                icon: Icon(Icons.search),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.settings,color: Colors.white,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.notifications,color: Colors.white,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.mail,color: Colors.white,),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                                Text("We are on a mission to help like you beautiful projects for free",style: TextStyle(fontSize: 13,color: Colors.white,),),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Text("Home ",style: TextStyle(color: Colors.grey),),
                                    Text("/ Dashboard",style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text("Dashboard",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      left: 20,
                      child: Container(
                        width: 1160, // Set the width as needed
                        height: 550, // Set the height as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0,right: 18.0,left: 18.0,bottom: 18.0),
                          child: MapDisplay(),
                          // child: Text(""),
                        ),
                      ),
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
