import 'package:flutter/material.dart';

class EditDescription extends StatefulWidget {
  const EditDescription({Key? key}) : super(key: key);

  @override
  State<EditDescription> createState() => _EditDescriptionState();
}

class _EditDescriptionState extends State<EditDescription> {
  String dropdownValue = 'Single Room';
  String dropdownValue1 = 'Available';
  String dropdownValue2 = 'Yes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Description')),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 250,
            child: Column(
              children: const [
                SizedBox(height: 65),
                Text("Upload photos here"),
                SizedBox(
                  height: 7,
                ),
                Icon(
                  Icons.add_a_photo_outlined,
                  size: 15,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Category',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
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
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Type',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
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
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Kitchen',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Washroom',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Store Room',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Porch',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Walled',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue2,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
            items: <String>[
              'Yes',
              'No',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Tiled',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue2,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
            items: <String>[
              'Yes',
              'No',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Electricity',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Water',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Card(
              child: DropdownButton<String>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            items: <String>[
              'Available',
              'Unavailable',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Update',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Delete',
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
          ),
        ],
      )),
    );
  }
}
