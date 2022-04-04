import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/settings%20tenant/settings_tenant.dart';

class EditProfileLandlord extends StatefulWidget {
  const EditProfileLandlord({Key? key}) : super(key: key);

  @override
  State<EditProfileLandlord> createState() => _EditProfileLandlordState();
}

class _EditProfileLandlordState extends State<EditProfileLandlord> {
  File? _profilePic;
  final ImagePicker _imagePicker = ImagePicker();
  final PostManager _postManager = PostManager();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future selectImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? profilePic = await _imagePicker.pickImage(source: imageSource);
    File profileImage = File(profilePic!.path);

    setState(() {
      _profilePic = profileImage;
    });
  }

  // isUserAuth() {
  //   _firebaseAuth.authStateChanges().listen((user) {
  //     if (user != null) {
  //       print(user.uid);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<Map<String, dynamic>?>(
            stream: _postManager.getUserInfo(uid).asStream(),
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
              return ListView(
                children: [
                  Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: _profilePic == null
                              ? Image.network(
                                  snapshot.data!['picture'],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.fill,
                                )
                              : InkWell(
                                  onTap: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) => SizedBox(
                                            height: 100,
                                          )),
                                  child: Image.file(
                                    _profilePic!,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 100,
                                    child: Column(children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            selectImage(
                                                imageSource:
                                                    ImageSource.camera);
                                          },
                                          icon: Icon(Icons.camera_alt),
                                          label: Text('Select from camera')),
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            selectImage(
                                                imageSource:
                                                    ImageSource.gallery);
                                          },
                                          icon: Icon(Icons.browse_gallery),
                                          label: Text('Select from gallery'))
                                    ]),
                                  );
                                });
                          },
                          child: Text('Edit Photo'))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Full Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!['name'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'E-mail',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![' email'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!['location'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!['gender'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!['number'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nationality',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!['nationality'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        onPressed: () async {
                          bool isUpdated = await _postManager.updateTenantInfo(
                              imageFile: _profilePic!);
                          if (isUpdated) {
                            Fluttertoast.showToast(
                                msg: "Profile Pic Updated successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 94, 196, 97),
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SettingsTenant()),
                                (route) => false);
                          } else {
                            Fluttertoast.showToast(
                                msg: _postManager.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              );
            }),
      ),
    );
  }
}
