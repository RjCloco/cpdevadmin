import 'package:cpdevadmin/LoginScreen.dart';
import 'package:flutter/material.dart';
class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/graphic_slide.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0, left: 18.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Devs!",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                            filled: true,
                            fillColor: Color(0xFFDEE3E7),
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail, color: Colors.white),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundImage: AssetImage('assets/avatar.png'),
                              backgroundColor: Colors.transparent,
                              child: GestureDetector(
                                onTap: () {},
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$AdminName",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("$AdminEmail"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "We are on a mission to help you plugin for a better tomorrow",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Home ", style: TextStyle(color: Colors.grey)),
                  Text("/ Dashboard", style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 5,),
              Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );

  }
}
