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
     'Group Name': 'Sameer globals tech solutions',
     'Admin User': 'Sameer',
     'Admin Email': 'Sameer@gmail.com'
   },
   {
     'Group Name': 'Akshu globals tech solutions',
     'Admin User': 'Akshu',
     'Admin Email': 'Akshu@gmail.com'
   },
   {
     'Group Name': 'Thiyanesh globals tech solutions',
     'Admin User': 'Thiyanesh',
     'Admin Email': 'Thiyanesh@gmail.com'
   }
 ];
  @override
  Widget build(BuildContext context) {
   return GridView.builder(
     itemCount: items.length,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
     crossAxisCount: 3, // number of items in each row
     mainAxisSpacing: 8.0, // spacing between rows
     crossAxisSpacing: 8.0, // spacing between columns
      ),
       itemBuilder: (context,index){
         final item = items[index];
         return Container(
           height: 100,
           width: 100,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10)
           ), // color of grid items
           child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text(
               'Group Name: ${item['Group Name']}',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
               ),
             ),
             Text(
               'Admin User: ${item['Admin User']}',
               style: TextStyle(
               ),
             ),
             Text(
               'Admin Email: ${item['Admin Email']}',
               style: TextStyle(
               ),
             ),
           ],
         ),
         );
   });
  }
}

