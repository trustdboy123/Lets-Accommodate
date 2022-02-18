
import 'package:flutter/material.dart';

class AddDetailsView extends StatefulWidget {
   AddDetailsView({ Key? key }) : super(key: key);

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {
String dropdownValue = 'Single Room';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Add Details"),
    ),
    body: SafeArea(child: 
    ListView(
      padding: const EdgeInsets.all(20),
      children: [
      Container(decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 250,
      child: Column(
        children:const [ SizedBox(height: 65),
          Text("Upload photos here"),
          SizedBox(height: 7,),
           Icon(Icons.add_a_photo_outlined,
          size: 100,color: Colors.grey,),
        ],
      ),
      ),
              SizedBox(
                height: 10,
              ),
              Text('Category'),
              Card(
                  child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Single Room',
                  'Chamber and Hall',
                  'Two Bedroom',
                  'Two Bedroom Plus',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
    ],)),
      
    );
  }
}