import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:path/path.dart' as Path;

import 'landlord_dashboard.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String _error = 'No Error Dectected';

  String dropdownValue = 'Select option';

  String dropdownValueType = 'Select option';
  String dropdownValueKitchen = 'Select option';
  String dropdownValueWashRoom = 'Select option';
  String dropdownValueStoreRoom = 'Select option';
  String dropdownValuePorch = 'Select option';
  String dropdownValueWaledHouse = 'Select option';
  String dropdownValueTiledHouse = 'Select option';
  String dropdownValueElectricity = 'Select option';
  String dropdownValueWaterAvailability = 'Select option';
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  String dropdownValueRegion = 'Select option';
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _digitalAddressController =
      TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  final AuthManager _authManager = AuthManager();
  final PostManager _postManager = PostManager();
  bool isLoading = false;

  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Details'),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    padding: const EdgeInsets.all(4),
                    child: GridView.builder(
                        itemCount: _image.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: IconButton(
                                      icon: Icon(Icons.add_a_photo),
                                      onPressed: () => chooseImage()),
                                )
                              : Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_image[index - 1]),
                                          fit: BoxFit.cover)),
                                );
                        }),
                  ),
                  uploading
                      ? Center(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text(
                                'uploading...',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(
                              value: val,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            )
                          ],
                        ))
                      : Container(),
                  ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Category',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonFormField(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Single Room',
                                    'Chamber and Hall',
                                    'Two Bedroom',
                                    'Two Bedroom Plus',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueType,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueType = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Apartment',
                                    'Flat',
                                    'Compound House',
                                    'Self Contained',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Kitchen',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueKitchen,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueKitchen = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Available',
                                    'Unavailable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Washroom',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueWashRoom,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueWashRoom = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Available',
                                    'Unavailable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Store Room',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueStoreRoom,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueStoreRoom = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Available',
                                    'Unavailable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Porch',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValuePorch,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValuePorch = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Available',
                                    'Unavailable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Walled House',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueWaledHouse,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueWaledHouse = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Yes',
                                    'No',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tiled House',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueTiledHouse,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueTiledHouse = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Yes',
                                    'No',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 5),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Electricity',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueElectricity,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueElectricity = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Available, Shared meter',
                                    'Available, Unshared meter',
                                    'Unavailable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Water Availability',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueWaterAvailability,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueWaterAvailability =
                                          newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Yes',
                                    'No',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Price',
                                  hintText: 'Enter Price of Rent')),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: _sizeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Size',
                                  hintText: 'Enter Size of Room')),
                          const SizedBox(height: 10),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Region',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButtonFormField(
                                  value: dropdownValueRegion,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueRegion = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select option',
                                    'Ashanti Region',
                                    'Ahafo Region',
                                    'Bono East',
                                    'Central Region',
                                    'Eastern Region',
                                    'Greater Accra',
                                    'Northern Region',
                                    'North East',
                                    'Oti Region',
                                    'Savannah Region',
                                    'Upper East Region',
                                    'Upper West Region',
                                    'Volta Region',
                                    'Western Region',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: _cityController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'City/Town',
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: _digitalAddressController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Digital Address',
                                  hintText: 'GN-1234-5678')),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: _houseNumberController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'House Number',
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        bool isSubmited =
                                            await _postManager.submitPost(
                                          postImage: _image,
                                          category: dropdownValue.toString(),
                                          type: dropdownValueType.toString(),
                                          electricity: dropdownValueElectricity
                                              .toString(),
                                          waterAvailability:
                                              dropdownValueWaterAvailability
                                                  .toString(),
                                          price: _priceController.text,
                                          size: _sizeController.text,
                                          region:
                                              dropdownValueRegion.toString(),
                                          citytown: _cityController.text,
                                          houseNumber:
                                              _houseNumberController.text,
                                          washroom:
                                              dropdownValueWashRoom.toString(),
                                          storeRoom:
                                              dropdownValueStoreRoom.toString(),
                                          porch: dropdownValuePorch.toString(),
                                          walledHouse: dropdownValueWaledHouse
                                              .toString(),
                                          kitchen:
                                              dropdownValueKitchen.toString(),
                                          tiled: dropdownValueTiledHouse
                                              .toString(),
                                          digitalAddress:
                                              _digitalAddressController.text,
                                        );
                                        if (isSubmited) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "House Uploaded successfully",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 94, 196, 97),
                                              textColor: Colors.white,
                                              fontSize: 16.0);

                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardView()),
                                                  (route) => false);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: _postManager.message,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } else {
                                        // validation failed
                                        Fluttertoast.showToast(
                                            msg: " Please Check all fields",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 94, 196, 97),
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: const Text(
                                      'Upload',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                  ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      )
                    ],
                  )
                ]),
          ),
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }
}
