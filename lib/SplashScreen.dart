import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  set_initial_login_state() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('LoginStatus', 'false');
  }

  @override
  void initState(){
    super.initState();
    set_initial_login_state();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushNamed(context, '/Login');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Splash Screen"),
    );
  }
}
