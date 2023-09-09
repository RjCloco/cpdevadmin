import 'package:flutter/material.dart';

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
                         // Initial Value
                         // value: dropdownvalue,
                         // Down Arrow Icon
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
                         },
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

