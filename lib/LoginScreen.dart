import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpdevadmin/responsive_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  bool visibility = true;
  final _emailKey = GlobalKey<FormState>();
  final _pwdKey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$");
  RegExp email_valid = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  bool validateEmail(String email) {
    return email_valid.hasMatch(email);
  }
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
  String errmsg = '';
 // FirebaseFirestore firestore = FirebaseFirestore.instance;
 //  List<Map<String, dynamic>> adminDataList = [];
  CollectionReference ref = FirebaseFirestore.instance.collection('Admin');
  String AdminEmail = '';
  String ResetEmail ='';
  String AdminPassword = '';
  late final userDoc;
  late final userData;

  Future<void> fetchAdminData() async {
    try {
      QuerySnapshot adminSnapshot = await ref.where('DeleteStatus', isEqualTo: false).get();
      userDoc = adminSnapshot.docs.first;
      userData = userDoc.data();
      List<Map<String, dynamic>> admins = [];
      adminSnapshot.docs.forEach((doc) {
        Map<String, dynamic> adminData = doc.data() as Map<String, dynamic>;
        admins.add(adminData);
      });
      setState(() {
        admins.forEach((admin) {
          String email = admin['Email'] ?? ''; // Replace 'email' with the actual field name
          // String password = admin['Password'] ?? ''; // Replace 'password' with the actual field name
          AdminEmail = email;
          // AdminPassword = password;
          // print(AdminEmail);
          // print(AdminPassword);
        });
      });
    }
    catch (error) {
      print("Error fetching admin data: $error");//testing
    }
  }

  Future<void> AdminSignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: pwd.text,
      ).then((_){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      });
      print("Login Success");
      ref
          .doc(userData['Email'])
          .update({'LoginTime': FieldValue.serverTimestamp()})
          .then((value) => print("User updated"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        errmsg = e.message!;
      });
      print(e);
    }
  }

  void _showResetEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        GlobalKey<FormState>  Form_key =  GlobalKey<FormState>();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Center(child: Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold),)),
          content: Container(
            height: 120,
            child: Form(
              key: Form_key,
              child: Column(
                children: [
                  Text("Enter Your Registered email ID to reset password"),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Enter Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        ResetEmail = value;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (Form_key.currentState!.validate()) {
                            Navigator.of(context).pop(); // Close the dialog
                            ForgotPassword();
                          }
                        },
                        child: Text('Reset'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void ForgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: AdminEmail);
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
      print("error: forgot pwd: $e");
    }
  }


  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Reset Email Sent'),
          content: Text('A password reset email has been sent to $AdminEmail.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    print("Login Page");
    fetchAdminData();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Expanded(
              child: Container(
                foregroundDecoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/image3.png'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : height * 0.12),
                color: AppColors.backColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 50.0,top: 60.0): ResponsiveWidget.isSmallScreen(context)?EdgeInsets.only(left: 170.0,top: 60.0):EdgeInsets.only(left: 250.0,top: 60.0),
                      child: Container(
                          height: 100,
                          width: 100,
                          foregroundDecoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/image2.png'),
                                  fit: BoxFit.cover)
                          ),
                          child: SizedBox(height: height * 0.014)
                      ),
                    ),
                    Padding(
                      padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 50.0,top: 60.0): ResponsiveWidget.isSmallScreen(context)?EdgeInsets.only(left: 120.0,top: 10.0):EdgeInsets.only(left: 190.0,top: 30.0),
                      //padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 15.0,top: 60.0): const EdgeInsets.only(left: 185.0),
                      child: Text("CHARGE PARTNERS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                      //child: Image.asset('assets/image2.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: SizedBox(

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Email',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w700,
                        ),

                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Form(
                      key: _emailKey,
                      child: Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          controller: email,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          validator: (email)  {
                            if(!validateEmail(email!)){
                              return 'Enter a valid Email';
                            }

                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top:7.0,left: 20.0),
                            hintText: 'Enter Email',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.014),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text('Password',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    ),
                    const SizedBox(height: 6.0),
                    Form(
                      key: _pwdKey,
                      child: Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          controller: pwd,
                          obscureText: visibility,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter password";
                            }
                          },

                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 16.0,left: 20.0),
                              hintText: 'Enter Password',

                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  visibility=!visibility;
                                });
                              }, icon: Icon(visibility==true?Icons.remove_red_eye:Icons.visibility_off))
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){
                          _showResetEmailDialog();
                        },
                        child: Text('Forgot Password?',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.mainBlueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),
                    if (errmsg.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errmsg,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Padding(
                      padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.only(left:50.0):EdgeInsets.only(left:200.0),
                      //padding: const EdgeInsets.only(left:200.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print(_pwdKey.currentState!.validate());
                          if (_emailKey.currentState!.validate() && _pwdKey.currentState!.validate()) {
                            AdminSignIn();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.mainBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0):ResponsiveWidget.isSmallScreen(context)?EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0):EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                         // padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0):EdgeInsets.symmetric(horizontal: 70.0, vertical: 18.0),
                          child: Text(
                            'Login',
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.whiteColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            )],

        ),
      ),
    );
  }
}

