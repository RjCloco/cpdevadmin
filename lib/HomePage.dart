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
    return Scaffold(
      body: Column(
        children: [
          Text("Home Page"),
          ElevatedButton(onPressed: () async {
            await _signOut();
          }, child: Text("LOG OUT"))
        ],
      ),
    );
  }
}
