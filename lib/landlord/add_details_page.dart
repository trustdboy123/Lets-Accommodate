import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_accommodate/landlord/payments/pay_decision.dart';
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
  String dropdownValueKitchen = 'Unavailable';
  String dropdownValueWashRoom = 'Unavailable';
  String dropdownValueStoreRoom = 'Unavailable';
  String dropdownValuePorch = 'Unavailable';
  String dropdownValueWaledHouse = 'Unavailable';
  String dropdownValueTiledHouse = 'Unavailable';
  String dropdownValueElectricity = 'Unavailable';
  String dropdownValueWaterAvailability = 'Unavailable';
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: GridView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.all(4),
                      child: GridView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _image.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Column(
                                    children: [
                                      Center(
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              color: Colors.blueAccent,
                                            ),
                                            onPressed: () => chooseImage()),
                                      ),
                                      Text(
                                        'Tap to add photos',
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      )
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(_image[index - 1]),
                                            fit: BoxFit.fill)),
                                  );
                          }),
                    ),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueType,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                      'Hostel'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Kitchen',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueKitchen,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Washroom',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueWashRoom,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Store Room',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueStoreRoom,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Porch',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValuePorch,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Walled House',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueWaledHouse,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tiled House',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueTiledHouse,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Electricity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueElectricity,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Water Availability',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueWaterAvailability,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                              child: TextFormField(
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'Price',
                                      labelStyle: TextStyle(fontSize: 12.sp),
                                      hintStyle: TextStyle(fontSize: 12.sp),
                                      hintText: 'Enter Price/ month of Rent')),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                              child: TextFormField(
                                  controller: _sizeController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'Size',
                                      labelStyle: TextStyle(fontSize: 12.sp),
                                      hintStyle: TextStyle(fontSize: 12.sp),
                                      hintText: 'Enter Size of Room')),
                            ),
                            SizedBox(height: 5.h),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Region',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'Select option') {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                    value: dropdownValueRegion,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
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
                                        child: Text(value,
                                            style: TextStyle(fontSize: 12.sp)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                              child: TextFormField(
                                  controller: _cityController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'City/Town',
                                      hintText: 'Koforidua',
                                      hintStyle: TextStyle(fontSize: 12.sp),
                                      labelStyle: TextStyle(fontSize: 12.sp))),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                              child: TextFormField(
                                  controller: _digitalAddressController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'Digital Address',
                                      labelStyle: TextStyle(fontSize: 12.sp),
                                      hintStyle: TextStyle(fontSize: 12.sp),
                                      hintText: 'GN-1234-5678')),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Card(
                              child: TextFormField(
                                  controller: _houseNumberController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'House Number',
                                      labelStyle: TextStyle(fontSize: 12.sp))),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 4, 82, 146)),
                                      onPressed: () async {
                                        var category = dropdownValue.toString();
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          bool isSubmited =
                                              await _postManager.submitPost(
                                            postImage: _image,
                                            category: dropdownValue.toString(),
                                            type: dropdownValueType.toString(),
                                            electricity:
                                                dropdownValueElectricity
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
                                            washroom: dropdownValueWashRoom
                                                .toString(),
                                            storeRoom: dropdownValueStoreRoom
                                                .toString(),
                                            porch:
                                                dropdownValuePorch.toString(),
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
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Color.fromARGB(
                                                  255, 237, 72, 72),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return PayDecision(
                                            price: category == 'Hostel'
                                                ? 30
                                                : category == 'Single Room'
                                                    ? 40
                                                    : category ==
                                                            'Chamber and Hall'
                                                        ? 60
                                                        : category ==
                                                                'Two Bedroom'
                                                            ? 80
                                                            : 100,
                                          );
                                        }));
                                      },
                                      child: Text('Proceed to pay',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                          )),
                                    ))),
                            // SizedBox(
                            //   height: .h,
                            // )
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
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
