import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_accommodate/landlord/landlord_dashboard.dart';
import 'package:lets_accommodate/services/post_manager.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class EditDescription extends StatefulWidget {
  const EditDescription({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  State<EditDescription> createState() => _EditDescription();
}

class _EditDescription extends State<EditDescription> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _digitalAddressController =
      TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  final PostManager _postManager = PostManager();

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? imageFileList;

  final PageController _pageController = PageController();
  var _currentPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  openImages() async {
    try {
      var pickedfiles = await _imagePicker.pickMultiImage();
      if (pickedfiles != null) {
        setState(() {
          imageFileList = pickedfiles;
        });
      } else {
        print('No images selected');
      }
    } catch (e) {
      print('essror wile picking file $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Description"),
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
            stream: _postManager.getRoomDetails(docID: widget.docId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return const Center(
                  child: Text('No data is available'),
                );
              }
              String dropdownValue = snapshot.data!.data()!['category'];
              String dropdownValueType = snapshot.data!.data()!['type'];
              String dropdownValueKitchen = snapshot.data!.data()!['kitchen'];
              String dropdownValueWashRoom = snapshot.data!.data()!['washroom'];
              String dropdownValueStoreRoom =
                  snapshot.data!.data()!['store Room'];
              String dropdownValuePorch = snapshot.data!.data()!['porch'];
              String dropdownValueWaledHouse =
                  snapshot.data!.data()!['walled House'];
              String dropdownValueTiledHouse = snapshot.data!.data()!['tiled'];
              String dropdownValueElectricity =
                  snapshot.data!.data()!['electricity'];
              String dropdownValueWaterAvailability =
                  snapshot.data!.data()!['water Availability'];
              String dropdownValueRegion = snapshot.data!.data()!['region'];
              _priceController.text = snapshot.data!.data()!['price'];
              _sizeController.text = snapshot.data!.data()!['size'];
              _cityController.text = snapshot.data!.data()!['city/Town'];
              _digitalAddressController.text =
                  snapshot.data!.data()!['digital Address'];
              _houseNumberController.text =
                  snapshot.data!.data()!['house Number'];
              var pictures = snapshot.data!.data()!['pictures'];

              return SafeArea(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            Container(
                                height: 250,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: pictures.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 240,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        color: Colors.black,
                                        child: Image.network(
                                          pictures[index],
                                          fit: BoxFit.fitWidth,
                                          height: 250,
                                          width: double.infinity,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            DotsIndicator(
                              dotsCount: pictures.length,
                              position: _currentPageValue,
                              decorator: DotsDecorator(
                                  color: Colors.black87,
                                  activeColor: Colors.blueAccent,
                                  activeSize: const Size(18.0, 9.0),
                                  size: const Size.square(9.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                                    openImages();
                                                  },
                                                  icon: const Icon(
                                                    Icons.photo_album,
                                                    color: Colors.blue,
                                                  ),
                                                  label: const Text(
                                                      'Select from Gallery')),
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.camera_alt)),
                                const Text('Upload Photos')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Category',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      DropdownButtonFormField(
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Type',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueType,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Kitchen',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueKitchen,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Washroom',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueWashRoom,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Store Room',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueStoreRoom,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Porch',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValuePorch,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Walled House',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueWaledHouse,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tiled House',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueTiledHouse,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Electricity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueElectricity,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValueElectricity =
                                                newValue!;
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Water Availability',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueWaterAvailability,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: "price",
                                        hintText: 'Enter new price of rent')),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: _sizeController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: "size",
                                        hintText: 'Enter new size of room')),
                                const SizedBox(height: 10),
                                Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Region',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      DropdownButtonFormField(
                                        value: dropdownValueRegion,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: 'city',
                                        hintText: 'Enter new city')),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: _digitalAddressController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: "digitalAddress",
                                        hintText: 'Enter digital address')),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: _houseNumberController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: 'houseNumber',
                                        hintText: 'Enter new house number')),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        print(widget.docId);
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: const Text(
                                                    'Are you sure you want to update House Info?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      bool isUpadted =
                                                          await _postManager
                                                              .updateRoomDetails(
                                                        docID: widget.docId,
                                                        electricity:
                                                            dropdownValueElectricity,
                                                        waterAvailability:
                                                            dropdownValueWaterAvailability
                                                                .toString(),
                                                        price: _priceController
                                                            .text,
                                                        size: _sizeController
                                                            .text,
                                                        region:
                                                            dropdownValueRegion
                                                                .toString(),
                                                        citytown:
                                                            _cityController
                                                                .text,
                                                        houseNumber:
                                                            _houseNumberController
                                                                .text,
                                                        washroom:
                                                            dropdownValueWashRoom
                                                                .toString(),
                                                        storeRoom:
                                                            dropdownValueStoreRoom
                                                                .toString(),
                                                        porch:
                                                            dropdownValuePorch
                                                                .toString(),
                                                        walledHouse:
                                                            dropdownValueWaledHouse
                                                                .toString(),
                                                        kitchen:
                                                            dropdownValueKitchen
                                                                .toString(),
                                                        tiled:
                                                            dropdownValueTiledHouse
                                                                .toString(),
                                                        digitalAddress:
                                                            _digitalAddressController
                                                                .text,
                                                      );
                                                      if (isUpadted) {
                                                        Navigator.of(context)
                                                            .pop(isUpadted);
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Details updated successfully!",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    94,
                                                                    196,
                                                                    97),
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg: _postManager
                                                                .message,
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blueAccent),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    onPressed: () async {
                                      showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text(
                                                  'Are you sure you want to delete?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    bool isDeleted =
                                                        await _postManager
                                                            .deleteRoom(
                                                                docID: widget
                                                                    .docId);
                                                    if (isDeleted) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Details deleted successfully!",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  94,
                                                                  196,
                                                                  97),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  DashboardView()));
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg: _postManager
                                                              .message,
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text('Cancel'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.redAccent),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          ])));
            }));
  }
}
