import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class ListDisplay extends StatefulWidget {
  const ListDisplay({super.key});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  TextEditingController ListSearch = new TextEditingController();
  void handleClick(int item) {
    final sidebarProvider = Provider.of<SidebarProvider>(context,listen: false);
    switch (item) {
      case 0:
        {

          sidebarProvider.navigateToPage(4);
          Navigator.pushNamed(context, '/AssetManagement');
          break;
        }
      case 1:
        {

          break;
        }
      case 2:
        {

          break;
        }
    }
  }

   Color ChooseColor(String status){
    if(status=='Completed'){
      return Colors.green;
    }
    else if(status=='On going'){
      return Colors.orange;
    }
    else if(status =='At risk'){
      return Colors.red;
    }
    else if(status == 'Unknown'){
      return Colors.grey;
    }
    else{
      return Colors.yellow;
    }


  }
  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Charge Stations",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: ListSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search location..',
                  filled: true, // Add a background color to the TextField
                  fillColor: Color(
                      0xFFDEE3E7), // Set the background color of the TextField
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        DataTable(
        columnSpacing: 80.24,
          columns: [
            DataColumn(label: Text('CHARGE STATIONS',style: TextStyle(fontWeight: FontWeight.bold),),),
            DataColumn(label: Text('SLOT BOOKED',style: TextStyle(fontWeight: FontWeight.bold)),),
            DataColumn(label: Text('ADDRESS',style: TextStyle(fontWeight: FontWeight.bold)),),
            DataColumn(label: Text('STATUS',style: TextStyle(fontWeight: FontWeight.bold)),),
            DataColumn(label: Text('ACTIONS',style: TextStyle(fontWeight: FontWeight.bold)),),

          ],
          rows: sidebarProvider.stationData.map<DataRow>((data) {
            return DataRow(cells: [
              DataCell(Text(data['StationName'] ?? 'N/A')),
              DataCell(Text(data['Description'].toString())),
              DataCell(Text(data['Address'].toString())),
              DataCell(
                  Container(
                    decoration:BoxDecoration(
                      color:ChooseColor(data['Status']),
                      borderRadius: BorderRadius.circular(10)
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data['Status'],style: TextStyle(fontWeight: FontWeight.bold),),
                      )
                  )
              ),
              DataCell(
                PopupMenuButton<int>(
                  onSelected: (item) => handleClick(item),
                  itemBuilder: (context) => [
                    // PopupMenuItem<int>(value: 0, child: Text('Profile')),
                    PopupMenuItem<int>(value: 0, child: Text('View')),
                    // PopupMenuItem<int>(value: 2, child: Text('Delete Account')),
                  ],
                ),
              ),
              // Add more cells for other columns
            ]);
          }).toList(),
        ),
      ],
    );
  }
}
