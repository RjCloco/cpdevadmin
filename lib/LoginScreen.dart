import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  String errmsg = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> adminDataList = [];
  CollectionReference ref = FirebaseFirestore.instance.collection('Admin');
  String AdminEmail = '';
  String ResetEmail ='';
  String AdminPassword = '';
  late final userDoc;
  late final userData;

  Future<void> fetchAdminData() async {
    try {
      QuerySnapshot adminSnapshot =
          await ref.where('DeleteStatus', isEqualTo: false).get();
      userDoc = adminSnapshot.docs.first;
      userData = userDoc.data();
      List<Map<String, dynamic>> admins = [];
      adminSnapshot.docs.forEach((doc) {
        Map<String, dynamic> adminData = doc.data() as Map<String, dynamic>;
        admins.add(adminData);
      });
      setState(() {
        admins.forEach((admin) {
          String email = admin['Email'] ??
              ''; // Replace 'email' with the actual field name
          String password = admin['Password'] ??
              ''; // Replace 'password' with the actual field name
          AdminEmail = email;
          AdminPassword = password;
          print(AdminEmail);
          print(AdminPassword);
        });
      });
    } catch (error) {
      print("Error fetching admin data: $error");
    }
  }

  Future<void> AdminSignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: pwd.text.trim(),
      );
      print("Login Success");
      ref
          .doc(userData['Email'])
          .update({'LoginTime': FieldValue.serverTimestamp()})
          .then((value) => print("User updated"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
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
          title: Text('Reset Password'),
          content: Form(
            key: Form_key,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
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
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (Form_key.currentState!.validate()) {
                  Navigator.of(context).pop(); // Close the dialog
                  ForgotPassword();
                }
              },
              child: Text('Reset'),
            ),
          ],
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
    fetchAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charge Partners Admin Panel"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email is Must";
                }
              },
            ),
            TextFormField(
              controller: pwd,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Password";
                }
              },
            ),
            InkWell(onTap: _showResetEmailDialog, child: Text("Forgot Password?")),
            SizedBox(
              height: 10,
            ),
            if (errmsg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errmsg,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("form validated ");
                    AdminSignIn();
                  }
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
