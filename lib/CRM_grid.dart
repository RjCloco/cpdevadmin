import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CRMGrid extends StatefulWidget {
  const CRMGrid({super.key});

  @override
  State<CRMGrid> createState() => _CRMGridState();
}

class _CRMGridState extends State<CRMGrid> {

 List<Map<String,dynamic>> items =[
   {
   'Group Name': 'Swe globals tech solutions',
   'Admin User': 'Swetha',
   'Admin Email': 'Swetha@gmail.com'
 },
   {
     'Group Name': 'Sam globals tech solutions',
     'Admin User': 'Sameer',
     'Admin Email': 'Sameer@gmail.com'
   },
   {
     'Group Name': 'Ak globals tech solutions',
     'Admin User': 'Akshu',
     'Admin Email': 'Akshu@gmail.com'
   },
   {
     'Group Name': 'Thiya globals tech solutions',
     'Admin User': 'Thiyanesh',
     'Admin Email': 'Thiyanesh@gmail.com'
   }
 ];
 String dropdownvalue = 'View';
 var dropdown = [
   'View',
   'Edit',
 ];

 void onDropdownItemSelected(String selectedItem) {
   // Perform the desired action here, e.g., navigate to a new screen
  if(selectedItem =='View'){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Edit(),
      ),
    );
  }
  else{
    print("Edit");

  }
 }

 @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(top:38.0),
     child: Container(
       height: items.length*110,
       child: GridView.builder(
         itemCount: items.length,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // number of items in each row
             mainAxisSpacing: 18.0, // spacing between rows
              crossAxisSpacing: 18.0, // spacing between columns
             childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.2),
          ),
           itemBuilder: (context,index){
             final item = items[index];
             return Container(
               width: 10,
               height: 80,
               decoration: BoxDecoration(
                   border: Border(
                       top: BorderSide(
                           color:Color(0xFF1046A8), width: 2
                       ),
                       bottom: BorderSide(
                           color: Color(0xFF1046A8), width: 5
                       ),

                       left: BorderSide(
                           color: Color(0xFF1046A8), width: 2
                       ),
                       right: BorderSide(
                           color: Color(0xFF1046A8), width: 2
                       )
                   ),
                 borderRadius: BorderRadius.circular(20)
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8.0),
                 child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Group Name: ${item['Group Name']}',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       DropdownButton(
                         icon: const Icon(Icons.more_vert_sharp),
                         // Array list of items
                         items: dropdown.map((String items) {
                           return DropdownMenuItem(
                             value: items,
                             child: Text(items),
                           );
                         }).toList(),
                         // After selecting the desired option,it will
                         // change button value to selected value
                         onChanged: (String? newValue) {
                           setState(() {
                             dropdownvalue = newValue!;
                           });
                         }, //onDropdownItemSelected(dropdownvalue);
                       ),
                       // PopupMenuButton(
                       //   child: Container(
                       //     margin: const EdgeInsets.all(10),
                       //     child: const Text(
                       //       'Main menu',
                       //       style: TextStyle(
                       //         fontSize: 16,
                       //         color: Colors.white,
                       //         decoration: TextDecoration.underline,
                       //       ),
                       //     ),
                       //   ),
                       //   itemBuilder: (context) => [
                       //     PopupMenuItem(
                       //       child: const Text('Child one'),
                       //       value: 1,
                       //       onTap: () {},
                       //     ),
                       //     PopupMenuItem(
                       //       child: const Text('Child two'),
                       //       value: 1,
                       //       onTap: () {},
                       //     ),
                       //   ],
                       // )
                       // GestureDetector(
                       //   onTap: (){
                       //
                       //   },
                       //     child: Icon(Icons.more_vert_sharp,size: 20,))
                     ],
                   ),
                   Divider(thickness: 1,color: Colors.black,indent: 7,endIndent: 10,),
                   Text(
                     'Admin User: ${item['Admin User']}',
                     style: TextStyle(
                     ),
                   ),
                   Divider(thickness: 1,color: Colors.black,indent: 7,endIndent: 10,),
                   Text(
                     'Admin Email: ${item['Admin Email']}',
                     style: TextStyle(
                     ),
                   ),
                 ],
                 ),
               ),
             );
       }
       ),
     ),
   );
  }
}

//
// class Edit extends StatefulWidget {
//   @override
//   _EditState createState() => _EditState();
// }
//
// class _EditState extends State<Edit> {
//   String selectedCountryCode = "+1"; // Default country code
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Add New Group",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Divider(
//               color: Colors.black, // Set the color of the line
//               thickness: 0.3, // Set the thickness of the line
//               height: 20, // Set the height of the line (space below text)
//             ),
//             Form(
//               key: formKey,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding:
//                       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       margin: EdgeInsets.only(right: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black, // Set the border color
//                           width: 1.0, // Set the border width
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Group Name',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Contact Person Name',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           IntlPhoneField(
//                             onChanged: (phone) {
//                               // completeNum = phone.completeNumber;
//                             },
//                             decoration: InputDecoration(
//                               enabledBorder: InputBorder.none,
//                               hintText: 'Enter Phone Number',
//                               labelText: 'Phone Number',
//                               hintStyle: TextStyle(fontSize: 15),
//                               labelStyle: TextStyle(fontSize: 14),
//                             ),
//                             initialCountryCode: 'IN',
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Contact Person E-Mail',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Billing Invoice Type',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding:
//                       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       margin: EdgeInsets.only(left: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black, // Set the border color
//                           width: 1.0, // Set the border width
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Column(crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('GST IN'),
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter GSTIN',
//                                   border: OutlineInputBorder(), // Remove the default border
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'PAN Number',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Enter full address',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Field 9',
//                               border:
//                               OutlineInputBorder(), // Remove the default border
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String selectedCountryCode = "+1"; // Default country code
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? selectedValue; // Nullable String for selected value

  List<String> dropdownItems = [
    'Invoice 1',
    'Invoice 2',
    'Invoice 3',
    'Invoice 4',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Group",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black, // Set the color of the line
                  thickness: 0.3, // Set the thickness of the line
                  height: 20, // Set the height of the line (space below text)
                ),
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Color(0xFF1046A8),
                              ),
                              left: BorderSide(
                                width: 1.0,
                                color: Color(0xFF1046A8),
                              ),
                              right: BorderSide(
                                width: 2.0,
                                color: Color(0xFF1046A8),
                              ),
                              bottom: BorderSide(
                                width: 4.0,
                                color: Color(0xFF1046A8),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Group Name *',style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left,),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Group Name',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Contact Person Name *'),
                                ],
                              ), SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Contact Person Name',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Mobile Number *'),
                              IntlPhoneField(
                                onChanged: (phone) {
                                  // completeNum = phone.completeNumber;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter a Mobile Number',
                                  hintStyle: TextStyle(fontSize: 15),
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                                initialCountryCode: 'IN',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Contact Person Email *'),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Contact Person E-Mail',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Billing Invoice Type *"),
                              SizedBox(height: 10,),
                              DropdownButtonFormField<String>(
                                value: selectedValue, // Initial selected value (can be null)
                                items: dropdownItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue; // Update selected value
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Select an option',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Color(0xFF1046A8),
                              ),
                              left: BorderSide(
                                width: 1.0,
                                color: Color(0xFF1046A8),
                              ),
                              right: BorderSide(
                                width: 2.0,
                                color: Color(0xFF1046A8),
                              ),
                              bottom: BorderSide(
                                width: 4.0,
                                color: Color(0xFF1046A8),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Add Business Entity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('GST IN *'),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter GSTIN',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('PAN Number *'),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'PAN Number',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Address *'),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Full address',
                                  contentPadding: EdgeInsets.symmetric(vertical: 80.0),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 3.0,),
                                  ),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic for the first button
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1046A8),// Set the button's background color
                        onPrimary: Colors.white, // Set the text color
                        shape:StadiumBorder(),
                        // Set the border width
                        fixedSize: Size(150, 50),//// Set the border radius
                      ),
                      child: Text('Save'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic for the second button
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Color(0xFF1046A8),
                        shape:StadiumBorder(),
                        side: BorderSide(
                          color:Color(0xFF1046A8), // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        fixedSize: Size(150, 50),//// Set the border radius
                      ),
                      child: Text('Cancel'),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewTable extends StatefulWidget {
  const ViewTable({Key? key}) : super(key: key);

  @override
  _ViewTableState createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Iconic Innovation",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 550,
                      // Set the width of the first container
                      height: 450,
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Color(0xFF1046A8),
                          ),
                          left: BorderSide(
                            width: 1.0,
                            color: Color(0xFF1046A8),
                          ),
                          right: BorderSide(
                            width: 2.0,
                            color: Color(0xFF1046A8),
                          ),
                          bottom: BorderSide(
                            width: 4.0,
                            color: Color(0xFF1046A8),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Group Information'),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 500,
                                // Set the width of the outer container
                                height: 40,
                                color: Color(0xFFEAEAEA),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Contact Person Name',
                                      textAlign: TextAlign.start,
                                    ),
                                    Text('SAS THE MASS'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Contact Person Number'),
                              Text('+91 1122334488'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500, // Set the width of the outer container
                            height: 40,
                            color: Color(0xFFEAEAEA),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contact Email',
                                  textAlign: TextAlign.start,
                                ),
                                Text('sas@gmail.com'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Comissioned on'),
                              Text('April 7, 2023'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500, // Set the width of the outer container
                            height: 40,
                            color: Color(0xFFEAEAEA),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Billing invoice type',
                                  textAlign: TextAlign.start,
                                ),
                                Text('postpaid'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Users'),
                              Text('217'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500, // Set the width of the outer container
                            height: 40,
                            color: Color(0xFFEAEAEA),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'RFID',
                                  textAlign: TextAlign.start,
                                ),
                                Text('0'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Add your button logic here
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                    Color(0xFF1046A8),
                                  ), // Replace with your desired color
                                ),
                                icon: Icon(Icons.person_add_sharp),
                                // Replace with your desired icon
                                label: Text(
                                    'Add User'), // Replace with your desired label text
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Add your button logic here
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                    Color(0xFF1046A8),
                                  ), // Replace with your desired color
                                ),
                                icon: Icon(Icons.person_pin_circle_sharp),
                                // Replace with your desired icon
                                label: Text(
                                    'Bulk User Import'), // Replace with your desired label text
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Add your button logic here
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                    Color(0xFF1046A8),
                                  ), // Replace with your desired color
                                ),
                                icon: Icon(Icons.person_remove_alt_1_outlined),
                                // Replace with your desired icon
                                label: Text(
                                    'Remove User'), // Replace with your desired label text
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 450,
                      // Set the width of the second container
                      height: 450,
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Color(0xFF1046A8),
                          ),
                          left: BorderSide(
                            width: 1.0,
                            color: Color(0xFF1046A8),
                          ),
                          right: BorderSide(
                            width: 2.0,
                            color: Color(0xFF1046A8),
                          ),
                          bottom: BorderSide(
                            width: 4.0,
                            color: Color(0xFF1046A8),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Group Information'),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 400,
                                // Set the width of the outer container
                                height: 40,
                                color: Color(0xFFEAEAEA),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'GSTIN',
                                      textAlign: TextAlign.start,
                                    ),
                                    Text('UGEIFVJ VFDF'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('PAN'),
                                  Text(' 7GJDIUGDCKF'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 400,
                                // Set the width of the outer container
                                height: 40,
                                color: Color(0xFFEAEAEA),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Address',
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(' 52 Cherry Grove, '
                                        'Tasmania australia'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('User Balance'),
                                  Text('April 7, 2023'),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 100,
                                child: MaterialButton(
                                  onPressed: () {
                                    // Add your button logic here
                                  },
                                  color: Color(
                                      0xFF1046A8), // Replace with your desired button color
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.white, // Specify the icon color
                                      ),
                                      SizedBox(
                                          width:
                                          2), // Add some spacing between the icon and text
                                      Text(
                                        'TopUp',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ), // Replace with your desired label text and style
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 1050,
                  // Set the width of the first container
                  height: 450,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Color(0xFF1046A8),
                      ),
                      left: BorderSide(
                        width: 1.0,
                        color: Color(0xFF1046A8),
                      ),
                      right: BorderSide(
                        width: 2.0,
                        color: Color(0xFF1046A8),
                      ),
                      bottom: BorderSide(
                        width: 4.0,
                        color: Color(0xFF1046A8),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Adjust alignment as needed
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            color: Color(0xFF1046A8),
                            child: Text('Charging Transaction',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            color: Color(0xFF1046A8),
                            child: Text('Account Transaction',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            color: Color(0xFF1046A8),
                            child: Text('User',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            color: Color(0xFF1046A8),
                            child: Text('Invite User',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            color: Color(0xFF1046A8),
                            child: Text('RFID',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Add spacing between buttons and search bar
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                // Handle search input
                              },
                            ),
                          ),
                        ],
                      ),

                    ],
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
