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


class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String selectedCountryCode = "+1"; // Default country code
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Group",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Group Name',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Contact Person Name',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          IntlPhoneField(
                            onChanged: (phone) {
                              // completeNum = phone.completeNumber;
                            },
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              hintText: 'Enter Phone Number',
                              labelText: 'Phone Number',
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            initialCountryCode: 'IN',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Contact Person E-Mail',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Billing Invoice Type',
                              border:
                              OutlineInputBorder(), // Remove the default border
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
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GST IN'),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter GSTIN',
                                  border: OutlineInputBorder(), // Remove the default border
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'PAN Number',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter full address',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Field 9',
                              border:
                              OutlineInputBorder(), // Remove the default border
                            ),
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
          ],
        ),
      ),
    );
  }
}

