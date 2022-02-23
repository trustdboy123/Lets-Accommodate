import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileTenant extends StatefulWidget {
  const EditProfileTenant({Key? key}) : super(key: key);

  @override
  State<EditProfileTenant> createState() => _EditProfileTenantState();
}

class _EditProfileTenantState extends State<EditProfileTenant> {
  File? _profilePic;
  final ImagePicker _imagePicker = ImagePicker();

  Future selectImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? profilePic = await _imagePicker.pickImage(source: imageSource);
    File profileImage = File(profilePic!.path);

    setState(() {
      _profilePic = profileImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: _profilePic == null
                        ? Image.asset(
                            'assets/Profile_avatar.png',
                            width: 130,
                            height: 130,
                            fit: BoxFit.contain,
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
                                          imageSource: ImageSource.camera);
                                    },
                                    icon: Icon(Icons.camera_alt),
                                    label: Text('Select from camera')),
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      selectImage(
                                          imageSource: ImageSource.gallery);
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'George Amankwa',
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
                    'bernicemens@gmail.com',
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
              child: TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your location',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                    'Female',
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
                    'Ghanaian',
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
                    'Ghanaian',
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
                  onPressed: () {},
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
