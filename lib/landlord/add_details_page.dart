import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddDetailsView extends StatefulWidget {
  AddDetailsView({Key? key}) : super(key: key);

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

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
  List<XFile>? imageFileList;

  openImages() async {
    try {
      var pickedfiles = await _imagePicker.pickMultiImage();
      if (pickedfiles != null) {
        imageFileList = pickedfiles;
      } else {
        print('No images selected');
      }
    } catch (e) {
      print('essror wile picking file $e');
    }
  }

  // Future selectImage({ImageSource imageSource = ImageSource.gallery}) async {
  //   final List<XFile>? _houseImages = await _imagePicker.pickMultiImage();

  //   setState(() {
  //     _imageFileList = _houseImages;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
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
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 250,
                child: Column(
                  children: [
                    SizedBox(height: 65),
                    const Text("Upload photos here"),
                    const SizedBox(
                      height: 10,
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
                                        openImages();
                                        // selectImage(
                                        //     imageSource:
                                        //         ImageSource.gallery);
                                      },
                                      icon: Icon(Icons.photo_album),
                                      label: Text('Select from Gallery')),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          size: 100,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
              //  Expanded(
              //     child: buildGridView()),

              const SizedBox(
                height: 10,
              ),
              imageFileList != null
                  ? Wrap(
                      children: imageFileList!.map((imageone) {
                        return Container(
                          child: Card(
                              child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(File(imageone.path)),
                          )),
                        );
                      }).toList(),
                    )
                  : Card(
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
                      ].map<DropdownMenuItem<String>>((String value) {
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                      ].map<DropdownMenuItem<String>>((String value) {
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                      ].map<DropdownMenuItem<String>>((String value) {
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        )]))));
      
    
  }
}
