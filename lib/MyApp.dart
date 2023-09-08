import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Accounts.dart';
import 'AlarmSummary.dart';
import 'AssetManagement.dart';
import 'BusinessKPI.dart';
import 'CPOSupport.dart';
import 'CRM.dart';
import 'ChargingNetwork.dart';
import 'Help.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';
import 'Notifications.dart';
import 'Provider.dart';
import 'RFIDManagement.dart';
import 'Reports.dart';
import 'Settings.dart';
import 'TariffManagement.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SidebarProvider())
      ],
      child: MaterialApp(
        title: 'Charge Partners Admin Panel',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/Login': (context) => LoginScreen(),
          '/Dashboard': (context)=>HomePage(),
          '/BusinessKPI': (context)=>BusinessKPI(),
          '/AlarmSummary': (context)=>AlarmSummary(),
          '/ChargingNetwork': (context)=>ChargingNetwork(),
          '/AssetManagement': (context)=>AssetManagement(),
          '/CRM': (context)=>CRM(),
          '/RFIDManagement': (context)=>RFIDManagement(),
          '/Accounts': (context)=>Accounts(),
          '/TariffManagement': (context)=>TariffManagement(),
          '/CPOSupport': (context)=>CPOSupport(),
          '/Notifications': (context)=>Notifications(),
          '/Reports': (context)=>Reports(),
          '/Settings': (context)=>Settings(),
          '/Help': (context)=>Help(),
        },
      ),
    );
  }
}