import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AssetManagement.dart';
import 'CRM.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';
import 'Provider.dart';

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
          '/AssetManagement': (context)=>AssetManagement(),
          '/CRM': (context)=>CRM()
        },
      ),
    );
  }
}