import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpdevadmin/responsive_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'app_colors.dart';
import 'app_styles.dart';
String AdminEmail = '';
String AdminName='';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController Forgotpwd = new TextEditingController();
  bool visibility = true;
  final _formKey = GlobalKey<FormState>();

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
          AdminName =admin['Name'] ;
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
        Navigator.pushReplacementNamed(context, '/Dashboard');
         // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
          title: Center(child: Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
          content: Container(
            height: 150,
            child: Form(
              key: Form_key,
              child: Column(
                children: [
                  Text("Enter Your Registered email ID to reset password",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: Forgotpwd,
                    decoration: InputDecoration(
                        labelText: 'Enter Email',
                      border: OutlineInputBorder(),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      else if(!validateEmail(Forgotpwd.text)){
                        return "Invalid Email Format";
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
                      Padding(
                        padding: const EdgeInsets.only(left: 26.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (Form_key.currentState!.validate()) {
                              Navigator.of(context).pop(); // Close the dialog
                              ForgotPassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.mainBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 26.0,right: 26.0,top:5.0,bottom: 5.0),
                            child: Text('Reset'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 26.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            primary:AppColors.mainBlueColor,
                            side: const BorderSide(
                              width: 1.0,
                              color: AppColors.mainBlueColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            // Customize other styling properties here
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 26.0,right: 26.0,top:5.0,bottom: 5.0),
                            child: Text('Cancel',style: TextStyle(color: AppColors.mainBlueColor),),
                          ),
                        ),
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
      if (validateEmail(ResetEmail)) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: ResetEmail);
        _showSuccessDialog();
      } else {
        throw "Invalid email format";
      }
    } catch (e) {
      String errorMessage = "An error occurred while resetting the password";
      if (e is String) {
        errorMessage = e;
      }
      _showErrorDialog(errorMessage);
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

  void _showErrorDialog(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/error.jpeg', // Replace with the path to your cross image asset
                width: 48.0, // Adjust the width as needed
                height: 48.0, // Adjust the height as needed
              ),
              SizedBox(height: 20.0),
              Text(
                'Entered "${Forgotpwd.text}" ID is invalid',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
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
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Container(
              width: width/1.6,
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/image3.png'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Expanded(
              child: Container(
                width: width*1.2,
                height: height,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : ResponsiveWidget.isMediumScreen(context)?height * 0.032:height * 0.12),
                color: AppColors.backColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 85.0,top: 60.0): ResponsiveWidget.isSmallScreen(context)?EdgeInsets.only(left: 170.0,top: 60.0):EdgeInsets.only(left: 150.0,top: 60.0),
                      child: Container(
                          height: 100,
                          width: 100,
                          foregroundDecoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/image2.png'),
                                  fit: BoxFit.cover)
                          ),
                          child: SizedBox(height: width * 0.014)
                      ),
                    ),
                    Padding(
                      padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 55.0,top: 60.0): ResponsiveWidget.isSmallScreen(context)?EdgeInsets.only(left: 120.0,top: 10.0):EdgeInsets.only(left: 90.0,top: 30.0),
                      //padding: ResponsiveWidget.isMediumScreen(context) ?EdgeInsets.only(left: 15.0,top: 60.0): const EdgeInsets.only(left: 185.0),
                      child: Text("CHARGE PARTNERS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveWidget.isMediumScreen(context)?20.0:25.0),),
                      //child: Image.asset('assets/image2.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: SizedBox(
                      ),
                    ),
                    Form(
                      key: _formKey, // Use a single GlobalKey for the form
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          SizedBox(height: 6.0),
                          TextFormField(
                            controller: email,
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor,
                              fontSize: 12.0,
                            ),
                            validator: (email) {
                              if (!validateEmail(email!)) {
                                return 'Enter a valid Email';
                              }
                            },
                            decoration: InputDecoration(
                              filled: true, //<-- SEE HERE
                              fillColor: Color(0xFFDEE3E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(top: 7.0, left: 20.0),
                              hintText: 'Enter your Email here',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.014),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Password',
                              style: ralewayStyle.copyWith(
                                fontSize: 12.0,
                                color: AppColors.blueDarkColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.0),
                          TextFormField(
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor,
                              fontSize: 12.0,
                            ),
                            controller: pwd,
                            obscureText: visibility,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              }
                            },
                            decoration: InputDecoration(
                              filled: true, //<-- SEE HERE
                              fillColor:  Color(0xFFDEE3E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(top: 16.0, left: 20.0),
                              hintText: 'Enter your Password here',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                                icon: Icon(
                                  visibility == true ? Icons.remove_red_eye : Icons.visibility_off,color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            color: Colors.black,
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
                      padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.only(left:85.0):ResponsiveWidget.isSmallScreen(context)?EdgeInsets.only(left:160.0):EdgeInsets.only(left:130.0),
                      //padding: const EdgeInsets.only(left:200.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AdminSignIn();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1046A8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0):ResponsiveWidget.isSmallScreen(context)?EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0):EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                         // padding: ResponsiveWidget.isMediumScreen(context)?EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0):EdgeInsets.symmetric(horizontal: 70.0, vertical: 18.0),
                          child: Text(
                            'Login',
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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

