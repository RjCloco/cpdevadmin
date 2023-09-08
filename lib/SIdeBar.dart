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
                Color(0xFF090D2E), // Dark blue background color
                Color(0xFF080B1E) // Black color for gradient
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
                NavigationMenuItem(route: '/Dashboard', text: 'Dashboard', icon: Icons.bar_chart, index: 0,),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 1, route: '/BusinessKPI', text: "Business KPI", icon: Icons.credit_card),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 2, route: '/AlarmSummary', text: "Alarm Summary", icon: Icons.alarm),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 3, route: '/ChargingNetwork', text: "Charging Network", icon: Icons.earbuds_battery),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 4, route: '/AssetManagement', text: "Asset Management", icon: Icons.web_asset),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 5, route: '/CRM', text: "CRM", icon: Icons.groups),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 6, route: '/RFIDManagement', text: "RFID Management", icon: Icons.speaker_phone),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 7, route: '/Accounts', text: "Accounts", icon: Icons.supervised_user_circle_outlined),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 8, route: '/TariffManagement', text: "Tariff Management", icon: Icons.mail_outline),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 9, route: '/CPOSupport', text: "CPO Support", icon: Icons.support_agent),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 10, route: '/Notifications', text: "Notifications", icon: Icons.notifications),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 11, route: '/Reports', text: "Reports", icon: Icons.add_chart_rounded),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 12, route: '/Settings', text: "Settings", icon: Icons.settings),
                SizedBox(height: 25,),
                NavigationMenuItem(index: 13, route: '/Help', text: "Help", icon: Icons.help),
                SizedBox(height: 25,),
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
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14// Set text color
                              ),
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

class NavigationMenuItem extends StatelessWidget {
  final String route;
  final int index;
  final String text;
  final IconData icon;

  NavigationMenuItem({
    required this.index,
    required this.route,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    final currentPageIndex = sidebarProvider.currentPageIndex;
    return GestureDetector(
      onTap: () {
        sidebarProvider.navigateToPage(index);
        Navigator.pushReplacementNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: currentPageIndex == index ? Color(0x7E3475A2) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Icon(icon, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
