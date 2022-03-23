import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/settings%20tenant/edit_profile_tenant.dart';
import 'package:path/path.dart';

class SettingsLandlord extends StatefulWidget {
  const SettingsLandlord({Key? key}) : super(key: key);

  @override
  State<SettingsLandlord> createState() => _SettingsLandlordState();
}

class _SettingsLandlordState extends State<SettingsLandlord> {
  String dropdownValuemail = '';
  PostManager _postManager = PostManager();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (Context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.network(
                                          snapshot.data!['profile_pic']),
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data!['profile_pic']),
                            radius: 100,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return EditProfileTenant();
                                }));
                              },
                              child: Text(
                                'Edit profile',
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                        Text(
                          snapshot.data!['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView(
                                padding: EdgeInsets.all(16),
                                children: const [
                                  Icon(
                                    Icons.email,
                                    size: 100,
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Email: letsaccommodateof4@gmail.com',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.facebook_rounded,
                                    size: 100,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Facebook: Letsaccommodate Mobile app',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Card(
                        color: Color.fromARGB(255, 186, 203, 231),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: const [
                              Text(
                                'Need help',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.help,
                                color: Colors.black,
                              ),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: TextButton(
                          onPressed: () async {
                            _firebaseAuth.signOut();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 20),
                          )),
                    )
                  ],
                );
              }),
        ));
  }
}
