import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';

class SignupLandlord extends StatefulWidget {
  const SignupLandlord({Key? key}) : super(key: key);

  @override
  State<SignupLandlord> createState() => _SignupLandlordState();
}

class _SignupLandlordState extends State<SignupLandlord> {
  String dropdownValue = 'Male';
  File? imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  final AuthManager _authManager = AuthManager();
  bool _isLoading = false;

  Future selectedImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? profilePic = await _imagePicker.pickImage(source: imageSource);
    File profileImageFile = File(profilePic!.path);

    setState(() {
      imageFile = profileImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Your Account',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          height: 130,
                          width: 130,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/Profile_avatar.png',
                          height: 130,
                          width: 130,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 100,
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  selectedImage(
                                      imageSource: ImageSource.camera);
                                },
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Select to take Selfie')),
                          );
                        });
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Please take a selfie')),
              Text('Full name'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your full name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('E-mail'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your E-mail',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (!emailRegExp.hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    if (value.isEmpty) {
                      return 'Please enter Email';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Password'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    label: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your your location',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please password is required';
                    }
                    if (value.length < 6) {
                      return 'Password should not be less than 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Gender'),
              SizedBox(height: 5),
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
                  'Male',
                  'Female',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
              SizedBox(
                height: 10,
              ),
              Text('Location/Digital Address'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _locationController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your location/ Digital Address',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Phone Number'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your phone number',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'PLease enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'phone number should not be less than 10';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Nationality'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _nationalityController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Ghanaian',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your nationality';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : TextButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            String name = _nameController.text;
                            String email = _emailController.text.trim();
                            String phone = _phoneController.text;
                            String password = _passwordController.text;
                            String location = _locationController.text;
                            String nationality = _nationalityController.text;
                            String gender = dropdownValue.toString();

                            setState(() {
                              _isLoading = true;
                            });
                            bool isCreated = await _authManager.createLandlord(
                                name: name,
                                email: email,
                                password: password,
                                gender: gender,
                                location: location,
                                number: phone,
                                nationality: nationality,
                                imageFile: imageFile!);
                            if (isCreated) {
                              //success
                              Fluttertoast.showToast(
                                  msg: "$name, Welcome to Lets Accommodate",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 94, 196, 97),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginLandlord()),
                                  (route) => false);
                            } else {
                              //failure
                              Fluttertoast.showToast(
                                  msg: _authManager.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please check all fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
