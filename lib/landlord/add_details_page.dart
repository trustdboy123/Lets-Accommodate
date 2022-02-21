
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddDetailsView extends StatefulWidget {
  AddDetailsView({Key? key}) : super(key: key);

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {

  String dropdownValue = 'Select option';
  String dropdownValueType = 'Select option';
  String dropdownValueKitchen = 'Select option';
  String dropdownValueToiletRoom = 'Select option';
  String dropdownValueBathRoom = 'Select option';
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

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _imageFileList = [];

  //  set _imageFile(XFile? value) {
  //   _imageFileList = value == null ? null : <XFile>[value];
  // }

  Future selectImage({ImageSource imageSource = ImageSource.gallery}) async {
    final List<XFile>? _houseImages = await _imagePicker.pickMultiImage();
 // _imageFileList!.addAll(_houseImages);
    setState(() {
      _imageFileList = _houseImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: SafeArea(

        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _imageFileList == null
                  ? Container(
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 250,
                      child: Column(
                        children: [
                          SizedBox(height: 65),
                          Text("Upload photos here"),
                          SizedBox(
                            height: 7,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 100,
                                        child: TextButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              selectImage(
                                                  imageSource:
                                                      ImageSource.gallery);
                                            },
                                            icon: Icon(Icons.photo_album),
                                            label: Text('Select from Gallery')),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size: 100,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Image.file(
                                File(_imageFileList![index].path));
                          })),
              SizedBox(
                height: 10,
              ),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type'),
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
                      'Self Contained House',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              const SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kitchen'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Toiletroom'),
                  DropdownButtonFormField(
                    value: dropdownValueToiletRoom,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueToiletRoom = newValue!;
                      });
                    },
                    items: <String>[
                      'Select option',
                      'Available',
                      'Unavailable',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bathroom'),
                  DropdownButtonFormField(
                    value: dropdownValueBathRoom,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueBathRoom = newValue!;
                      });
                    },
                    items: <String>[
                      'Select option',
                      'Available',
                      'Unavailable',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Storeroom'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Porch'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Walled House'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tiled House'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Electricity'),
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
                      'Available',
                      'Unavailable',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Water Availability'),
                  DropdownButtonFormField(
                    value: dropdownValueWaterAvailability,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueWaterAvailability = newValue!;
                      });
                    },
                    items: <String>[
                      'Select option',
                      'Yes',
                      'No',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Price',
                      hintText: 'Enter Price of Rent')),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Size',
                      hintText: 'Enter Size of Room')),
              SizedBox(height: 5),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Region'),
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'City/Town',
                  )),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _digitalAddressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Digital Address',
                      hintText: 'GN-1234-5678')),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _houseNumberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'House Number',
                  )),
              const SizedBox(
                height: 7,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              )
            ],
          ),
        ),
      ),);
  }}
